namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50019 SalesInvoiceHeader extends "Sales Invoice Header" //112
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold';
        }
        field(50000; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        //todo delete field Payment Reference ,Reversed
    }
}

