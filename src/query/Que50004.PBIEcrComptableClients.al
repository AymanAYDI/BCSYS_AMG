namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Receivables;
query 50004 "PBI_Ecr_Comptable_Clients"
{

    elements
    {
        dataitem(Cust_Ledger_Entry; "Cust. Ledger Entry")
        {
            column(No_Client; "Customer No.")
            {
            }
            column(Date_Compta; "Posting Date")
            {
            }
            column(Type_Document; "Document Type")
            {
            }
            column(No_Document; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Nom_Client; "Customer Name")
            {
            }
            column(Montant; Amount)
            {
            }
            column(Montant_ouvert; "Remaining Amount")
            {
            }
            column("Montant_à_lettrer"; "Amount to Apply")
            {
            }
            column(Methode_Reglement; "Payment Method Code")
            {
            }
            column(Marge; "Profit (LCY)")
            {
            }
            column(Ventes_DS; "Sales (LCY)")
            {
            }
        }
    }
}

