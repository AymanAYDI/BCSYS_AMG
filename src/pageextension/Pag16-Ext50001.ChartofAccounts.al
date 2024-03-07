namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Reports;
pageextension 50001 ChartofAccounts extends "Chart of Accounts" //16
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

