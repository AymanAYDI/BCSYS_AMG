namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
tableextension 50016 ItemJournalLine extends "Item Journal Line" //83
{
    fields
    {
        modify("Derived from Blanket Order")
        {
            Caption = 'Derived from Blanket Order';
        }
        field(50000; "Shelf No."; Code[10])
        {
            CalcFormula = lookup(Item."Shelf No." where("No." = field("Item No.")));
            Caption = 'Shelf No.';
            FieldClass = FlowField;
        }
    }
    procedure CalcBaseQty(Qty: Decimal): Decimal;
    begin
        TESTFIELD("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    procedure CheckSerialNoQty()
    var
        IncorrectQtyForSNErr: Label 'Quantity must be -1, 0 or 1 when Serial No. is stated.';
    begin
        if ("Serial No." = '') and ("New Serial No." = '') then
            exit;
        if not ("Quantity (Base)" in [-1, 0, 1]) then
            Error(IncorrectQtyForSNErr);
    end;

    var
        //TODO check line 531
        //TODO i can't find solution for line 1461
        Text034: Label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
}

