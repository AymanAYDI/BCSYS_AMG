namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;

pageextension 50019 "PurchaseInvoice" extends "Purchase Invoice" //51
{
    layout
    {
        modify("Pay-to Name")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Pay-to Address")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Address 2")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to City")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to County")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Post Code")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Country/Region Code")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Contact No.")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Contact")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
    }
    actions
    {
        modify(Vendor)
        {
            Visible = false;
        }
        addafter(Vendor)
        {
            action(Vendorspe)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                RunObject = Page "Vendor Card";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }
    }
    //TODO line 45,1079,1225,1248,1501,1679
}
