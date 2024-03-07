namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Setup;

pageextension 50034 "SalesReceivablesSetup" extends "Sales & Receivables Setup" //459
{
    layout
    {
        //todo not migrated yet
        addafter(General)
        {
            group(CARBOGLACE)
            {
                // field("Code catégorie Carbo"; rec."Code catégorie Carbo")
                // {

                // }
            }
        }
        addafter("Direct Debit Mandate Nos.")
        {
            // field("Souche N° colis"; rec."Souche N° colis")
            // {
            //     Caption = 'N° colis';
            // }
            // field("Souche N° DGX"; rec."Souche N° DGX")
            // {
            //     Caption = 'N° DGX';
            // }
        }
        moveafter("Logo Position on Documents"; "Freight G/L Acc. No.")
    }
}
