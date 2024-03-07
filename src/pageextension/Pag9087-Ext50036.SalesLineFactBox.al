namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
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
        addafter(Item)
        {
            field("Special Order Purchase No."; Rec."Special Order Purchase No.")
            {
                DrillDown = false;
                Lookup = true;
            }
            field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
            }
            field("Nom fournisseur"; GTxtNomFournisseur)
            {
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        LRecPurchaseHeader: Record 38;
    begin
        LRecPurchaseHeader.RESET();
        if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
            LRecPurchaseHeader.SETRANGE("No.", Rec."Special Order Purchase No.");
            if LRecPurchaseHeader.FINDFIRST() then
                GTxtNomFournisseur := LRecPurchaseHeader."Buy-from Vendor Name";
        end;
    end;
    //todo i can't find solution for 194
    var
        GTxtNomFournisseur: Text[250];
}

