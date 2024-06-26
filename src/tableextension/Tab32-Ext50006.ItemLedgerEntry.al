namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
tableextension 50006 ItemLedgerEntry extends "Item Ledger Entry" //32
{
    fields
    {
        field(50000; "Customer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Source No.")));
            Caption = 'Customer Name', Comment = 'FRA="Nom Client"';
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
            TableRelation = if ("Source Type" = const(Customer)) Customer;
        }
        field(50001; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Source No.")));
            Caption = 'Vendor Name', Comment = 'FRA="Nom Fournisseur"';
            FieldClass = FlowField;
            TableRelation = if ("Source Type" = const(Vendor)) Vendor;
        }
    }
}

