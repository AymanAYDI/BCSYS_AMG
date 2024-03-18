namespace BCSYS_AMG.BCSYS_AMG;

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
                Caption = 'Remplir Qté à recevoir';
                Promoted = true;
                PromotedIsBig = true;
                Image = AutofillQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Remplir Qté à recevoir action.';
                trigger OnAction()
                begin
                    GRecPurchLine.Reset();
                    GRecPurchLine.SetRange("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SetRange("Document No.", Rec."Document No.");
                    GRecPurchLine.SetRange(Type, Rec.Type::Item);
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.Validate("Qty. to Receive", GRecPurchLine."Outstanding Quantity");
                            if GRecPurchLine."Qty. to Receive (Base)" <> GRecPurchLine."Outstanding Qty. (Base)" then
                                GRecPurchLine.Validate("Qty. to Receive (Base)", GRecPurchLine."Outstanding Qty. (Base)");
                            GRecPurchLine.Modify();
                        until GRecPurchLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActVider)
            {
                Caption = 'Vider Qté à recevoir';
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Vider Qté à recevoir action.';
                trigger OnAction()
                begin
                    GRecPurchLine.Reset();
                    GRecPurchLine.SetRange("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SetRange("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.Validate("Qty. to Receive", 0);
                            if GRecPurchLine."Qty. to Receive (Base)" <> 0 then
                                GRecPurchLine.Validate("Qty. to Receive (Base)", 0);
                            GRecPurchLine.Modify();
                        until GRecPurchLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActViderAFacturer)
            {
                Caption = 'Vider Qté à facturer';
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Vider Qté à facturer action.';
                trigger OnAction()
                begin
                    GRecPurchLine.Reset();
                    GRecPurchLine.SetRange("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SetRange("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.Validate("Qty. to Invoice", 0);
                            if GRecPurchLine."Qty. to Invoice (Base)" <> 0 then
                                GRecPurchLine.Validate("Qty. to Invoice (Base)", 0);
                            GRecPurchLine.Modify();
                        until GRecPurchLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
        }
    }
    var
        GRecPurchLine: Record "Purchase Line";
    //TODO line 489,1019
}
