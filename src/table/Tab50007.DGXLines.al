namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
table 50007 "DGX Lines"
{

    fields
    {
        field(1; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; DGXNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DGX Header"."No DGX";
        }
        field(20; ItemNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(30; UN; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ONU table".Code;
        }
        field(31; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Classe; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Groupe Emballage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",I,II,III;
        }
        field(34; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Type of Packing"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Point éclair"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Limited qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Masse brute (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Masse nette (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "No Colis"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colis."N°";
        }
        field(55; "Unité de mesure"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Packing Inst"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Sous-classe"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Packing Inst cargo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Qty colis"; Decimal)
        {
            DataClassification = ToBeClassified;
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

