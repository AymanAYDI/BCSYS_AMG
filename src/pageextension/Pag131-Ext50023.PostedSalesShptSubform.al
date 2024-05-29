namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;

pageextension 50023 "PostedSalesShptSubform" extends "Posted Sales Shpt. Subform" //131
{
    //TODO cannot be customized
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
                ApplicationArea = All;
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
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
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
            field("No. Colis"; Rec."No. Colis")
            {
                Lookup = true;
                DrillDown = false;
                TableRelation = Colis."No." where("No." = field("No. Colis"));
                LookupPageID = Colis;
                ApplicationArea = All;
                trigger OnValidate()
                var
                    LRecColis: Record Colis;
                    LRecColisage: Record Colisage;
                    LNoColis: Code[20];
                begin
                    if (xRec."No. Colis" <> Rec."No. Colis") and (xRec."No. Colis" <> '') then begin
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

                    CurrPage.UPDATE();
                end;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            group(Colis)
            {
                Caption = 'Colis', Comment = 'FRA="Colis"';
                Image = NewItem;
                action("Create Package")
                {
                    Caption = 'Create Package', Comment = 'FRA="Créer Colis"';
                    AccessByPermission = TableData "Sales Shipment Line" = RIM;
                    Image = Item;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        LRecColis: Record Colis;
                        LRecSalesShipmentLine: Record "Sales Shipment Line";
                        LRecColisage: Record Colisage;
                        LRecColis2: Record Colis;
                        LIntNbColis: Integer;
                        LIntI: Integer;
                    begin
                        CurrPage.SETSELECTIONFILTER(LRecSalesShipmentLine);

                        if LRecSalesShipmentLine.FINDFIRST() then
                            if LRecSalesShipmentLine."No. Colis" <> '' then
                                ERROR('Un Numéro de colis est déja atribué à cette ligne, veuillez le supprimer ou sélectionnez une autre ligne')
                            else begin
                                LRecColis.INIT();
                                LRecColis."No. expedition" := LRecSalesShipmentLine."Document No.";
                                LRecColis.INSERT(true);

                                LRecColisage.INIT();
                                LRecColisage."No." := LRecColis."No.";
                                LRecColisage."No. ligne" := 1;
                                LRecColisage."No. expedition" := LRecSalesShipmentLine."Document No.";
                                LRecColisage."No. ligne expedition" := LRecSalesShipmentLine."Line No.";
                                LRecColisage."No. article" := LRecSalesShipmentLine."No.";
                                LRecColisage.Quantite := LRecSalesShipmentLine.Quantity;
                                LRecColisage.INSERT(true);

                                LRecSalesShipmentLine."No. Colis" := LRecColis."No.";
                                LRecSalesShipmentLine.MODIFY();

                                LRecColis."Poids net" := LRecColisage.FCalcPoidsNetColis(LRecColis."No.");
                                LRecColis.MODIFY();
                                COMMIT();
                                //DELPHI AUB 05.07.2021
                                LIntI := 1;
                                LRecColis2.RESET();
                                LRecColis2.SETFILTER("No. expedition", LRecColis."No. expedition");
                                LIntNbColis := LRecColis2.COUNT;
                                //IF LRecColis2.FINDFIRST THEN
                                //LRecColis."R‚f‚rence Colis" := FORMAT(LIntNbColis) + '/' + FORMAT(LIntNbColis);


                                if LRecColis2.FIND('-') then
                                    repeat
                                        LRecColis2."Reference Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                                        LRecColis2.MODIFY();
                                        COMMIT();
                                        LIntI += 1;
                                    until LRecColis2.NEXT() <= 0;

                                //END DELPHI AUB
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
