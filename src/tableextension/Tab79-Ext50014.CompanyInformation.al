namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Company;
tableextension 50014 CompanyInformation extends "Company Information" //79
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Use GLN in Electronic Document"(Field 95)".

        field(50010; "No. EORI"; Text[25])
        {
            Caption = 'No. EORI';
            DataClassification = ToBeClassified;
        }
        field(50011; "Name Factor"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name Factor';
        }
        field(50012; "phone Factor"; Text[20])
        {
            Caption = 'phone Factor';
            DataClassification = ToBeClassified;
        }
        field(50013; "EMail Factor"; Text[100])
        {
            Caption = 'EMail Factor';
            DataClassification = ToBeClassified;
        }
        field(50014; "Bank Factor"; Text[100])
        {
            Caption = 'Bank Factor';
            DataClassification = ToBeClassified;
        }
        field(50015; "RIB Factor"; Text[80])
        {
            Caption = 'RIB Factor';
            DataClassification = ToBeClassified;
        }
        field(50016; "Adress Factor"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Adress Factor';
        }
        field(50017; "IBAN Factor"; Text[80])
        {
            Caption = 'IBAN Factor';
            DataClassification = ToBeClassified;
        }
        field(50018; "BIC Factor"; Text[30])
        {
            Caption = 'BIC Factor';
            DataClassification = ToBeClassified;
        }
        field(50019; "IBAN Factor Exp"; Text[80])
        {
            Caption = 'IBAN Factor Exp';
            DataClassification = ToBeClassified;
        }
        field(50020; "BIC Factor Exp"; Text[30])
        {
            Caption = 'BIC Factor Exp';
            DataClassification = ToBeClassified;
        }
        field(50021; "RIB Factor Exp"; Text[80])
        {
            Caption = 'RIB Factor Exp';
            DataClassification = ToBeClassified;
        }


        modify(IBAN) //TODO Can't skip Standard Code
        {
            trigger OnBeforeValidate()
            begin
                ExtCheckIBAN(IBAN);
            end;
        }


        //TODO FIELD 95 Visible = Flase;
    }










    //Unsupported feature: Code Modification on "CheckIBAN(PROCEDURE 1)".

    procedure ExtCheckIBAN(IBANCode: Code[100]);
    //Parameters and return type have not been exported.
    var
        OriginalIBANCode: Code[100];
        I: Integer;
        Modulus97: Integer;
    begin

        if IBANCode = '' then
            exit;
        IBANCode := DELCHR(IBANCode);
        Modulus97 := 97;
        if (STRLEN(IBANCode) <= 5) or (STRLEN(IBANCode) > 34) then
            IBANError(OriginalIBANCode);
        ExtConvertIBAN(IBANCode);
        while STRLEN(IBANCode) > 6 do
            IBANCode := CalcModulus(COPYSTR(IBANCode, 1, 6), Modulus97) + COPYSTR(IBANCode, 7);
        EVALUATE(I, IBANCode);
        if (I mod Modulus97) <> 1 then
            IBANError(OriginalIBANCode);
    end;

    procedure ExtConvertIBAN(var IBANCode: Code[100])
    var
        I: Integer;
    begin
        IBANCode := CopyStr(IBANCode, 5) + CopyStr(IBANCode, 1, 4);
        I := 0;
        while I < StrLen(IBANCode) do begin
            I := I + 1;
            if ExtConvertLetter(IBANCode, CopyStr(IBANCode, I, 1), I) then
                I := 0;
        end;
    end;
    //Unsupported feature: Code Modification on "ConvertLetter(PROCEDURE 5)".
    procedure ExtConvertLetter(var IBANCode: Code[100]; Letter: Code[1]; LetterPlace: Integer): Boolean;
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    var
        Letter2: Code[2];
        LetterCharInt: Integer;
    begin

        if (Letter >= 'A') and (Letter <= 'Z') then begin
            case Letter of
                'A':
                    Letter2 := '10';
                'B':
                    Letter2 := '11';
                'C':
                    Letter2 := '12';
                'D':
                    Letter2 := '13';
                'E':
                    Letter2 := '14';
                'F':
                    Letter2 := '15';
                'G':
                    Letter2 := '16';
                'H':
                    Letter2 := '17';
                'I':
                    Letter2 := '18';
                'J':
                    Letter2 := '19';
                'K':
                    Letter2 := '20';
                'L':
                    Letter2 := '21';
                'M':
                    Letter2 := '22';
                'N':
                    Letter2 := '23';
                'O':
                    Letter2 := '24';
                'P':
                    Letter2 := '25';
                'Q':
                    Letter2 := '26';
                'R':
                    Letter2 := '27';
                'S':
                    Letter2 := '28';
                'T':
                    Letter2 := '29';
                'U':
                    Letter2 := '30';
                'V':
                    Letter2 := '31';
                'W':
                    Letter2 := '32';
                'X':
                    Letter2 := '33';
                'Y':
                    Letter2 := '34';
                'Z':
                    Letter2 := '35';
            end;
            case LetterPlace of
                1:
                    IBANCode := Letter2 + COPYSTR(IBANCode, 2);
                STRLEN(IBANCode):
                    IBANCode := COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2;
                else
                    IBANCode := COPYSTR(IBANCode, 1, LetterPlace - 1) + Letter2 + COPYSTR(IBANCode, LetterPlace + 1);
            end;
            exit(true);
        end;
        if (Letter >= '0') and (Letter <= '9') then
            exit(false);
        IBANError(IBANCode);
    end;
}

