namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Requisition;

pageextension 50032 "ReqWorksheet" extends "Req. Worksheet" //291
{
    layout
    {
        addafter(Type)
        {
            field("Sales Order No."; rec."Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order No. field.';
            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Line No. field.';
            }
            field("Customer Name"; rec."Customer Name")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Nom du client field.';
            }
        }
        moveafter("Sales Order Line No."; "Sell-to Customer No.")
        addafter("Vendor No.")
        {
            field("Supplier Name"; rec."Supplier Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Nom du fournisseur field.';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Customer Name", "Supplier Name");
    end;
}
