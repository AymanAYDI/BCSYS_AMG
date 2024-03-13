namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using System.Security.User;

pageextension 50014 "SalesQuote" extends "Sales Quote" //41
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
                CurrPage.Update(true);
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
                CurrPage.Update(true);
            end;
        }
        moveafter("Sell-to Contact No."; "Your Reference")
        addafter("Due Date")
        {
            field("Délai de livraison"; rec."Délai de livraison")
            {
                ApplicationArea = ALL;
            }
            field("Durée de validité"; rec."Durée de validité")
            {
                ApplicationArea = ALL;
            }
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        addafter("Shipping Agent Code")
        {
            field("Compl. cond. livraison"; rec."Compl. cond. livraison")
            {
                ApplicationArea = ALL;
            }
        }
        modify("Bill-to Name")
        {
            Editable = true;
        }
        modify("Bill-to Address")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to Address 2")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to City")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to County")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to Post Code")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to Contact No.")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        modify("Bill-to Contact")
        {
            Enabled = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
            Editable = Rec."Bill-to Customer No." <> Rec."Sell-to Customer No.";
        }
        addbefore(Control1901314507)
        {
            //todo page spe
            // part(LPSubstitute; "Sustitutions possibles")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Substitution';
            //      ProviderID=58;
            //      ShowFilter =false; 
            //     SubPageLink = "No." = field("No.");
            // }
        }
    }
    actions
    {
        modify(Customer)
        {
            visible = false;
            //todo RunPageLink cannot be customized
            // RunPageLink = "No." = field("Sell-to Customer No.");
        }
        addafter(Customer)
        {
            action(Customerspe)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer';
                //todo global var IsCustomerOrContactNotEmpty
                // Enabled = IsCustomerOrContactNotEmpty;
                Image = Customer;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = field("Sell-to Customer No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the customer on the sales document.';
            }
        }
    }
    //todo modif line 35
    //todo modif line 1171,1179,1360,1372
    trigger OnOpenPage()
    begin
        GCodUserID := USERID;
        if GRecUserSetup.GET(GCodUserID) and (Rec."Salesperson Code" = '') then
            Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.MODIFY();
    end;

    var
        GRecUserSetup: Record "User Setup";
        GCodUserID: Code[20];
}
