namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50020 SalesCrMemoHeader extends "Sales Cr.Memo Header" //114
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold', Comment = 'On Hold';
        }
        field(50000; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compl. cond. livraison';
        }
    }
}

