namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
tableextension 50030 ItemSubstitution extends "Item Substitution" //5715
{
    fields
    {
        field(50000; "Dernier Prix achat"; Decimal)
        {
            CalcFormula = lookup(Item."Last Direct Cost" where("No." = field("Substitute No.")));
            Caption = 'Dernier Prix achat';
            FieldClass = FlowField;
        }
        field(50010; Fournisseur; Code[20])
        {
            CalcFormula = lookup(Item."Vendor No." where("No." = field("Substitute No.")));
            Caption = 'Fournisseur';
            FieldClass = FlowField;
        }
        field(50020; "Nom Fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field(Fournisseur)));
            Caption = 'Nom Fournisseur';
            FieldClass = FlowField;
        }
        field(50030; "Unite de base"; Code[10])
        {
            CalcFormula = lookup(Item."Base Unit of Measure" where("No." = field("Substitute No.")));
            Caption = 'Unité de Base';
            FieldClass = FlowField;
        }
        field(50040; "Unite Achat"; Code[10])
        {
            CalcFormula = lookup(Item."Purch. Unit of Measure" where("No." = field("Substitute No.")));
            Caption = 'Unité Achat';
            FieldClass = FlowField;
        }
    }
}

