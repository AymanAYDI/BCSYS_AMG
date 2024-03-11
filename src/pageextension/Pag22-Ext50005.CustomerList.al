// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.BCSYS_AMG;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Reports;
using BCSYS.AMGALLOIS.Basic;

pageextension 50005 CustomerList extends "Customer List" //22
{
    layout
    {
        Addafter(Name)
        {
            field(Historique; Rec.Historique)
            {
                TableRelation = "Sales Archive"."Customer No.";
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Historique field.';
                Trigger OnLookup(var Text: Text): Boolean
                var
                    Historique: Record "Sales Archive";
                begin
                    //DELPHI AUB 30.06.2020
                    Historique.SETRANGE("Customer No.", Rec."No.");
                    PAGE.RUNMODAL(PAGE::"Historique ventes article", Historique);
                    //END DELPHI AUB
                end;
            }
        }
        addafter("Phone No.")
        {
            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mobile Phone No. field.';
            }
        }
        Addafter("Payments (LCY)")
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the City field.';
            }
            field("Fax No."; Rec."Fax No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fax No. field.';
            }

        }
    }
    Actions
    {

        addafter("Item &Tracking Entries")
        {
            action("Historique Ventes")
            {
                ApplicationArea = All;
                RunObject = Page "Historique ventes article";
                RunPageView = SORTING("Reference", "Customer No.", "Quote No.", "Sales Line No.", "Sales Order No.", "Sales Invoice No.")
                                  ORDER(Descending);
                RunPageLink = "Customer No." = FIELD("No.");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ListPage;
                ToolTip = 'Executes the Historique Ventes action.';
            }
        }
        modify(BackgroundStatement)
        {
            Visible = false;
        }
        modify(ReportCustomerDetailTrial)
        {
            visible = false;
        }
        Addafter(ReportCustomerTrialBalance)
        {
            action("Report&CustomerDetailTrial")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer - Detail Trial Bal.';
                Image = "Report";
                ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    //DELPHI AUB 19.05.2020
                    Customer.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::"Customer Detail Trial Balance", TRUE, TRUE, Customer);
                    //END DELPHI AUB
                end;
            }
        }
    }
    // trigger OnOpenPage();
    // begin
    //     Message('App published: Hello world');
    // end;

}