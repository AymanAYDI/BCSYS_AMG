namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Counting.Journal;
pageextension 50044 PhysInventoryJournal extends "Phys. Inventory Journal" //392
{
    layout
    {
        addafter("Location Code")
        {
            field("Shelf No."; Rec."Shelf No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

