namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
pageextension 50038 SalesInvoiceList extends "Sales Invoice List" //9301
{
    //todo SourceTableView cannot be customized
    layout
    {
        modify("Quote No.")
        {
            Visible = false;
        }
    }
    actions
    {

    }
    //todo i can't find solution for Onopenpage line 26 and 755
}

