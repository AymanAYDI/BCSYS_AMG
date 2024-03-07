namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;
using BCSYS.AMGALLOIS.Basic;

pageextension 50023 "PostedSalesShptSubform" extends "Posted Sales Shpt. Subform" //131
{
    //todo cannot be customized
    // InsertAllowed =false;
    // DeleteAllowed =false;
    // ModifyAllowed =true;
    layout
    {
        modify("No.")
        {
            Enabled = false;
        }
        addafter("No.")
        {
            field("Code ONU"; rec."Code ONU")
            {
                TableRelation = "ONU table".Code;
                Editable = false;
            }
        }
        modify("Variant Code")
        {
            Enabled = false;
        }
        modify(Description)
        {
            Enabled = false;
        }
        modify("Return Reason Code")
        {
            Enabled = false;
        }
        modify("Location Code")
        {
            Enabled = false;
        }
        modify("Bin Code")
        {
            Enabled = false;
        }
        modify(Quantity)
        {
            Enabled = false;
        }
        modify("Unit of Measure Code")
        {
            Enabled = false;
        }
        modify("Unit of Measure")
        {
            Enabled = false;
        }
        modify("Quantity Invoiced")
        {
            Enabled = false;
        }
        modify("Qty. Shipped Not Invoiced")
        {
            Enabled = false;
        }
        modify("Requested Delivery Date")
        {
            Enabled = false;
        }
        modify("Promised Delivery Date")
        {
            Enabled = false;
        }
        modify("Planned Delivery Date")
        {
            Enabled = false;
        }
        modify("Shipment Date")
        {
            Editable = false;
        }
        modify("Job No.")
        {
            Enabled = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Enabled = false;
        }
        addafter("Appl.-to Item Entry")
        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {

            }
            field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {

            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Enabled = false;
        }
        addafter("ShortcutDimCode[8]")
        {
            field("N° Colis"; rec."N° Colis")
            {
                Lookup = true;
                DrillDown = false;
                TableRelation = Colis."N°" where("N°" = field("N° Colis"));
                LookupPageID = Colis;
                trigger OnValidate()
                var
                    LRecColis: Record 50009;
                    LRecColisage: Record 50010;
                    LNoColis: Code[20];
                begin
                    if (xRec."N° Colis" <> Rec."N° Colis") and (xRec."N° Colis" <> '') then begin
                        LRecColisage.SETRANGE("N° expédition", Rec."Document No.");
                        LRecColisage.SETRANGE("N° ligne expédition", Rec."Line No.");
                        if LRecColisage.FINDFIRST() then begin
                            LNoColis := LRecColisage."N°";
                            LRecColisage.DELETE(true);
                            CLEAR(LRecColis);
                            if LRecColis.GET(LNoColis) then begin
                                LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LNoColis);
                                LRecColis.MODIFY();
                            end;
                        end;
                    end;

                    if Rec."N° Colis" <> '' then begin
                        CLEAR(LRecColisage);
                        LRecColisage.INIT();
                        LRecColisage."N°" := Rec."N° Colis";
                        LRecColisage."N° ligne" := LRecColisage.NextLineNo(Rec."N° Colis");
                        LRecColisage."N° expédition" := Rec."Document No.";
                        LRecColisage."N° ligne expédition" := Rec."Line No.";
                        LRecColisage."N° article" := Rec."No.";
                        LRecColisage.Quantité := Rec.Quantity;
                        LRecColisage.INSERT(true);
                        CLEAR(LRecColis);
                        if LRecColis.GET(Rec."N° Colis") then begin
                            LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LRecColis."N°");
                            LRecColis.MODIFY();
                        end;
                    end;

                    CurrPage.UPDATE();
                end;
            }
        }
    }
    actions
    {
        addafter("&Line")
        {
            group(Colis)
            {
                Image = NewItem;
                action("Create Colis")
                {
                    Image = Item;
                    trigger OnAction()
                    var
                        LRecColis: Record 50009;
                        LRecSalesShipmentLine: Record 111;
                        LRecColisage: Record 50010;
                        LRecColis2: Record 50009;
                        LIntNbColis: Integer;
                        LIntI: Integer;
                    begin
                        CurrPage.SETSELECTIONFILTER(LRecSalesShipmentLine);

                        if LRecSalesShipmentLine.FINDFIRST() then
                            if LRecSalesShipmentLine."N° Colis" <> '' then
                                ERROR('Un Numéro de colis est déja atribué … cette ligne, veuillez le supprimer ou s‚lectionnez une autre ligne')
                            else begin
                                LRecColis.INIT();
                                LRecColis."N° expédition" := LRecSalesShipmentLine."Document No.";
                                LRecColis.INSERT(true);

                                LRecColisage.INIT();
                                LRecColisage."N°" := LRecColis."N°";
                                LRecColisage."N° ligne" := 1;
                                LRecColisage."N° expédition" := LRecSalesShipmentLine."Document No.";
                                LRecColisage."N° ligne expédition" := LRecSalesShipmentLine."Line No.";
                                LRecColisage."N° article" := LRecSalesShipmentLine."No.";
                                LRecColisage."Quantité" := LRecSalesShipmentLine.Quantity;
                                LRecColisage.INSERT(true);

                                LRecSalesShipmentLine."N° Colis" := LRecColis."N°";
                                LRecSalesShipmentLine.MODIFY();

                                LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LRecColis."N°");
                                LRecColis.MODIFY();
                                COMMIT();
                                LIntI := 1;
                                LRecColis2.RESET();
                                LRecColis2.SETFILTER("N° expédition", LRecColis."N° expédition");
                                LIntNbColis := LRecColis2.COUNT;
                                if LRecColis2.FIND('-') then
                                    repeat
                                        LRecColis2."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                                        LRecColis2.MODIFY();
                                        COMMIT();
                                        LIntI += 1;
                                    until LRecColis2.NEXT() <= 0;
                            end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Code ONU");
    end;
}
