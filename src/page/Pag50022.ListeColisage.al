namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
page 50022 ListeColisage
{
    Caption = 'Liste des articles du colisage', Comment = 'FRA="Liste des articles du colisage"';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Colisage;
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N°"; Rec."No.")
                {
                }
                field("N° ligne"; Rec."No. ligne")
                {
                }
                field("N° expédition"; Rec."No. expedition")
                {
                }
                field("N° ligne expédition"; Rec."No. ligne expedition")
                {
                }
                field("N° article"; Rec."No. article")
                {
                    Lookup = true;
                    LookupPageID = "Item Card";
                    TableRelation = Item."No.";
                }
                field(Quantité; Rec.Quantite)
                {
                }
                field("Poids Unitaire Net"; Rec."Poids Unitaire Net")
                {
                }
                field("Poids Unitaire Brut"; Rec."Poids Unitaire Brut")
                {
                }
            }
        }
    }
}

