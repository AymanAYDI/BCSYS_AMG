namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Reports;

pageextension 50008 "VendorList" extends "Vendor List" //27
{
    actions
    {
        modify("Item Refe&rences")
        {
            Promoted = true;
            PromotedOnly = true;
        }
        modify("Vendor - Detail Trial Balance")
        {
            Visible = false;
        }
        addafter("Vendor - Detail Trial Balance")
        {
            action("Vendor - Detail Trial Balance spe")
            {
                ApplicationArea = All;
                Caption = 'Vendor - Detail Trial Balance', Comment = 'FRA="Fourn. : Grand livre fourn."';
                Image = "Report";
                trigger OnAction()
                var
                    LRecVendor: Record Vendor;
                begin
                    LRecVendor.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::"Vendor - Detail Trial Balance", true, true, LRecVendor);
                end;
            }
        }
    }
}
