namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;

pageextension 50034 "SalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        addafter(General)
        {
            group(CARBOGLACE)
            {
                field("Category Code Carbo"; Rec."Code categorie Carbo")
                {
                    ApplicationArea = all;
                }
            }
        }
        addlast("Number Series")
        {
            field("Souche No. colis"; Rec."Souche No. colis")
            {
                ApplicationArea = All;
            }
            field("Souche No. DGX"; Rec."Souche No. DGX")
            {
                ApplicationArea = All;
            }
        }
    }
}
