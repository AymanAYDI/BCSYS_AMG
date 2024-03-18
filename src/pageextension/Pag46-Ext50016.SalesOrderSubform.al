namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item.Substitution;

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
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
            }
            field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
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
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Marge field.';
            }
            field(Marque; Rec.Marque)
            {
                Style = StrongAccent;
                StyleExpr = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the % Marge field.';
                trigger OnValidate()
                begin
                    Rec.FCalculateOnMargeChange(Rec."No.", Rec.Marque);
                    DeltaUpdateTotals();
                end;
            }
        }
        moveafter(Marque; "Line Discount %")
        //TODO verifier
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                Rec.FCalculateMargeOnLineDiscountChange(Rec."No.");
                DeltaUpdateTotals();
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        moveafter("Document No."; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
    }
    actions
    {
        modify(SelectItemSubstitution)
        {
            Visible = false;
        }
        addafter(SelectItemSubstitution)
        {
            action(SelectItemSubstitutionamg)
            {
                AccessByPermission = TableData "Item Substitution" = R;
                ApplicationArea = Suite;
                Caption = 'Select Item Substitution';
                Image = SelectItemSubstitution;
                ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                trigger OnAction()
                begin
                    CurrPage.SaveRecord();
                    Rec.ShowItemSub();
                    CurrPage.Update(true);
                    // if (Rec.Reserve = Rec.Reserve::Always) and (Rec."No." <> xRec."No.") then begin
                    Rec.AutoReserve();
                    //    CurrPage.Update(false);
                    //  end;
                end;
            }
        }
        addafter(SelectMultiItems)
        {
            action(ActRemplir)
            {
                ApplicationArea = All;
                ToolTip = 'Executes the ActRemplir action.';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", GRecSalesLine."Outstanding Quantity");
                            if GRecSalesLine."Qty. to Ship (Base)" <> GRecSalesLine."Outstanding Qty. (Base)" then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", GRecSalesLine."Outstanding Qty. (Base)");
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActViderAExpedier)
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the ActViderAExpedier action.';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", 0);
                            if GRecSalesLine."Qty. to Ship (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActViderAFacturer)
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = DeleteQtyToHandle;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the ActViderAFacturer action.';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Invoice", 0);
                            if GRecSalesLine."Qty. to Invoice (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Invoice (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
        }
    }
    var
        GRecSalesLine: Record "Sales Line";
        IsBlankNumber: Boolean;
    //TODO i can't find solution for line 578,585,649,706,1011,1198,1733,1742
}
