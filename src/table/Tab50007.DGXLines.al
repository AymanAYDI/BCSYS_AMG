namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
table 50007 "DGX Lines"
{

    fields
    {
        field(1; LineNo; Integer)
        {
            Caption = 'LineNo';
        }
        field(10; DGXNo; Code[20])
        {
            TableRelation = "DGX Header"."No DGX";
            Caption = 'DGXNo';
        }
        field(20; ItemNo; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'ItemNo';
        }
        field(30; UN; Code[10])
        {
            TableRelation = "ONU table".Code;
            Caption = 'UN';
        }
        field(31; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(32; Classe; Text[30])
        {
            Caption = 'Classe';
        }
        field(33; "Groupe Emballage"; Enum "Groupe Emballage")
        {
            Caption = 'Groupe Emballage';
        }
        field(34; Qty; Decimal)
        {
            Caption = 'Qty';
        }
        field(35; "Type of Packing"; Text[250])
        {
            Caption = 'Type of Packing';
        }
        field(36; "Point eclair"; Decimal)
        {
            Caption = 'Point éclair';
        }
        field(37; "Limited qty"; Decimal)
        {
            Caption = 'Limited qty';
        }
        field(38; "Masse brute (kg)"; Decimal)
        {
            Caption = 'Masse brute (kg)';
        }
        field(39; "Masse nette (kg)"; Decimal)
        {
            Caption = 'Masse nette (kg)';
        }
        field(50; "No Colis"; Code[20])
        {
            TableRelation = Colis."No.";
            Caption = 'No Colis';
        }
        field(55; "Unite de mesure"; Text[50])
        {
            Caption = 'Unité de mesure';
        }
        field(60; "Packing Inst"; Code[20])
        {
            Caption = 'Packing Inst';
        }
        field(65; "Sous-classe"; Text[30])
        {
            Caption = 'Sous-classe';
        }
        field(70; "Packing Inst cargo"; Code[20])
        {
            Caption = 'Packing Inst cargo';
        }
        field(75; "Qty colis"; Decimal)
        {
            Caption = 'Qty colis';
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

