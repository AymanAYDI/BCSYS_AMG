namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.Currency;
tableextension 50009 PurchaseHeader extends "Purchase Header" //38
{
    fields
    {
        modify("Pay-to Name")
        {
            TableRelation = Vendor;
            //todo Onlookup
        }
        //todo Onlookup "Pay-to Contact"
        //todo Onlookup Buy-from Vendor Name
        //todo Onlookup Buy-from Contact
        modify("On Hold")
        {
            Caption = 'On Hold';
        }
        modify("Buy-from Vendor Name")
        {
            TableRelation = Vendor;
        }
        field(50000; "Supplier Ack. date"; Date)
        {
            Caption = 'Supplier acknowledgment date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Supplier Ack. date validation"; Boolean)
        {
            Caption = 'Validate supplier acknowledgment';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Supplier Ack. date validation" then
                    Rec."Supplier Ack. date" := TODAY;
            end;
        }
    }
    procedure UpdatePrepmtAmounts(var PurchaseLine: Record "Purchase Line")
    var
        Currency: Record Currency;
    begin
        Currency.Initialize("Currency Code");
        if "Document Type" = "Document Type"::Order then begin
            PurchaseLine."Prepmt. Line Amount" := Round(
                PurchaseLine."Line Amount" * PurchaseLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
            if Abs(PurchaseLine."Inv. Discount Amount" + PurchaseLine."Prepmt. Line Amount") > Abs(PurchaseLine."Line Amount") then
                PurchaseLine."Prepmt. Line Amount" := PurchaseLine."Line Amount" - PurchaseLine."Inv. Discount Amount";
        end;
    end;
    //todo Onvalidate Vendor Shipment No. line 855
    //todo i can't find solution for prod InitRecord
    //todo i can't find solution for line 2394
    //todo i can't find solution for line 2569
}

