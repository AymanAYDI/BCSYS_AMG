namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Journal;
pageextension 50013 ItemJournal extends "Item Journal" //40
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
