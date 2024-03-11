namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Catalog;
tableextension 50031 ItemCrossReference extends "Item Cross Reference" //5717
{
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

    local procedure FRempliDescriptionArt(var Rec: Record 5717)
    var
        LRecItem: Record 27;
    begin
        //DEB DELPHI MHR 18/01/2019
        if LRecItem.Get(Rec."Item No.") then begin
            Rec.Description := LRecItem.Description;
            Rec."Description 2" := LRecItem."Description 2";
        end;
        //FIN DELPHI MHR 18/01/2019
    end;
}

