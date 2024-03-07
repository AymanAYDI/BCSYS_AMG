namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Vendor;

pageextension 50009 "VendorList" extends "Vendor List" //27
{
    layout
    {

    }
    actions
    {
        //todo check modif line 158
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
                    LRecVendor: Record 23;
                begin
                    LRecVendor.SETRANGE("No.", Rec."No.");
                    //todo report spe
                    //  REPORT.RUNMODAL(REPORT::"Vendor Detail Trial Balance", true, true, LRecVendor);
                end;
            }
        }
    }
}
