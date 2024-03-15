namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

pageextension 50021 "SalesQuoteSubform" extends "Sales Quote Subform" //95
{
    layout
    {
        addbefore("Variant Code")
        {
            field("Fournisseur article"; Rec."Fournisseur article")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor field.';
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
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
            end;
        }
        addafter(Quantity)
        {
            field("Dernier cout direct"; GDecLastDirectCost)
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GDecLastDirectCost field.';
            }
            field(Marge; rec.Marge)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Marge field.';
            }
            field(Marque; rec."Prepmt. VAT Amount Inv. (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepmt. VAT Amount Inv. (LCY) field.';
                trigger OnValidate()
                begin
                    Rec.FCalculateOnMargeChange(rec."No.", rec.Marque);
                    DeltaUpdateTotals();
                end;
            }
        }
        modify("Qty. to Assemble to Order")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
            end;
        }
        modify("Unit Price")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
            trigger OnAfterValidate()
            begin
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
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
                Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
            end;
        }
        addafter("Line Discount %")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amount field.';
            }
        }
        modify("Line Amount")
        {
            Enabled = not (IsCommentLine or IsBlankNumber);
            Editable = not (IsCommentLine or IsBlankNumber);
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
    }
    actions
    {

    }
    trigger OnAfterGetRecord()
    begin
        GDecLastDirectCost := 0;
        if Rec.Type = Rec.Type::Item then
            if GRecItem.GET(Rec."No.") then
                GDecLastDirectCost := GRecItem."Last Direct Cost";
    end;

    var
        GRecItem: Record Item;
        GDecLastDirectCost: Decimal;

    //TODO check line 419,445,469,660,1138
}
