namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
tableextension 50016 ItemJournalLine extends "Item Journal Line" //83
{
    fields
    {
        field(50000; "Shelf No."; Code[10])
        {
            CalcFormula = lookup(Item."Shelf No." where("No." = field("Item No.")));
            Caption = 'Shelf No.', Comment = 'FRA="N° emplacement"';
            FieldClass = FlowField;
        }
    }
}

