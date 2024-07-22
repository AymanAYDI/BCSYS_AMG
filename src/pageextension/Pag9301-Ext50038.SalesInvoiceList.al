namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
pageextension 50038 SalesInvoiceList extends "Sales Invoice List" //9301
{
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.", "Document Type");
        Rec.Ascending(false);
    end;
}

