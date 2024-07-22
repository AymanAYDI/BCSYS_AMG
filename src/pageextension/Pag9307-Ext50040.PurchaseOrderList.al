namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
pageextension 50040 PurchaseOrderList extends "Purchase Order List" //9307
{
    layout
    {
        addafter("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Description")
        {
            field("Supplier Ack. date"; Rec."Supplier Ack. date")
            {
                Caption = 'Supplier acknowledgment', Comment = 'FRA="Accusé réception fournisseur"';
                ApplicationArea = All;
            }
            field("Supplier Ack. date validation"; Rec."Supplier Ack. date validation")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.", "Document Type");
        Rec.Ascending(false);
    end;
}

