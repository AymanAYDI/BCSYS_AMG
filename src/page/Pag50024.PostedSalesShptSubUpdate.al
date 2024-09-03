namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
page 50024 "Posted Sales Shpt. Sub Update"
{
    Caption = 'Posted Sales Shipment - Update', Comment = 'FRA="Expédition vente enregistrée - Mise à jour"';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Sales Shipment Line";
    SourceTableTemporary = true;
    UsageCategory = None;
    Permissions = TableData "Sales Shipment Line" = rm;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', Comment = 'FRA="Livraison"';
                field("No. Colis"; Rec."No. Colis")
                {
                    Lookup = true;
                    DrillDown = false;
                    TableRelation = Colis."No." where("No." = field("No. Colis"));
                    LookupPageID = Colis;
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        xSalesShipmentLine := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = ACTION::LookupOK then
            if RecordChanged() then begin
                CODEUNIT.Run(CODEUNIT::"AMG Shipment Line - Edit", Rec);
                UpdateColis();
            end;
    end;

    var
        xSalesShipmentLine: Record "Sales Shipment Line";

    local procedure RecordChanged() IsChanged: Boolean
    begin
        IsChanged :=
          (Rec."No. Colis" <> xSalesShipmentLine."No. Colis");

    end;

    local procedure UpdateColis()
    var
        LRecColis: Record Colis;
        LRecColisage: Record Colisage;
        LNoColis: Code[20];
    begin
        if (xSalesShipmentLine."No. Colis" <> Rec."No. Colis") and (xSalesShipmentLine."No. Colis" <> '') then begin
            LRecColisage.SETRANGE("No. expedition", Rec."Document No.");
            LRecColisage.SETRANGE("No. ligne expedition", Rec."Line No.");
            if LRecColisage.FINDFIRST() then begin
                LNoColis := LRecColisage."No.";
                LRecColisage.DELETE(true);
                CLEAR(LRecColis);
                if LRecColis.GET(LNoColis) then begin
                    LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LNoColis);
                    LRecColis.MODIFY();
                end;
            end;
        end;

        if Rec."No. Colis" <> '' then begin
            CLEAR(LRecColisage);
            LRecColisage.INIT();
            LRecColisage."No." := Rec."No. Colis";
            LRecColisage."No. ligne" := LRecColisage.NextLineNo(Rec."No. Colis");
            LRecColisage."No. expedition" := Rec."Document No.";
            LRecColisage."No. ligne expedition" := Rec."Line No.";
            LRecColisage."No. article" := Rec."No.";
            LRecColisage.Quantite := Rec.Quantity;
            LRecColisage.INSERT(true);
            CLEAR(LRecColis);
            if LRecColis.GET(Rec."No. Colis") then begin
                LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LRecColis."No.");
                LRecColis.MODIFY();
            end;
        end;
    end;

    procedure SetRec(SalesShipmentLine: Record "Sales Shipment Line")
    begin
        Rec := SalesShipmentLine;
        Rec.Insert();
    end;
}
