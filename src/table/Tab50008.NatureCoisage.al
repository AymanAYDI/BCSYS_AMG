namespace BCSYS.AMGALLOIS.Basic;
table 50008 NatureCoisage
{
    DrillDownPageID = NatureColisage;
    LookupPageID = NatureColisage;

    fields
    {
        field(1; No; Code[10])
        {
        }
        field(5; Intituler; Text[60])
        {
        }
        field(10; "Longueur (cm)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(15; "Largeur (cm)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(20; "Hauteur (cm)"; Decimal)
        {
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

