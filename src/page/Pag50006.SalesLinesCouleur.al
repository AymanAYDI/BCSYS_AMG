namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Archive;
using Microsoft.Utilities;
page 50006 "Sales Lines Couleur"
{
    Caption = 'Sales Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Line No."; rec."Line No.")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
                field("No."; rec."No.")
                {
                    Caption = 'No.';
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.';
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Qty to Ship field.';
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Quantity Shipped field.';
                }
                field("Qty received"; GDecQtyReceived)
                {
                    Caption = 'Qty received from Supplier';
                    DecimalPlaces = 0 : 1;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Qty received from the Supplier field.';
                }
                field("Qty In Stock"; GDecStock)
                {
                    DecimalPlaces = 0 : 1;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the GDecStock field.';
                }
                field("Special Order Purchase No."; rec."Special Order Purchase No.")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
                }
                field("Special Order Purch. Line No."; rec."Special Order Purch. Line No.")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
                }
                field("Item supplier"; rec."Item supplier")
                {
                    Caption = 'Fourn.';
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Fourn. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the document that the selected line exists on.';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit "Page Management";
                    begin
                        SalesHeader.GET(rec."Document Type", rec."Document No.");
                        PageManagement.PageRun(SalesHeader);
                    end;
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Reservation Entries action.';
                    trigger OnAction()
                    begin
                        rec.ShowReservationEntries(true);
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item &Tracking Lines action.';
                    trigger OnAction()
                    begin
                        rec.OpenItemTrackingLines();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        GRecItem: Record Item;
        LRecPurchInvHeader: Record "Purch. Inv. Header";
        LRecPurchInvLine: Record "Purch. Inv. Line";
        LRecPurchHeaderArchive: Record "Purchase Header Archive";
        LRecPurchaseLine: Record "Purchase Line";
        LRecPurchLineArchive: Record "Purchase Line Archive";
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
        GTxtStyleText := 'Standard';
        GDecQtyReceived := 0;
        GDecStock := 0;
        if Rec.Type = Rec.Type::Item then begin
            GRecItem.RESET();
            if GRecItem.GET(Rec."No.") then begin
                GRecItem.CALCFIELDS(Inventory);
                GDecStock := GRecItem.Inventory;
            end;
            LRecPurchaseLine.RESET();
            if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
                LRecPurchaseLine.SETRANGE("Document No.", Rec."Special Order Purchase No.");
                LRecPurchaseLine.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                if LRecPurchaseLine.FINDFIRST() then
                    GDecQtyReceived := LRecPurchaseLine."Quantity Received"
                else begin
                    // If no result, search in Purch. Invoice Lines
                    LRecPurchInvHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
                    if LRecPurchInvHeader.FindSet() then
                        repeat
                            LRecPurchInvLine.SETRANGE("Document No.", LRecPurchInvHeader."No.");
                            LRecPurchInvLine.SETRANGE(Type, Rec.Type::Item);
                            LRecPurchInvLine.SETRANGE("No.", Rec."No.");
                            LRecPurchInvLine.SETFILTER(Quantity, '<>0');
                            if LRecPurchInvLine.FindSet() then
                                repeat
                                    GDecQtyReceived += LRecPurchInvLine.Quantity;
                                until LRecPurchInvLine.NEXT() = 0;
                        until LRecPurchInvHeader.NEXT() = 0
                    else begin
                        LRecPurchHeaderArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                        LRecPurchHeaderArchive.SETRANGE("No.", Rec."Special Order Purchase No.");
                        if LRecPurchHeaderArchive.FINDLAST() then begin
                            LRecPurchLineArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                            LRecPurchLineArchive.SETRANGE("Document No.", LRecPurchHeaderArchive."No.");
                            LRecPurchLineArchive.SETRANGE("Doc. No. Occurrence", LRecPurchHeaderArchive."Doc. No. Occurrence");
                            LRecPurchLineArchive.SETRANGE("Version No.", LRecPurchHeaderArchive."Version No.");
                            LRecPurchLineArchive.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                            if LRecPurchLineArchive.FINDFIRST() then
                                GDecQtyReceived += LRecPurchLineArchive."Quantity Received";
                        end;
                    end;
                end;
            end else
                //No Special Order - verify quantity in stock
                if (Rec.Quantity > GDecStock) then
                    GTxtStyleText := 'StandardAccent'
                else
                    GTxtStyleText := 'StrongAccent';
        end;
        if (GDecQtyReceived > 0) and (GDecQtyReceived >= Rec.Quantity) then
            GTxtStyleText := 'Favorable'
        else
            if GDecQtyReceived > 0 then
                GTxtStyleText := 'Ambiguous';
        //END DELPHI AUB

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        ShortcutDimCode: array[8] of Code[20];
        GDecQtyReceived: Decimal;
        GDecStock: Decimal;
        GTxtStyleText: Text[80];
}

