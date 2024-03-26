namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
tableextension 50006 ItemLedgerEntry extends "Item Ledger Entry" //32
{
    fields
    {
        modify("Derived from Blanket Order")
        {
            Caption = 'Derived from Blanket Order', comment = 'Derived from Blanket Order';
        }
        field(50000; "Customer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Source No.")));
            Caption = 'Customer Name';
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
            TableRelation = if ("Source Type" = const(Customer)) Customer;
        }
        field(50001; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Source No.")));
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            TableRelation = if ("Source Type" = const(Vendor)) Vendor;
        }
    }
}

