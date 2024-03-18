namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;

pageextension 50017 "SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    layout
    {
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
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec.Quantity, Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        modify("Unit Price")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec.Quantity, Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        modify("Line Discount %")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
            trigger OnBeforeValidate()
            begin
                Rec.FCalculateMargeOnLineDiscountChange(Rec."No.");
            end;

            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec.Quantity, Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        modify("Line Amount")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec.Quantity, Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
        addafter(LineDiscExists)
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
                    Rec.FCalculateMargeOnLineDiscountChange(Rec."No.");
                    DeltaUpdateTotals();
                end;
            }
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec.Quantity, Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                Rec.Modify();
            end;
        }
    }
    actions
    {

    }
    //TODO check 383,423,437,657,791,1189
}
