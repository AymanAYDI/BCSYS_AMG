namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
pageextension 50038 SalesInvoiceList extends "Sales Invoice List" //9301
{
    //TODO SourceTableView cannot be customized
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
    //TODO i can't find solution for Onopenpage line 26 and 755
}

