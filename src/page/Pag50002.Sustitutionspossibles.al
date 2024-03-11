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

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Substitute No."; Rec."Substitute No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field("Unité de base"; Rec."Unité de base")
                {
                }
                field("Unité Achat"; Rec."Unité Achat")
                {
                }
                field(Interchangeable; Rec.Interchangeable)
                {
                }
                field(Condition; Rec.Condition)
                {
                    Visible = false;
                }
                field("Dernier Prix achat"; Rec."Dernier Prix achat")
                {
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                }
                field("Nom Fournisseur"; Rec."Nom Fournisseur")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

