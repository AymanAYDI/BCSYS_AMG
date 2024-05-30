namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;
query 50009 "PBI_Ecriture_TVA"
{

    elements
    {
        dataitem(VAT_Entry; "VAT Entry")
        {
            column(Num_Doc; "Document No.")
            {
            }
            column(Date_Compta; "Posting Date")
            {
            }
            column(Groupe_Compta_Marche_TVA; "VAT Bus. Posting Group")
            {
            }
            column(Groupe_Compta_Produit_TVA; "VAT Prod. Posting Group")
            {
            }
            column(Type_Doc; "Document Type")
            {
            }
            column(Type; Type)
            {
            }
            column(Base; Base)
            {
            }
            column(Montant; Amount)
            {
            }
            column(Mode_Calcul_TVA; "VAT Calculation Type")
            {
            }
            column(Code_Tiers; "Bill-to/Pay-to No.")
            {
            }
        }
    }
}

