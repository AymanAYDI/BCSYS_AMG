namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Customer;

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
                Caption = 'Historique Ventes';
                Promoted = true;
                PromotedIsBig = true;
                Image = ListPage;
                RunObject = Page 50010;
                RunPageLink = "Customer No." = field("No.");
                RunPageView = sorting("Sales Document Date", "Quote No.", "Sales Order No.", "Sales Invoice No.", "Sales Line No.")
                                  order(descending);
            }
        }
    }
}
