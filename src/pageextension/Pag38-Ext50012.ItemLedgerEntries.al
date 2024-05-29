namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Ledger;
pageextension 50012 ItemLedgerEntries extends "Item Ledger Entries" //38
{
    layout
    {
        addafter("Invoiced Quantity")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter("Invoiced Quantity"; "Source Type")
        moveafter("Invoiced Quantity"; "Source No.")

        addafter("Cost Amount (Expected) (ACY)")
        {
            field("Shpt. Method Code"; Rec."Shpt. Method Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

