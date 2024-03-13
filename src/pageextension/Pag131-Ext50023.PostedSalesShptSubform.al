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
            field("N° Package"; rec."N° Package")
            {
                Lookup = true;
                DrillDown = false;
                TableRelation = Package."Package No." where("Package No." = field("N° Package"));
                LookupPageID = Package;
                trigger OnValidate()
                var
                    LRecColis: Record 50009;
                    LRecColisage: Record 50010;
                    LNoColis: Code[20];
                begin
                    if (xRec."N° Package" <> Rec."N° Package") and (xRec."N° Package" <> '') then begin
                        LRecColisage.SETRANGE("Shipping No.", Rec."Document No.");
                        LRecColisage.SETRANGE("Shipping Line No.", Rec."Line No.");
                        if LRecColisage.FINDFIRST() then begin
                            LNoColis := LRecColisage."Package No.";
                            LRecColisage.DELETE(true);
                            CLEAR(LRecColis);
                            if LRecColis.GET(LNoColis) then begin
                                LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LNoColis);
                                LRecColis.MODIFY();
                            end;
                        end;
                    end;

                    if Rec."N° Package" <> '' then begin
                        CLEAR(LRecColisage);
                        LRecColisage.INIT();
                        LRecColisage."Package No." := Rec."N° Package";
                        LRecColisage."Line No." := LRecColisage.NextLineNo(Rec."N° Package");
                        LRecColisage."Shipping No." := Rec."Document No.";
                        LRecColisage."Shipping Line No." := Rec."Line No.";
                        LRecColisage."Item No." := Rec."No.";
                        LRecColisage.Quantity := Rec.Quantity;
                        LRecColisage.INSERT(true);
                        CLEAR(LRecColis);
                        if LRecColis.GET(Rec."N° Package") then begin
                            LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LRecColis."Package No.");
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
            group(Package)
            {
                Image = NewItem;
                action("Create Package")
                {
                    Image = Item;
                    trigger OnAction()
                    var
                        LRecSalesShipmentLine: Record 111;
                        LRecColis: Record 50009;
                        LRecColis2: Record 50009;
                        LRecColisage: Record 50010;
                        LIntI: Integer;
                        LIntNbColis: Integer;
                    begin
                        CurrPage.SETSELECTIONFILTER(LRecSalesShipmentLine);

                        if LRecSalesShipmentLine.FINDFIRST() then
                            if LRecSalesShipmentLine."N° Package" <> '' then
                                ERROR('Un Numéro de colis est déja atribué … cette ligne, veuillez le supprimer ou s‚lectionnez une autre ligne')
                            else begin
                                LRecColis.INIT();
                                LRecColis."Shipping No." := LRecSalesShipmentLine."Document No.";
                                LRecColis.INSERT(true);

                                LRecColisage.INIT();
                                LRecColisage."Package No." := LRecColis."Package No.";
                                LRecColisage."Line No." := 1;
                                LRecColisage."Shipping No." := LRecSalesShipmentLine."Document No.";
                                LRecColisage."Shipping Line No." := LRecSalesShipmentLine."Line No.";
                                LRecColisage."Item No." := LRecSalesShipmentLine."No.";
                                LRecColisage."Quantity" := LRecSalesShipmentLine.Quantity;
                                LRecColisage.INSERT(true);

                                LRecSalesShipmentLine."N° Package" := LRecColis."Package No.";
                                LRecSalesShipmentLine.MODIFY();

                                LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LRecColis."Package No.");
                                LRecColis.MODIFY();
                                COMMIT();
                                LIntI := 1;
                                LRecColis2.RESET();
                                LRecColis2.SETFILTER("Shipping No.", LRecColis."Shipping No.");
                                LIntNbColis := LRecColis2.COUNT;
                                if LRecColis2.FINDFIRST() then
                                    repeat
                                        LRecColis2."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
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
