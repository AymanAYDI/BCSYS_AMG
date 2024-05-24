namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Receivables;
using Microsoft.Sales.Customer;
tableextension 50003 CustLedgerEntry extends "Cust. Ledger Entry" //21
{
    fields
    {
        field(50000; "Nom Client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Caption = 'Nom Client', Comment = 'FRA="Nom Client"';
            FieldClass = FlowField;
            TableRelation = Customer.Name;
        }
    }

}

