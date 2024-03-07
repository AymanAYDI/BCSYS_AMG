namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Company;
pageextension 50000 CompanyInformation extends "Company Information" //1
{
    layout
    {
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        addafter("VAT Registration No.")
        {
            field("No. EORI"; rec."No. EORI")
            {
            }
        }
        addafter("User Experience")
        {
            group(Factor)
            {
                Caption = 'Factor';
                field("Nom Factor"; rec."Nom Factor")
                {
                }
                field("Téléphone Factor"; rec."Téléphone Factor")
                {
                }
                field("EMail Factor"; rec."EMail Factor")
                {
                }
                field("Banque Factor"; rec."Banque Factor")
                {
                }
                field("Adresse Factor"; rec."Adresse Factor")
                {
                    Caption = '<Adresse Factor>';
                }
                field("RIB Factor"; rec."RIB Factor")
                {
                }
                field("IBAN Factor"; rec."IBAN Factor")
                {
                }
                field("BIC Factor"; rec."BIC Factor")
                {
                }
                field("RIB Factor Exp"; rec."RIB Factor Exp")
                {
                }
                field("IBAN Factor Exp"; rec."IBAN Factor Exp")
                {
                }
                field("BIC Factor Exp"; rec."BIC Factor Exp")
                {
                }
            }
        }
    }
}

