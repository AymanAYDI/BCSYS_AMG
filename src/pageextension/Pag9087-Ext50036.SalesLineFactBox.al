namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
pageextension 50036 SalesLineFactBox extends "Sales Line FactBox" //9087
{
    layout
    {
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Reserved Receipt")
        {
            Visible = false;
        }
        modify("Gross Requirements")
        {
            Visible = false;
        }
        modify("Reserved Requirements")
        {
            Visible = false;
        }
        modify(SalesPrices)
        {
            Visible = false;
        }
        modify(SalesLineDiscounts)
        {
            Visible = false;
        }
        addlast(content)
        {
            field("Special Order Purchase No."; Rec."Special Order Purchase No.")
            {
                DrillDown = false;
                Lookup = true;
                ApplicationArea = All;
            }
            field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
                ApplicationArea = All;
            }
            field("Nom fournisseur"; GTxtNomFournisseur)
            {
                Caption = 'Nom fournisseur';
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        LRecPurchaseHeader: Record "Purchase Header";
    begin
        LRecPurchaseHeader.Reset();
        if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
            LRecPurchaseHeader.SetRange("No.", Rec."Special Order Purchase No.");
            if LRecPurchaseHeader.FINDFIRST() then
                GTxtNomFournisseur := LRecPurchaseHeader."Buy-from Vendor Name";
        end;
    end;

    var
        GTxtNomFournisseur: Text[250];
}

