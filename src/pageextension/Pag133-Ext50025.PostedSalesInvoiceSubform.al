namespace BCSYS_AMG.BCSYS_AMG;

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
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GDecLastDirectCost field.';
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

