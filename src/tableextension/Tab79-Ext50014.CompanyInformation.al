namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Company;
tableextension 50014 CompanyInformation extends "Company Information" //79
{
    fields
    {
        field(50010; "No. EORI"; Text[25])
        {
            Caption = 'No. EORI', Comment = 'FRA="N° EORI"';
        }
        field(50011; "Nom Factor"; Text[100])
        {
            Caption = 'Nom Factor', Comment = 'FRA="Nom Factor"';
        }
        field(50012; "Telephone Factor"; Text[20])
        {
            Caption = 'Telephone Factor', Comment = 'FRA="Téléphone Factor"';
        }
        field(50013; "EMail Factor"; Text[100])
        {
            Caption = 'EMail Factor', Comment = 'FRA="EMail Factor"';
        }
        field(50014; "Banque Factor"; Text[100])
        {
            Caption = 'Banque Factor', Comment = 'FRA="Banque Factor"';
        }
        field(50015; "RIB Factor"; Text[80])
        {
            Caption = 'RIB Factor', Comment = 'FRA="RIB Factor"';
        }
        field(50016; "Adresse Factor"; Text[100])
        {
            Caption = 'Adresse Factor', Comment = 'FRA="Adresse Factor"';
        }
        field(50017; "IBAN Factor"; Text[80])
        {
            Caption = 'IBAN Factor', Comment = 'FRA="IBAN Factor"';
        }
        field(50018; "BIC Factor"; Text[30])
        {
            Caption = 'BIC Factor', Comment = 'FRA="BIC Factor"';
        }
        field(50019; "IBAN Factor Exp"; Text[80])
        {
            Caption = 'IBAN Factor Exp', Comment = 'FRA=""';
        }
        field(50020; "BIC Factor Exp"; Text[30])
        {
            Caption = 'BIC Factor Exp', Comment = 'FRA="BIC Factor Exp"';
        }
        field(50021; "RIB Factor Exp"; Text[80])
        {
            Caption = 'RIB Factor Exp', Comment = 'FRA="RIB Factor Exp"';
        }
        field(50022; "Info Picture"; BLOB)
        {
            Caption = 'Info', Comment = 'FRA="Info"';
            SubType = Bitmap;
        }
    }
}

