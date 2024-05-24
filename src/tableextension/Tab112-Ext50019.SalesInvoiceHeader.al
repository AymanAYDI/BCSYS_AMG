namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50019 SalesInvoiceHeader extends "Sales Invoice Header" //112
{
    fields
    {
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Additional terms of delivery', Comment = 'FRA="Conditions de livraison sup."';
        }
    }
}

