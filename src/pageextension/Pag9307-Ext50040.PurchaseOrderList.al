namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
pageextension 50040 PurchaseOrderList extends "Purchase Order List" //9307
{
    //TODO SourceTableView cannot be customized
    layout
    {
        addafter("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.';
            }
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expected Receipt Date field.';
            }
        }
        addafter("Posting Description")
        {
            field("Supplier Ack. date"; Rec."Supplier Ack. date")
            {
                Caption = 'Supplier acknowledgment';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier acknowledgment field.';
            }
            field("Supplier Ack. date validation"; Rec."Supplier Ack. date validation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Validate supplier acknowledgment field.';
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

