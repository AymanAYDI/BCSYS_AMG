namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
pageextension 50011 ItemList extends "Item List" //31
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field(Historique; Rec.Historique)
            {
                TableRelation = "Historique ventes".Reference;
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    LRecHisto: Record "Historique ventes";
                begin
                    LRecHisto.SetRange(Reference, Rec."No.");
                    PAGE.RunModal(PAGE::"Historique ventes article", LRecHisto);
                end;
            }
        }
    }
    actions
    {
        addafter(Translations)
        {
            action(ONU)
            {
                Caption = 'ONU', Comment = 'FRA="ONU"';
                Image = "Table";
                RunObject = Page "Liste ONU";
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Unit Price");
    end;
}

