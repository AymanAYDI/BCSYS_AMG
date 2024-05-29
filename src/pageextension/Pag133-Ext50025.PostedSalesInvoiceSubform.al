namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
pageextension 50025 PostedSalesInvoiceSubform extends "Posted Sales Invoice Subform" //133
{
    layout
    {
        addafter("Unit of Measure")
        {
            field("Last direct cost"; GDecLastDirectCost)
            {
                Caption = 'Last direct cost', Comment = 'FRA="Dernier Coût direct"';
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        GDecLastDirectCost := 0;
        if Rec.Type = Rec.Type::Item then
            if GRecItem.GET(Rec."No.") then
                GDecLastDirectCost := GRecItem."Last Direct Cost"
    end;

    var
        GRecItem: Record Item;
        GDecLastDirectCost: Decimal;
}

