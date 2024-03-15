namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
tableextension 50030 ItemSubstitution extends "Item Substitution" //5715
{
    fields
    {
        field(50000; "Last Purchase Price"; Decimal)
        {
            CalcFormula = lookup(Item."Last Direct Cost" where("No." = field("Substitute No.")));
            Caption = 'Last Purchase Price', Comment = 'FRA="Dernier Prix achat"';
            FieldClass = FlowField;
        }
        field(50010; Supplier; Code[20])
        {
            CalcFormula = lookup(Item."Vendor No." where("No." = field("Substitute No.")));
            Caption = 'Supplier', Comment = 'FRA="Fournisseur';
            FieldClass = FlowField;
        }
        field(50020; "Supplier Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field(Supplier)));
            Caption = 'Supplier Name', Comment = 'FRA="Nom Fournisseur"';
            FieldClass = FlowField;
        }
        field(50030; "Basic unit"; Code[10])
        {
            CalcFormula = lookup(Item."Base Unit of Measure" where("No." = field("Substitute No.")));
            Caption = 'Basic unit', Comment = 'FRA="Unité de Base"';
            FieldClass = FlowField;
        }
        field(50040; "Purchasing unit"; Code[10])
        {
            CalcFormula = lookup(Item."Purch. Unit of Measure" where("No." = field("Substitute No.")));
            Caption = 'Purchasing unit', Comment = 'FRA="Unité Achat"';
            FieldClass = FlowField;
        }
    }
}

