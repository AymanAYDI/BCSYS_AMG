namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Inventory.Ledger;
query 50001 "PBI_Ecr_Comptable_Articles"
{

    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(Entry_No; "Entry No.")
            {
            }
            column(No_Article; "Item No.")
            {
            }
            column(Date_Compta; "Posting Date")
            {
            }
            column(Type; "Entry Type")
            {
            }
            column(No_source; "Source No.")
            {
            }
            column(Description; Description)
            {
            }
            column("Quantité"; Quantity)
            {
            }
            column("Quantité_restante"; "Remaining Quantity")
            {
            }
            column("Quantité_Facturée"; "Invoiced Quantity")
            {
            }
            column(Code_region; "Country/Region Code")
            {
            }
            column(No_Doc_Externe; "External Document No.")
            {
            }
            column("Montant_Cout_réel"; "Cost Amount (Actual)")
            {
            }
            column("Montant_Achat_réel"; "Purchase Amount (Actual)")
            {
            }
            column("Montant_Vente_réel"; "Sales Amount (Actual)")
            {
            }
            column(Nom_Client; "Customer Name")
            {
            }
            column(Nom_Fournisseur; "Vendor Name")
            {
            }
        }
    }
}

