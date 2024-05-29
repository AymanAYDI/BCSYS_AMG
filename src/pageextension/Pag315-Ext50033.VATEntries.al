namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;

pageextension 50033 "VATEntries" extends "VAT Entries" //315
{
    layout
    {
        addafter("Bill-to/Pay-to No.")
        {
            field("Nom Fournisseur"; Rec."Nom Fournisseur")
            {
                ApplicationArea = All;
            }
            field(Adresse; Rec.Adresse)
            {
                ApplicationArea = All;
            }
            field("Code postal"; Rec."Code postal")
            {
                ApplicationArea = All;
            }
            field(Ville; Rec.Ville)
            {
                ApplicationArea = All;
            }
            field("No. Facture Fourn"; Rec."No. Facture Fourn")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Registration No.")
        {
            Visible = true;
        }
    }
}
