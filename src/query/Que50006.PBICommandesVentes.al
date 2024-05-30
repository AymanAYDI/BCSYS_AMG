namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
query 50006 "PBI_Commandes_Ventes"
{

    elements
    {
        dataitem(Sales_Header; "Sales Header")
        {
            DataItemTableFilter = "Document Type" = FILTER(Order);
            column(No_donneur_ordre; "Sell-to Customer No.")
            {
            }
            column(No_document; "No.")
            {
            }
            column(Date_Compta; "Posting Date")
            {
            }
            column(Montant; Amount)
            {
            }
            column(Date_Commande; "Order Date")
            {
            }
            column(Montant_TTC; "Amount Including VAT")
            {
            }
            column(Statut; Status)
            {
            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document No." = Sales_Header."No.",
                                "Document Type" = Sales_Header."Document Type";
                column(Num_Document; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column("Unité_de_mesure"; "Unit of Measure")
                {
                }
                column("Quantité"; Quantity)
                {
                }
                column("Quantité_restante"; "Outstanding Quantity")
                {
                }
                column("Qté_à_facturer"; "Qty. to Invoice")
                {
                }
                column("Qté_à_expédier"; "Qty. to Ship")
                {
                }
                column(Prix_Unitaire; "Unit Price")
                {
                }
                column(Tx_TVA; "VAT %")
                {
                }
                column(Pct_remise; "Line Discount %")
                {
                }
                column(Montant_remise; "Line Discount Amount")
                {
                }
                column(Montant_L; Amount)
                {
                }
                column(Montant_TTC_ligne; "Amount Including VAT")
                {
                }
                column("Qté_expédiée_non_facturée"; "Qty. Shipped Not Invoiced")
                {
                }
                column("Qté_expédiée"; "Quantity Shipped")
                {
                }
                column("Qté_facturée"; "Quantity Invoiced")
                {
                }
                column(No_Cmde_Achat; "Purchase Order No.")
                {
                }
                column("Coût_unitaire"; "Unit Cost")
                {
                }
                column(Montant_ligne; "Line Amount")
                {
                }
                column("Qté_par_unité_de_mesure"; "Qty. per Unit of Measure")
                {
                }
                column("Ordre_spécial"; "Special Order")
                {
                }
                column("Ordre_spécial_No_Cmde_Achat"; "Special Order Purchase No.")
                {
                }
                column("Date_liv_demandée"; "Requested Delivery Date")
                {
                }
                column("Date_liv_prévue"; "Promised Delivery Date")
                {
                }
                column(Marge; Marge)
                {
                }
                column(Pct_Marge; Marque)
                {
                }
            }
        }
    }
}

