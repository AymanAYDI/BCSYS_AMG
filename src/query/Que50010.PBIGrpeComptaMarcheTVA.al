namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Setup;
query 50010 "PBI_Grpe_Compta_Marche_TVA"
{

    elements
    {
        dataitem(Groupe_Compta_marche_TVA; "VAT Business Posting Group")
        {
            column(Code_Grpe_Compta_Marche_TVA; "Code")
            {
            }
            column(Nom_Grpe_Compta_Marche_TVA; Description)
            {
            }
        }
    }
}

