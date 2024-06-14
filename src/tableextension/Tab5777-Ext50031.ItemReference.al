namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Item;
tableextension 50031 ItemReference extends "Item Reference" //5777
{
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Reference Type")
        {
            trigger OnAfterValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Reference No.")
        {
            trigger OnAfterValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
    }

    local procedure FRempliDescriptionArt(var ItemReference: Record "Item Reference")
    var
        LRecItem: Record Item;
    begin
        if LRecItem.Get(ItemReference."Item No.") then begin
            ItemReference.Description := LRecItem.Description;
            ItemReference."Description 2" := LRecItem."Description 2";
        end;
    end;
}

