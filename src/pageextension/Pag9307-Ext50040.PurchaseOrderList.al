namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Document;
pageextension 50040 PurchaseOrderList extends "Purchase Order List" //9307
{
    //todo SourceTableView cannot be customized
    layout
    {
        addafter("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
            }
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
            }
        }
        addafter("Posting Description")
        {
            field("Supplier Ack. date"; Rec."Supplier Ack. date")
            {
                Caption = 'Supplier acknowledgment';
            }
            field("Supplier Ack. date validation"; Rec."Supplier Ack. date validation")
            {
            }
        }
    }
    actions
    {
        modify("Delete Invoiced")
        {
            ApplicationArea = All;
        }
    }
}

