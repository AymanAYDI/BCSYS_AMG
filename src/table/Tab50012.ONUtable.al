namespace BCSYS.AMGALLOIS.Basic;
table 50012 "ONU table"
{
    DataClassification = ToBeClassified;
    Description = 'AMG.DGX';
    DrillDownPageID = 50015;
    LookupPageID = 50015;

    fields
    {
        field(10; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Description; Text[250])
        {
            Caption = 'Désignation';
            DataClassification = ToBeClassified;
        }
        field(30; Class; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Sub-Class"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Packaging group"; Option)
        {
            Caption = 'Grp';
            DataClassification = ToBeClassified;
            OptionMembers = " ",I,II,III;
        }
        field(50; "Packing instr passager"; Code[20])
        {
            Caption = 'Packing instruction Avion passager';
            DataClassification = ToBeClassified;
        }
        field(55; "Packing instr cargo"; Code[20])
        {
            Caption = 'Packing instruction Avion cargo';
            DataClassification = ToBeClassified;
        }
        field(60; "Flash Point"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Limited quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; Version; Integer)
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DrillDown; "Code", Description, Class, "Sub-Class", "Packaging group")
        {
        }
        fieldgroup(Brick; "Code", Description, Class, "Sub-Class", "Packaging group")
        {
        }
    }
}

