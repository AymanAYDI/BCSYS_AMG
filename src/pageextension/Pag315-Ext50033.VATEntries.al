namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Finance.VAT.Ledger;

pageextension 50033 "VATEntries" extends "VAT Entries" //315
{
    layout
    {
        addafter("Bill-to/Pay-to No.")
        {
            //todo not migrated yet
            // field("Nom Fournisseur"; rec."Nom Fournisseur")
            // {

            // }
            // field(Adresse; rec.Adresse)
            // {

            // }
            // field("Code postal"; rec."Code postal")
            // {

            // }
            // field(Ville; rec.Ville)
            // {

            // }
            // field("N° Facture Fourn"; rec."N° Facture Fourn")
            // {

            // }
        }
        modify("VAT Registration No.")
        {
            Visible = true;
        }
    }
}
