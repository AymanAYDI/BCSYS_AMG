namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Sales.History;
using Microsoft.Purchases.History;
tableextension 50001 GLEntry extends "G/L Entry" //17
{
    fields
    {
        field(50000; "Description longue"; Text[250])
        {
            Caption = 'Description longue';
        }
    }
    trigger OnBeforeInsert()
    var
        LRecPurchaseInvoiceHeader: Record "Purch. Inv. Header";
        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if "Document Type" = "Document Type"::Invoice then
            if LRecSalesInvoiceHeader.Get("Document No.") then
                "Description longue" := LRecSalesInvoiceHeader."Sell-to Customer Name" + ' Ref: ' + LRecSalesInvoiceHeader."Your Reference" + ' ' + Description
            else
                if LRecPurchaseInvoiceHeader.Get("Document No.") then
                    "Description longue" := LRecPurchaseInvoiceHeader."Buy-from Vendor Name" + ' - Ref: ' + LRecPurchaseInvoiceHeader."Vendor Invoice No." + ' ' + Description;
    end;
}

