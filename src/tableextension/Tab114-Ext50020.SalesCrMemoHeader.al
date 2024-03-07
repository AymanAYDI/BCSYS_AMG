namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50020 SalesCrMemoHeader extends "Sales Cr.Memo Header" //114
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold';
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
}
