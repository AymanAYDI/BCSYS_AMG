namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
table 50007 "DGX Lines"
{

    fields
    {
        field(1; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'LineNo';
        }
        field(10; DGXNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DGX Header"."DGX No.";
            Caption = 'DGXNo';
        }
        field(20; ItemNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            Caption = 'ItemNo';
        }
        field(30; UN; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ONU table".Code;
            Caption = 'UN';
        }
        field(31; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(32; Class; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Class';
        }
        field(33; "Packaging Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",I,II,III;
            Caption = 'Packaging Group';
        }
        field(34; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Qty';
        }
        field(35; "Type of Packing"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Packing';
        }
        field(36; "Flash point"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Flash point';
        }
        field(37; "Limited qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Limited qty';
        }
        field(38; "Gross Mass (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Mass (kg)';
        }
        field(39; "Net mass (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net mass (kg)';
        }
        field(50; "Package No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Package."Package No.";
            Caption = 'Package No.';
        }
        field(55; "Unit of measure"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit of measure';
        }
        field(60; "Packing Inst"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Packing Inst';
        }
        field(65; "Sub-Class"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub-Class';
        }
        field(70; "Packing Inst cargo"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Packing Inst cargo';
        }
        field(75; "Package Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Package Qty';
        }
    }

    keys
    {
        key(Key1; DGXNo, LineNo)
        {
            Clustered = true;
        }
        key(Key2; DGXNo, UN, LineNo)
        {
        }
    }

    fieldgroups
    {
    }
}

