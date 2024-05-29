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
                    Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
                CurrPage.Update();
            end;
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                if GRecUserSetup.GET(GCodUserID) then
                    rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
                CurrPage.Update();
            end;
        }
        moveafter("Sell-to Contact No."; "Your Reference")
        addafter("Due Date")
        {
            field("Delai de livraison"; Rec."Delai de livraison")
            {
                ApplicationArea = All;
            }
            field("Duree de validite"; Rec."Duree de validite")
            {
                ApplicationArea = All;
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
    trigger OnOpenPage()
    begin
        GCodUserID := CopyStr(UserId, 1, MaxStrLen(GCodUserID));
        if GRecUserSetup.GET(GCodUserID) and (Rec."Salesperson Code" = '') then
            Rec."Salesperson Code" := GRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.Modify();
    end;

    var
        GRecUserSetup: Record "User Setup";
        GCodUserID: Code[50];
}
