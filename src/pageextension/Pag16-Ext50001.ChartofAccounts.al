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
                ApplicationArea = All;
                Caption = 'Detail Trial Balance', Comment = 'FRA="Grand livre"';
                Image = "Report";
                RunObject = Report "G/L Detail Trial Balance";
                ToolTip = 'View a detail trial balance for the general ledger accounts that you specify.', Comment = 'FRA="Affichez un grand livre pour les comptes généraux que vous spécifiez."';
            }
        }
    }
}

