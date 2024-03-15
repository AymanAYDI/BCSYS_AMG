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
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ToolTip = 'Specifies the value of the Shipping No. field.';
                }
                field("Shipping Line No."; Rec."Shipping Line No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Lookup = true;
                    LookupPageID = "Item Card";
                    TableRelation = Item."No.";
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Quantity; Rec."Quantity")
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Net unit weight"; Rec."Net unit weight")
                {
                    ToolTip = 'Specifies the value of the Net unit weight field.';
                }
                field("Gross Unit Weight"; Rec."Gross Unit Weight")
                {
                    ToolTip = 'Specifies the value of the Gross Unit Weight field.';
                }
            }
        }
    }

    actions
    {
    }
}

