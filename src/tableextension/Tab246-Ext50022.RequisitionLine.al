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
        field(50000; "Nom du client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Caption = 'Nom du client', Comment = 'FRA="Nom du client"';
            FieldClass = FlowField;
        }
        field(50010; "Nom du fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Caption = 'Nom du fournisseur', Comment = 'FRA="Nom du fournisseur"';
            FieldClass = FlowField;
        }
    }

}

