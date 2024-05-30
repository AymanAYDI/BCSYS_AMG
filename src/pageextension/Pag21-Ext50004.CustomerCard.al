namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Reports;
pageextension 50004 "CustomerCard" extends "Customer Card" //21
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field(ICE; Rec.ICE)
            {
                Caption = 'ICE';
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Service Code")
        {
            field("Compl. cond. livraison"; Rec."Compl. cond. livraison")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Entries")
        {
            action("Historique Ventes")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = Page "Historique ventes article";
                RunPageLink = "No. client" = field("No.");
                RunPageView = sorting("Date document vente", "No. devis", "No. commande vente", "No. facture vente", "No. ligne vente")
                              order(descending);
            }
        }
        addafter("Report Statement")
        {
            action(ReportCustomerDetailTrial)
            {
                ApplicationArea = All;
                Caption = 'Customer - Detail Trial Bal.', Comment = 'FRA="Clients : Grand livre client"';
                Image = "Report";

                trigger OnAction()
                begin
                    //DELPHI AUB 19.05.2020
                    RunReport(REPORT::"Customer Detail Trial Balance", Rec."No.");
                    //END DELPHI AUB
                end;
            }
        }
    }
}
