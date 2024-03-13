namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Receivables;
using Microsoft.Sales.Customer;
tableextension 50003 CustLedgerEntry extends "Cust. Ledger Entry" //21
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold', comment = 'FRA="En attente"';
        }

        field(50000; "Nom Client"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Caption = 'Nom Client';
            FieldClass = FlowField;
            TableRelation = Customer.Name;
        }
    }

}

