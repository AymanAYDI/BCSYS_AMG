namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Requisition;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
tableextension 50022 RequisitionLine extends "Requisition Line" //246
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item where(Type = const(Inventory));
        }
        field(50000; "Customer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Caption = 'Customer Name', Comment = 'Customer Name';
            FieldClass = FlowField;
        }
        field(50001; "Supplier Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Caption = 'Supplier name', Comment = 'Supplier name';
            FieldClass = FlowField;
        }
    }

}

