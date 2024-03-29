namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using BCSYS.AMGALLOIS.Basic;

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
                ToolTip = 'Specifies the value of the Code ONU field.';
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
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
            }
            field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
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
            field("Package No."; rec."Package No.")
            {
                Lookup = true;
                DrillDown = false;
                TableRelation = Package."Package No." where("Package No." = field("Package No."));
                LookupPageID = Package;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Package No. field.';
                trigger OnValidate()
                var
                    LRecColis: Record Package;
                    LRecColisage: Record Packaging;
                    LNoColis: Code[20];
                begin
                    if (xRec."Package No." <> Rec."Package No.") and (xRec."Package No." <> '') then begin
                        LRecColisage.SetRange("Shipping No.", Rec."Document No.");
                        LRecColisage.SetRange("Shipping Line No.", Rec."Line No.");
                        if LRecColisage.FINDFIRST() then begin
                            LNoColis := LRecColisage."Package No.";
                            LRecColisage.DELETE(true);
                            Clear(LRecColis);
                            if LRecColis.GET(LNoColis) then begin
                                LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LNoColis);
                                LRecColis.Modify();
                            end;
                        end;
                    end;

                    if Rec."Package No." <> '' then begin
                        Clear(LRecColisage);
                        LRecColisage.INIT();
                        LRecColisage."Package No." := Rec."Package No.";
                        LRecColisage."Line No." := LRecColisage.NextLineNo(Rec."Package No.");
                        LRecColisage."Shipping No." := Rec."Document No.";
                        LRecColisage."Shipping Line No." := Rec."Line No.";
                        LRecColisage."Item No." := Rec."No.";
                        LRecColisage.Quantity := Rec.Quantity;
                        LRecColisage.INSERT(true);
                        Clear(LRecColis);
                        if LRecColis.GET(Rec."Package No.") then begin
                            LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LRecColis."Package No.");
                            LRecColis.Modify();
                        end;
                    end;

                    CurrPage.Update();
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
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Package action.';
                    trigger OnAction()
                    var
                        LRecSalesShipmentLine: Record "Sales Shipment Line";
                        LRecColis: Record Package;
                        LRecColis2: Record Package;
                        LRecColisage: Record Packaging;
                        LIntI: Integer;
                        LIntNbColis: Integer;
                    begin
                        CurrPage.SETSELECTIONFILTER(LRecSalesShipmentLine);

                        if LRecSalesShipmentLine.FINDFIRST() then
                            if LRecSalesShipmentLine."Package No." <> '' then
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

                                LRecSalesShipmentLine."Package No." := LRecColis."Package No.";
                                LRecSalesShipmentLine.Modify();

                                LRecColis."Net Weight" := LRecColisage.FCalcPoidsNetColis(LRecColis."Package No.");
                                LRecColis.Modify();
                                COMMIT();
                                LIntI := 1;
                                LRecColis2.Reset();
                                LRecColis2.SETFILTER("Shipping No.", LRecColis."Shipping No.");
                                LIntNbColis := LRecColis2.COUNT;
                                if LRecColis2.FINDFIRST() then
                                    repeat
                                        LRecColis2."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                                        LRecColis2.Modify();
                                        COMMIT();
                                        LIntI += 1;
                                    until LRecColis2.Next() <= 0;
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
