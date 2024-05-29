namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Receivables;
pageextension 50006 CustomerLedgerEntries extends "Customer Ledger Entries" //25   
{
    layout
    {
        addafter("Customer Name")
        {
            field("Nom Client"; Rec."Nom Client")
            {
                ApplicationArea = All;
            }
        }
    }
}

