namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Ledger;
pageextension 50012 ItemLedgerEntries extends "Item Ledger Entries" //38
{
    PromotedActionCategories = 'New,Process,Report,Entry';
    layout
    {
        addafter("Invoiced Quantity")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.';
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
        }
        moveafter("Invoiced Quantity"; "Source No.")
        moveafter("Invoiced Quantity"; "Source Type")

        addafter("Cost Amount (Expected) (ACY)")
        {
            field("Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment Method Code field.';
            }
        }
    }
}

