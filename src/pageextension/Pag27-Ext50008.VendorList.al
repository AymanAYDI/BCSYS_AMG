namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Reports;

pageextension 50008 "VendorList" extends "Vendor List" //27
{
    layout
    {

    }
    actions
    {
        //TODO check modif line 158
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
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor - Detail Trial Balance';
                Image = "Report";
                ToolTip = 'View a detail trial balance for selected vendors.';
                trigger OnAction()
                var
                    LRecVendor: Record Vendor;
                begin
                    LRecVendor.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::"Vendor Detail Trial Balance FR", true, true, LRecVendor);
                end;
            }
        }
    }
}
