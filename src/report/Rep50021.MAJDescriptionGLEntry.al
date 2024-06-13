namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Sales.History;
using Microsoft.Purchases.History;
report 50021 "MAJ Description GL Entry"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = None;
    ApplicationArea = All;

    trigger OnInitReport()
    var
        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
        LRecPurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        //DELPHI AUB 22.07.2020
        if GRecGLEntry.FIND('-') then
            repeat
                if GRecGLEntry."Document Type" = GRecGLEntry."Document Type"::Invoice then
                    if LRecSalesInvoiceHeader.GET(GRecGLEntry."Document No.") then
                        GRecGLEntry."Description longue" := LRecSalesInvoiceHeader."Sell-to Customer Name" + ' Ref: ' + LRecSalesInvoiceHeader."Your Reference" + ' ' + GRecGLEntry.Description
                    else
                        if LRecPurchaseInvoiceHeader.GET(GRecGLEntry."Document No.") then
                            GRecGLEntry."Description longue" := LRecPurchaseInvoiceHeader."Buy-from Vendor Name" + ' - Ref: ' + LRecPurchaseInvoiceHeader."Vendor Invoice No." + ' ' + GRecGLEntry.Description;
                GRecGLEntry.MODIFY();
            until GRecGLEntry.NEXT() <= 0;
        //END DELPHI AUB
    end;

    var
        GRecGLEntry: Record "G/L Entry";
}

