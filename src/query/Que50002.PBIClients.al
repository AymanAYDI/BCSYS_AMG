namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
query 50002 "PBI_Clients"
{

    elements
    {
        dataitem(Customer; Customer)
        {
            column(Code_Client; "No.")
            {
            }
            column(Nom_Client; Name)
            {
            }
            column(Code_Devise; "Currency Code")
            {
            }
            column(Ville; City)
            {
            }
            column(Code_region; "Country/Region Code")
            {
            }
            column(Nb_Devis; "No. of Quotes")
            {
            }
            column(Nb_Commandes; "No. of Orders")
            {
            }
            column(Nb_Factures; "No. of Pstd. Invoices")
            {
            }
            column(Nb_Avoirs; "No. of Pstd. Credit Memos")
            {
            }
        }
    }
}

