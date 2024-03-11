namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Ledger;
pageextension 50003 GeneralLedgerEntries extends "General Ledger Entries" //20
{
    PromotedActionCategories = 'New,Process,Report,Entry';
    layout
    {
        addafter("Description")
        {
            field("Description longue"; Rec."Description longue")
            {
            }
        }
    }
}

