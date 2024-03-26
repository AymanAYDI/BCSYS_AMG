namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;

pageextension 50033 "VATEntries" extends "VAT Entries" //315
{
    layout
    {
        addafter("Bill-to/Pay-to No.")
        {
            field("Supplier Name"; rec."Supplier Name")
            {

            }
            field(Adress; rec.Adress)
            {

            }
            field("Postal code"; rec."Postal code")
            {

            }
            field(City; rec.City)
            {

            }
            field("Supp Invoice No."; rec."Supp Invoice No.")
            {

            }
        }
        modify("VAT Registration No.")
        {
            Visible = true;
        }
    }
}
