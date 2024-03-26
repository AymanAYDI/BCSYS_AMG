namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Reports;

pageextension 50007 "VendorCard" extends "Vendor Card" //26
{
    layout
    {
        modify("No.")
        {
            Importance = Promoted;
        }
        moveafter("Post Code"; "Country/Region Code")
    }
    actions
    {
        addafter("Vendor - Balance to Date")
        {
            action("Vendor - Detail Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor - Detail Trial Balance';
                Image = "Report";
                ToolTip = 'View a detail Trial balance for selected vendors.';

                trigger OnAction()
                begin
                    //TODO report spe
                    // RunReport(REPORT::"Vendor Detail Trial Balance");
                end;
            }
        }
    }
}
