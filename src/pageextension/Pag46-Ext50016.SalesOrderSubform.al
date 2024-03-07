namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;

pageextension 50016 "SalesOrderSubform" extends "Sales Order Subform" //46
{
    layout
    {
        modify("Purchasing Code")
        {
            visible = true;
        }
        addafter("Special Order")
        {
            field("Special Order Purchase No."; Rec."Special Order Purchase No.")
            {

            }
            field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {

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
            trigger OnAfterValidate()
            begin
                rec.Marge := Rec.FCalculeMarge(rec."No.", rec."Quantity (Base)", rec.Amount);
                rec.Marque := Rec.FCalculeMarque(rec.Marge, rec.Amount);
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                rec.Marge := Rec.FCalculeMarge(rec."No.", rec."Quantity (Base)", rec.Amount);
                rec.Marque := Rec.FCalculeMarque(rec.Marge, rec.Amount);
                rec.Modify();
            end;
        }
        modify("Unit Price")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
            trigger OnAfterValidate()
            begin
                rec.Marge := Rec.FCalculeMarge(rec."No.", rec."Quantity (Base)", rec.Amount);
                rec.Marque := Rec.FCalculeMarque(rec.Marge, rec.Amount);
                rec.Modify();
            end;
        }
        modify("Line Amount")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        addafter(SalesLineDiscExists)
        {
            field(Marge; Rec.Marge)
            {
                Importance = Standard;
                Style = Strong;
                StyleExpr = true;
            }
            field(Marque; Rec.Marque)
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                trigger OnValidate()
                begin
                    Rec.FCalculateOnMargeChange(Rec."No.", Rec.Marque);
                    DeltaUpdateTotals();
                end;
            }
        }
        moveafter(Marque; "Line Discount %")
        //todo verifier
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                Rec.FCalculateMargeOnLineDiscountChange(Rec."No.");
                DeltaUpdateTotals();
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.MODIFY();
            end;
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.MODIFY();
            end;
        }
        moveafter("Document No."; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
    }
    actions
    {
        addafter(SelectMultiItems)
        {
            action(ActRemplir)
            {
                trigger OnAction()
                begin
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET(true, false) then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Ship", GRecSalesLine."Outstanding Quantity");
                            if GRecSalesLine."Qty. to Ship (Base)" <> GRecSalesLine."Outstanding Qty. (Base)" then
                                GRecSalesLine.VALIDATE("Qty. to Ship (Base)", GRecSalesLine."Outstanding Qty. (Base)");
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
            action(ActViderAExpedier)
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET(true, false) then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Ship", 0);
                            if GRecSalesLine."Qty. to Ship (Base)" <> 0 then
                                GRecSalesLine.VALIDATE("Qty. to Ship (Base)", 0);
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
            action(ActViderAFacturer)
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET(true, false) then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Invoice", 0);
                            if GRecSalesLine."Qty. to Invoice (Base)" <> 0 then
                                GRecSalesLine.VALIDATE("Qty. to Invoice (Base)", 0);
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                end;
            }
        }
    }
    var
        GRecSalesLine: Record 37;
        IsBlankNumber: Boolean;
    //todo i can't find solution for line 307,578,585,649,706,1011,1198,1733,1742
}
