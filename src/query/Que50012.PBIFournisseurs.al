namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
query 50012 "PBI_Fournisseurs"
{

    elements
    {
        dataitem(Vendor; Vendor)
        {
            column(Code_Fournisseur; "No.")
            {
            }
            column(Nom_Fournisseur; Name)
            {
            }
        }
    }
}

