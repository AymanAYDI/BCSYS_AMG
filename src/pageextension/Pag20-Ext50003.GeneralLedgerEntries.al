namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Ledger;
pageextension 50003 GeneralLedgerEntries extends "General Ledger Entries" //20
{
    layout
    {
        addafter("Description")
        {
            field("Long description"; Rec."Description longue")
            {
                ApplicationArea = All;
            }
        }
    }
}

