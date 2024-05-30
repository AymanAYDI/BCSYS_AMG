namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
pageextension 50049 SalesHistSelltoFactBox extends "Sales Hist. Sell-to FactBox" //9080
{
    layout
    {
        modify("No. of Blanket Orders")
        {
            Visible = false;
        }
        modify("No. of Invoices")
        {
            Visible = false;
        }
        modify("No. of Return Orders")
        {
            Visible = false;
        }
        modify("No. of Credit Memos")
        {
            Visible = false;
        }
        modify("No. of Pstd. Return Receipts")
        {
            Visible = false;
        }
        modify(NoofBlanketOrdersTile)
        {
            Visible = false;
        }
        modify(NoofInvoicesTile)
        {
            Visible = false;
        }
        modify(NoofCreditMemosTile)
        {
            Visible = false;
        }
        modify(NoofPstdReturnReceiptsTile)
        {
            Visible = false;
        }
    }
}

