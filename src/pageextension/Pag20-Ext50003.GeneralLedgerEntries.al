namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Ledger;
pageextension 50003 GeneralLedgerEntries extends "General Ledger Entries" //20
{
    PromotedActionCategories = 'New,Process,Report,Entry';
    layout
    {
        addafter("Description")
        {
            field("Long description"; Rec."Long description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description longue field.';
            }
        }
    }
}

