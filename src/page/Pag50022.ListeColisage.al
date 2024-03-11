namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
page 50022 ListeColisage
{
    Caption = 'Liste des articles du colisage';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Packaging;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package No."; Rec."Package No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                }
                field("Shipping Line No."; Rec."Shipping Line No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Lookup = true;
                    LookupPageID = "Item Card";
                    TableRelation = Item."No.";
                }
                field(Quantity; Rec."Quantity")
                {
                }
                field("Net unit weight"; Rec."Net unit weight")
                {
                }
                field("Gross Unit Weight"; Rec."Gross Unit Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

