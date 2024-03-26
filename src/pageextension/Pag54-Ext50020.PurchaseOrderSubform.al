namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;

pageextension 50020 "PurchaseOrderSubform" extends "Purchase Order Subform" //54
{
    layout
    {
        addafter("Drop Shipment")
        {
            field("Special Order Sales No."; rec."Prepmt. VAT Amount Inv. (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepmt. VAT Amount Inv. (LCY) field.';
            }
            field("Special Order Sales Line No."; rec."Special Order Sales Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Special Order Sales Line No. field.';
            }
        }
        modify("Location Code")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify(Quantity)
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify("Line Amount")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify("Direct Unit Cost")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify("Line Discount %")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify("Invoice Disc. Pct.")
        {
            Editable = false;
        }
    }
    actions
    {
        addafter(SelectMultiItems)
        {
            action(ActRemplir)
            {
                Caption = 'Fill in Qty to receive';
                Promoted = true;
                PromotedIsBig = true;
                Image = AutofillQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Execute the Fill Qty to Receive action.';
                trigger OnAction()
                begin
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    GRecPurchLine.SETRANGE(Type, Rec.Type::Item);
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Receive", GRecPurchLine."Outstanding Quantity");
                            if GRecPurchLine."Qty. to Receive (Base)" <> GRecPurchLine."Outstanding Qty. (Base)" then
                                GRecPurchLine.VALIDATE("Qty. to Receive (Base)", GRecPurchLine."Outstanding Qty. (Base)");
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
            action(ActVider)
            {
                Caption = 'Empty Qty to receive';
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Execute the Empty Qty to Receive action.';
                trigger OnAction()
                begin
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Receive", 0);
                            if GRecPurchLine."Qty. to Receive (Base)" <> 0 then
                                GRecPurchLine.VALIDATE("Qty. to Receive (Base)", 0);
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
            action(ActViderAFacturer)
            {
                Caption = 'Empty Qty to invoice';
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Execute the Empty Qty to Invoice action.';
                trigger OnAction()
                begin
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Invoice", 0);
                            if GRecPurchLine."Qty. to Invoice (Base)" <> 0 then
                                GRecPurchLine.VALIDATE("Qty. to Invoice (Base)", 0);
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
        }
    }
    var
        GRecPurchLine: Record "Purchase Line";
    //TODO line 489,1019
}
