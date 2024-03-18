namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using BCSYS.AMGALLOIS.Basic;
using System.Security.User;

pageextension 50015 "SalesOrder" extends "Sales Order" //42
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
            end;
        }
        moveafter("Promised Delivery Date"; "Your Reference")
        modify("External Document No.")
        {
            Visible = false;
        }
        modify(SalesLines)
        {
            Visible = false;
        }
        addafter(SalesLines)
        {
            part(SalesLinesspe; "Sales Order Subform Color")
            {
                //TODO var removed
                ApplicationArea = Basic, Suite;
                //  Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        addafter("Prices Including VAT")
        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
            }
        }
        modify("Bill-to Name")
        {
            Enabled = true;
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
        modify("Bill-to Country/Region Code")
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
        addbefore(ApprovalFactBox)
        {
            part(Substitution; "Sustitutions possibles")
            {
                ApplicationArea = Basic, Suite;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                ShowFilter = false;
            }
        }
    }
    actions
    {
        modify(Customer)
        {
            Visible = false;
        }
        addafter(Customer)
        {
            action(Customerspe)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer';
                Enabled = (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
                Image = Customer;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = field("Sell-to Customer No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the customer on the sales document.';
            }
        }
        modify("Work Order")
        {
            //TODO check line 1165
            ApplicationArea = all;
        }
    }
    var
        GRecUserSetup: Record "User Setup";
        GCodUserID: Code[20];

    trigger OnOpenPage()
    begin
        Rec."Posting Date" := 0D;
        GCodUserID := USERID;
        if GRecUserSetup.GET(GCodUserID) and (Rec."Salesperson Code" = '') then
            Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then Rec.Modify();
    end;
    //TODO i can't find solution for line 38
    //TODO check line 1318
    //TODO check line 1658,1763,1917
}
