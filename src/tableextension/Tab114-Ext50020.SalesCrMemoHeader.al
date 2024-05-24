namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50020 SalesCrMemoHeader extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Additional terms of delivery', Comment = 'FRA="Conditions de livraison sup."';
        }
    }
}

