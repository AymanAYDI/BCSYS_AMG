namespace BCSYS.AMGALLOIS.Basic;
table 50008 NatureColisage
{
    DrillDownPageID = 50023;
    LookupPageID = 50023;

    fields
    {
        field(1; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Intituler; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Length (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(15; "Width (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(20; "Height (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
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

