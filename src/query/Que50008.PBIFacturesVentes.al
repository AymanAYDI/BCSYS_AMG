namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.History;
query 50008 "PBI_Factures_Ventes"
{

    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            column(No_donneur_ordre; "Sell-to Customer No.")
            {
            }
            column(No_document; "No.")
            {
            }
            column(Date_Compta; "Posting Date")
            {
            }
            column(No_commande; "Order No.")
            {
            }
            column(Montant; Amount)
            {
            }
            column(Montant_TTC; "Amount Including VAT")
            {
            }
            dataitem(Sales_Invoice_Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                column(No_doc; "Document No.")
                {
                }
                column(No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Unite_de_mesure; "Unit of Measure")
                {
                }
                column(Quantite; Quantity)
                {
                }
                column(Prix_unitaire; "Unit Price")
                {
                }
                column(TVA_pct; "VAT %")
                {
                }
                column(remise_ligne_pct; "Line Discount %")
                {
                }
                column(remise_ligne_montant; "Line Discount Amount")
                {
                }
                column(Montant_Ligne; Amount)
                {
                }
                column(Montant_TTC_Ligne; "Amount Including VAT")
                {
                }
                column(No_commande_ligne; "Order No.")
                {
                }
                column(Client_facture; "Bill-to Customer No.")
                {
                }
                column(Montant_remise_facture; "Inv. Discount Amount")
                {
                }
                column(Base_TVA; "VAT Base Amount")
                {
                }
                column(Cout_unitaire; "Unit Cost")
                {
                }
                column(Date_compta_ligne; "Posting Date")
                {
                }
            }
        }
    }
}

