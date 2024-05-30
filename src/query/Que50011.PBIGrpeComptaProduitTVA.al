namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Setup;
query 50011 "PBI_Grpe_Compta_Produit_TVA"
{

    elements
    {
        dataitem(Grpe_Compta_Produit_TVA; "VAT Product Posting Group")
        {
            column(Code_Grpe_Compta_Produit_TVA; "Code")
            {
            }
            column(Nom_Grpe_Compta_Produit_TVA; Description)
            {
            }
        }
    }
}

