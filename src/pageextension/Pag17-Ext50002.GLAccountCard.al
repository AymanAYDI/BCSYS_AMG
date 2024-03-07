namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Reports;
using Microsoft.Finance.GeneralLedger.Account;
pageextension 50002 GLAccountCard extends "G/L Account Card" //17
{
    actions
    {

        modify("Detail Trial Balance")
        {
            visible = false;
        }
        addafter("Detail Trial Balance")
        {
            action("Detail Trial Balance spe")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Detail Trial Balance';
                Image = "Report";
                RunObject = Report "G/L Detail Trial Balance";
                ToolTip = 'View a detail trial balance for the general ledger accounts that you specify.';
            }
        }

    }
}

