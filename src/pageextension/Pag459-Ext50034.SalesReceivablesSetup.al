namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;

pageextension 50034 "SalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        //TODO not migrated yet
        addafter(General)
        {
            group(CARBOGLACE)
            {
                field("Category Code Carbo"; rec."Category Code Carbo")
                {

                }
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("Package Serie No."; rec."Package Serie No.")
            {
                Caption = 'package No.';
            }
            field("DGX Serie No."; rec."DGX Serie No.")
            {
                Caption = 'DGX No.';
            }
        }
        moveafter("Logo Position on Documents"; "Freight G/L Acc. No.")
    }
}
