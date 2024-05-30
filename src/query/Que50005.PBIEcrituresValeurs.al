namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Inventory.Ledger;
query 50005 "PBI_Ecritures_Valeurs"
{

    elements
    {
        dataitem(Value_Entry; "Value Entry")
        {
            DataItemTableFilter = "Item Ledger Entry Type" = filter(Sale),
                                "Document Type" = filter("Sales Invoice" | "Sales Credit Memo");
            column(Date_Compta; "Posting Date")
            {
            }
            column(Code_Article; "Item No.")
            {
            }
            column(Code_Client; "Source No.")
            {
            }
            column(Code_Dim; "Dimension Set ID")
            {
            }
            column(Code_Vendeur; "Salespers./Purch. Code")
            {
            }
            column(Num_Document; "Document No.")
            {
            }
            column("Qtés"; "Invoiced Quantity")
            {
            }
            column(Ventes; "Sales Amount (Actual)")
            {
            }
            column(Montant_remise; "Discount Amount")
            {
            }
            column(Type_de_commande; "Order Type")
            {
            }
            column(No_commande; "Order No.")
            {
            }
            column("Coût"; "Cost Amount (Actual)")
            {
            }
        }
    }
}

