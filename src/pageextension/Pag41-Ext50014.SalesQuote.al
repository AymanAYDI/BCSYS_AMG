namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using System.Security.User;
using BCSYS.AMGALLOIS.Basic;

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
            field("Delivery time"; rec."Delivery time")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Délai de livraison field.';
            }
            field("Validity period"; rec."Validity period")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Durée de validité field.';
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
                ToolTip = 'Specifies the value of the Compl. cond. livraison field.';
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
            part(LPSubstitute; "Sustitutions possibles")
            {
                ApplicationArea = All;
                Caption = 'Substitution';
                Provider = SalesLines;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addafter(Customer)
        {
            action(Customerspe)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer';
                Enabled = (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
                Image = Customer;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = field("Sell-to Customer No."),
                                  "Date Filter" = field("Date Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the customer on the sales document.';
            }
        }
    }
    //TODO modif line 35
    //TODO modif line 1171,1179,1360,1372
    trigger OnOpenPage()
    begin
        GCodUserID := USERID;
        if GRecUserSetup.GET(GCodUserID) and (Rec."Salesperson Code" = '') then
            Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.Modify();
    end;

    var
        GRecUserSetup: Record "User Setup";
        GCodUserID: Code[50];
}
