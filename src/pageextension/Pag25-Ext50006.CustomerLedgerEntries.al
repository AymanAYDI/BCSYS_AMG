namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Receivables;
pageextension 50006 CustomerLedgerEntries extends "Customer Ledger Entries" //25   
{
    PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
    layout
    {
        addafter("Customer Name")
        {
            field("Nom Client"; Rec."Nom Client") //TODO Verif
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Nom Client field.';
            }
        }
    }
}

