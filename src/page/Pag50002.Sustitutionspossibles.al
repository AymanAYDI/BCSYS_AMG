namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item.Substitution;

page 50002 "Sustitutions possibles"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Item Substitution";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Substitute No."; Rec."Substitute No.")
                {
                    ToolTip = 'Specifies the value of the Substitute No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("Basic unit"; Rec."Basic unit")
                {
                    ToolTip = 'Specifies the value of the Unité de Base field.';
                }
                field("Purchasing unit"; Rec."Purchasing unit")
                {
                    ToolTip = 'Specifies the value of the Unité Achat field.';
                }
                field(Interchangeable; Rec.Interchangeable)
                {
                    ToolTip = 'Specifies the value of the Interchangeable field.';
                }
                field(Condition; Rec.Condition)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Condition field.';
                }
                field("Last Purchase Price"; Rec."Last Purchase Price")
                {
                    ToolTip = 'Specifies the value of the Dernier Prix achat field.';
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Fournisseur field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Nom Fournisseur field.';
                }
            }
        }
    }

    actions
    {
    }
}

