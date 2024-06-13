namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Reports;

pageextension 50005 CustomerList extends "Customer List" //22
{

    layout
    {
        addafter("Name 2")
        {
            field(Historique; Rec.Historique)
            {
                TableRelation = "Historique ventes"."No. client";
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    LRecHisto: Record "Historique ventes";
                begin
                    //DELPHI AUB 30.06.2020
                    LRecHisto.SETRANGE("No. client", Rec."No.");
                    PAGE.RUNMODAL(Page::"Historique ventes article", LRecHisto);
                    //END DELPHI AUB
                end;
            }
        }
        addafter("Phone No.")
        {
            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payments (LCY)")
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Fax No."; Rec."Fax No.")
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
        modify(ReportCustomerDetailTrial)
        {
            Visible = false;
        }
        addafter(ReportCustomerDetailTrial)
        {
            action(ReportCustomerDetailTrial2)
            {
                ApplicationArea = All;
                Image = "Report";
                Caption = 'Customer - Detail Trial Bal.', Comment = 'FRA="Clients : Grand livre client"';

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    //DELPHI AUB 19.05.2020
                    Customer.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::"Customer Detail Trial Balance", true, true, Customer);
                    //END DELPHI AUB
                end;
            }
        }
    }
}