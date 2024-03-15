namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Item;
tableextension 50031 ItemCrossReference extends "Item Cross Reference" //5717
{
    //TODO check 
    fields
    {
        modify("Item No.")
        {
            trigger OnBeforeValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Cross-Reference Type")
        {
            trigger OnBeforeValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Cross-Reference Type No.")
        {
            trigger OnBeforeValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
        modify("Cross-Reference No.")
        {
            trigger OnBeforeValidate()
            begin
                FRempliDescriptionArt(rec);
            end;
        }
    }

    local procedure FRempliDescriptionArt(var Rec: Record "Item Cross Reference")
    var
        LRecItem: Record Item;
    begin
        //DEB DELPHI MHR 18/01/2019
        if LRecItem.Get(Rec."Item No.") then begin
            Rec.Description := LRecItem.Description;
            Rec."Description 2" := LRecItem."Description 2";
        end;
        //FIN DELPHI MHR 18/01/2019
    end;
}

