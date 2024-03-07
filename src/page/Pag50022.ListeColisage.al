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
    SourceTable = Colisage;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N°"; Rec."N°")
                {
                }
                field("N° ligne"; Rec."N° ligne")
                {
                }
                field("N° expédition"; Rec."N° expédition")
                {
                }
                field("N° ligne expédition"; Rec."N° ligne expédition")
                {
                }
                field("N° article"; Rec."N° article")
                {
                    Lookup = true;
                    LookupPageID = "Item Card";
                    TableRelation = Item."No.";
                }
                field(Quantité; Rec.Quantité)
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

    actions
    {
    }
}

