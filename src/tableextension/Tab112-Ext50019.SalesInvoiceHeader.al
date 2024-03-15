namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50019 SalesInvoiceHeader extends "Sales Invoice Header" //112
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold', Comment = 'FRA="En attente"';
        }
        field(50000; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compl. cond. livraison';
        }
        //TODO delete field Payment Reference ,Reversed
    }
}

