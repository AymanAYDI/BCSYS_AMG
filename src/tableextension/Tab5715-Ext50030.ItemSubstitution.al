namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Substitution;
tableextension 50030 ItemSubstitution extends "Item Substitution" //5715
{
    fields
    {
        field(50000; "Dernier Prix achat"; Decimal)
        {
            CalcFormula = lookup(Item."Last Direct Cost" where(No.=field(Substitute No.)));
            Caption = 'Dernier Prix achat';
            FieldClass = FlowField;
        }
        field(50010;Fournisseur;Code[20])
        {
            CalcFormula = Lookup(Item."Vendor No." WHERE (No.=FIELD(Substitute No.)));
            Caption = 'Fournisseur';
            FieldClass = FlowField;
        }
        field(50020;"Nom Fournisseur";Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE (No.=FIELD(Fournisseur)));
            Caption = 'Nom Fournisseur';
            FieldClass = FlowField;
        }
        field(50030;"Unité de base";Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE (No.=FIELD(Substitute No.)));
            Caption = 'Unité de Base';
            FieldClass = FlowField;
        }
        field(50040;"Unité Achat";Code[10])
        {
            CalcFormula = Lookup(Item."Purch. Unit of Measure" WHERE (No.=FIELD(Substitute No.)));
            Caption = 'Unité Achat';
            FieldClass = FlowField;
        }
    }
}

