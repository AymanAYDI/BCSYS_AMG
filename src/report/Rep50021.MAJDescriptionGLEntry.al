namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;
using Microsoft.Purchases.History;
using Microsoft.Finance.GeneralLedger.Ledger;
report 50021 "MAJ Description GL Entry"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        LRecPurchaseInvoiceHeader: Record "Purch. Inv. Header";
        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if GRecGLEntry.FINDFIRST() then
            repeat
                if GRecGLEntry."Document Type" = GRecGLEntry."Document Type"::Invoice then
                    if LRecSalesInvoiceHeader.GET(GRecGLEntry."Document No.") then
                        GRecGLEntry."Long description" := LRecSalesInvoiceHeader."Sell-to Customer Name" + ' Ref: ' + LRecSalesInvoiceHeader."Your Reference" + ' ' + GRecGLEntry.Description
                    else
                        if LRecPurchaseInvoiceHeader.GET(GRecGLEntry."Document No.") then
                            GRecGLEntry."Long description" := LRecPurchaseInvoiceHeader."Buy-from Vendor Name" + ' - Ref: ' + LRecPurchaseInvoiceHeader."Vendor Invoice No." + ' ' + GRecGLEntry.Description;
                GRecGLEntry.Modify();
            until GRecGLEntry.Next() <= 0;

    end;

    var
        GRecGLEntry: Record "G/L Entry";
}

