namespace BCSYS.AMGALLOIS.Basic;

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
            }
        }
        addafter(Quantity)
        {
            field("Dernier cout direct"; GDecLastDirectCost)
            {
                Caption = 'Dernier coût direct';
                Editable = false;
                ApplicationArea = All;
            }
            field(Marge; Rec.Marge)
            {
                ApplicationArea = All;
            }
            field(Marque; Rec.Marque)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
        modify("Unit Price")
        {
            Caption = 'Unit Price', Comment = 'FRA="Prix unitaire"';
        }
        addafter("Line Discount %")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
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
}
