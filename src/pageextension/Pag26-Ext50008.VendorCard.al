namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Vendor;

pageextension 50008 "VendorCard" extends "Vendor Card" //26
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
                    //todo report spe
                    // RunReport(REPORT::"Vendor Detail Trial Balance");
                end;
            }
        }
    }
}
