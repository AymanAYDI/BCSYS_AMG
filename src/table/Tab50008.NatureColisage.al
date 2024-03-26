namespace BCSYS.AMGALLOIS.Basic;
table 50008 NatureColisage
{
    DrillDownPageID = NatureColisage;
    LookupPageID = NatureColisage;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(5; Intituler; Text[60])
        {
            DataClassification = ToBeClassified;
            Caption = 'Intituler';
        }
        field(10; "Length (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Length (cm)';
        }
        field(15; "Width (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Width (cm)';
        }
        field(20; "Height (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Height (cm)';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

