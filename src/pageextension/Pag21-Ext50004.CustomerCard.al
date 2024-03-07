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
                RunPageLink = "N° client" = field("No.");
                RunPageView = sorting("Date document vente", "N° devis", "N° commande vente", "N° facture vente", "N° ligne vente")
                                  order(descending);
            }
        }
    }
}
