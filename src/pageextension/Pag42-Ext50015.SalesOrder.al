namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
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
                CurrPage.Update();
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
                CurrPage.Update();
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
            part(SalesLinesColor; "Sales Order Subform Color")
            {
                ApplicationArea = All;
                Editable = IsSalesLinesEditable2;
                Enabled = IsSalesLinesEditable2;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        addafter("Prices Including VAT")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addbefore(ApprovalFactBox)
        {
            part(Substitution; "Sustitutions possibles")
            {
                ApplicationArea = All;
                Provider = SalesLinesColor;
                SubPageLink = "No." = field("No.");
                ShowFilter = false;
            }
        }
    }
    var
        GRecUserSetup: Record "User Setup";
        GCodUserID: Code[50];
        IsSalesLinesEditable2: Boolean;

    trigger OnOpenPage()
    begin
        Rec."Posting Date" := 0D;
        GCodUserID := CopyStr(UserId, 1, MaxStrLen(GCodUserID));
        if GRecUserSetup.GET(GCodUserID) and (Rec."Salesperson Code" = '') then
            Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.Modify();
    end;

    trigger OnAfterGetRecord()
    begin
        IsSalesLinesEditable2 := Rec.SalesLinesEditable();
    end;
}
