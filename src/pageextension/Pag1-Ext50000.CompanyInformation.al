namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Company;
pageextension 50000 CompanyInformation extends "Company Information" //1
{
    layout
    {
        addlast(General)
        {
            field("Info Picture"; Rec."Info Picture")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Info field.', Comment = '%FRA="Info"';
            }
        }
        addafter("VAT Registration No.")
        {
            field("No. EORI"; rec."No. EORI")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group(Factor)
            {
                Caption = 'Factor', Comment = 'FRA="Factor"';
                field("Nom Factor"; Rec."Nom Factor")
                {
                    ApplicationArea = All;
                }
                field("Téléphone Factor"; Rec."Telephone Factor")
                {
                    ApplicationArea = All;
                }
                field("EMail Factor"; Rec."EMail Factor")
                {
                    ApplicationArea = All;
                }
                field("Banque Factor"; Rec."Banque Factor")
                {
                    ApplicationArea = All;
                }
                field("Adresse Factor"; Rec."Adresse Factor")
                {
                    ApplicationArea = All;
                }
                field("RIB Factor"; Rec."RIB Factor")
                {
                    ApplicationArea = All;
                }
                field("IBAN Factor"; Rec."IBAN Factor")
                {
                    ApplicationArea = All;
                }
                field("BIC Factor"; Rec."BIC Factor")
                {
                    ApplicationArea = All;
                }
                field("RIB Factor Exp"; Rec."RIB Factor Exp")
                {
                    ApplicationArea = All;
                }
                field("IBAN Factor Exp"; Rec."IBAN Factor Exp")
                {
                    ApplicationArea = All;
                }
                field("BIC Factor Exp"; Rec."BIC Factor Exp")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

