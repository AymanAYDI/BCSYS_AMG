namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using BCSYS.AMGALLOIS.Basic;

pageextension 50004 "CustomerCard" extends "Customer Card" //21
{
    layout
    {
        modify("Search Name")
        {
            ApplicationArea = Advanced;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Post Code"; "Country/Region Code")
        addafter("VAT Registration No.")
        {
            field(ICE; Rec.ICE)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the ICE field.';
            }
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        addbefore("Shipping Time")
        {
            field("Compl. cond. livraison"; Rec."Compl. cond. livraison")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Compl. cond. livraison field.';
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Entries")
        {
            action("Historique Ventes")
            {
                ApplicationArea = ALL;
                Caption = 'Sales History';
                Promoted = true;
                PromotedIsBig = true;
                Image = ListPage;
                RunObject = Page "Historique ventes article";
                RunPageLink = "Customer No." = field("No.");
                RunPageView = sorting("Sales Document Date", "Quote No.", "Sales Order No.", "Sales Invoice No.", "Sales Line No.")
                                  order(descending);
                ToolTip = 'Executes the Sales History action.';
            }
        }
    }
}
