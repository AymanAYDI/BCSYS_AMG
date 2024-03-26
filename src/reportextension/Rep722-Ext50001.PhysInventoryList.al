namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Reports;

reportextension 50001 "PhysInventoryList" extends "Phys. Inventory List" //722
{
    dataset
    {
        modify("Item Journal Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                "Item Journal Line".CALCFIELDS("Shelf No.");
            end;
        }
        add("Item Journal Line")
        {
            column("ShelfNo_ItemJournalLine"; "Item Journal Line"."Shelf No.")
            {
            }
        }

    }
}
