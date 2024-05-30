namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;
pageextension 50051 PurchaseLineFactBox extends "Purchase Line FactBox" //9100
{
    layout
    {
        addafter(PurchaseLineDiscounts)
        {
            field("Special Order Sales No."; Rec."Special Order Sales No.")
            {
                ApplicationArea = All;
            }
            field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
            {
                ApplicationArea = All;
            }
            field("Nom Client"; GTxtNomClient)
            {
                Caption = 'Nom Client';
                ApplicationArea = All;
            }
        }
    }

    var
        GTxtNomClient: Text[250];

    trigger OnAfterGetRecord()
    var
        LRecSalesHeader: Record "Sales Header";
    begin
        // DELPHI AUB 17.06.2019
        LRecSalesHeader.RESET();
        if (Rec."Special Order Sales No." <> '') and (Rec."Special Order Sales Line No." <> 0) then begin
            LRecSalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
            if LRecSalesHeader.FINDFIRST() then
                GTxtNomClient := LRecSalesHeader."Sell-to Customer Name";
        end;
        // END DELPHI AUB
    end;
}

