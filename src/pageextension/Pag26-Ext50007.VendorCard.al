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
    }
    actions
    {
        addafter("Vendor - Balance to Date")
        {
            action("Vendor - Detail Trial Balance")
            {
                ApplicationArea = All;
                Caption = 'Vendor - Detail Trial Balance', Comment = 'FRA="Fourn. : Grand livre fourn."';
                Image = "Report";

                trigger OnAction()
                begin
                    RunReport(REPORT::"Vendor - Detail Trial Balance");
                end;
            }
        }
    }
}
