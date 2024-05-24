namespace BCSYS.AMGALLOIS.Basic;
table 50012 "ONU table"
{
    DataClassification = ToBeClassified;
    Description = 'AMG.DGX';
    DrillDownPageID = "Liste ONU";
    LookupPageID = "Liste ONU";

    fields
    {
        field(10; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(20; Description; Text[250])
        {
            Caption = 'Désignation';
        }
        field(30; Classe; Text[30])
        {
            Caption = 'Classe';
        }
        field(35; "Sous-classe"; Text[30])
        {
            Caption = 'Sous-classe';
        }
        field(40; "Groupe emballage"; Enum "Groupe Emballage")
        {
            Caption = 'Grp';
        }
        field(50; "Packing instr passager"; Code[20])
        {
            Caption = 'Packing instruction Avion passager';
        }
        field(55; "Packing instr cargo"; Code[20])
        {
            Caption = 'Packing instruction Avion cargo';
        }
        field(60; "Flash Point"; Decimal)
        {
            Caption = 'Flash Point';
        }
        field(70; "Limited quantity"; Decimal)
        {
            Caption = 'Limited quantity';
        }
        field(75; Version; Integer)
        {
            Caption = 'Version';
        }
    }

    keys
    {
        key(Key1; "Code", Version)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DrillDown; "Code", Description, Classe, "Sous-classe", "Groupe emballage")
        {
        }
        fieldgroup(Brick; "Code", Description, Classe, "Sous-classe", "Groupe emballage")
        {
        }
    }
}

