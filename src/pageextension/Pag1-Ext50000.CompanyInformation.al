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
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the N° EORI field.';
            }
        }
        addafter("User Experience")
        {
            group(Factor)
            {
                Caption = 'Factor';
                field("Nom Factor"; rec."Name Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nom Factor field.';
                }
                field("Téléphone Factor"; rec."phone Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Téléphone Factor field.';
                }
                field("EMail Factor"; rec."EMail Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EMail Factor field.';
                }
                field("Banque Factor"; rec."Bank Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banque Factor field.';
                }
                field("Adress Factor"; rec."Adress Factor")
                {
                    Caption = '<Adress Factor>';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the <Adress Factor> field.';
                }
                field("RIB Factor"; rec."RIB Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RIB Factor field.';
                }
                field("IBAN Factor"; rec."IBAN Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IBAN Factor field.';
                }
                field("BIC Factor"; rec."BIC Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BIC Factor field.';
                }
                field("RIB Factor Exp"; rec."RIB Factor Exp")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RIB Factor Exp field.';
                }
                field("IBAN Factor Exp"; rec."IBAN Factor Exp")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IBAN Factor Exp field.';
                }
                field("BIC Factor Exp"; rec."BIC Factor Exp")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BIC Factor Exp field.';
                }
            }
        }
    }
}

