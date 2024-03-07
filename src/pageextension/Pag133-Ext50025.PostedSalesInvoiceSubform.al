namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;
pageextension 50025 PostedSalesInvoiceSubform extends "Posted Sales Invoice Subform" //133
{
    layout
    {
        addafter("Unit of Measure")
        {
            field("Dernier Coût direct"; GDecLastDirectCost)
            {
                Editable = false;
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
        GRecItem: Record 27;
        GDecLastDirectCost: Decimal;
}

