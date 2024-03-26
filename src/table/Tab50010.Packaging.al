namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
table 50010 Packaging
{
    DrillDownPageID = Package;
    LookupPageID = Package;

    fields
    {
        field(1; "Package No."; Code[20])
        {
            TableRelation = Package."Package No.";
            Caption = 'Package No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
        }
        field(6; "Shipping Line No."; Integer)
        {
            TableRelation = "Sales Shipment Line"."Line No." where("Document No." = field("Shipping No."));
            Caption = 'Shipping Line No.';
        }
        field(10; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }
        field(15; "Item No."; Code[20])
        {
            FieldClass = Normal;
            Caption = 'Item No.';
        }
        field(20; "Net unit weight"; Decimal)
        {
            CalcFormula = lookup(Item."Net Weight" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Net unit weight';
        }
        field(21; "Gross Unit Weight"; Decimal)
        {
            CalcFormula = lookup(Item."Gross Weight" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Gross Unit Weight';
        }
    }

    keys
    {
        key(Key1; "Package No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Shipping No.", "Shipping Line No.")
        {
        }
    }

    fieldgroups
    {
        //TODO Field80 ,Field100
        // fieldgroup(DropDown; "Package No.", "Line No.", Field80, Field100)
        // {
        // }
    }

    procedure NextLineNo(PNumColis: Code[20]) Return: Integer
    var
        LRecColisage: Record Packaging;
    begin
        LRecColisage.SetRange("Package No.", PNumColis);
        if LRecColisage.FINDLAST() then
            Return := LRecColisage."Line No." + 1;
    end;

    procedure FCalcPoidsNetColis(PColisNo: Code[20]) Return: Decimal
    var
        LRecColissage: Record Packaging;
        LDecPoidsNet: Decimal;
    begin
        LDecPoidsNet := 0;
        LRecColissage.SetRange("Package No.", PColisNo);
        if LRecColissage.FINDFIRST() then
            repeat
                LRecColissage.CALCFIELDS("Net unit weight");
                LDecPoidsNet += (LRecColissage."Net unit weight" * LRecColissage.Quantity);
            until LRecColissage.NEXT() = 0
        else
            LDecPoidsNet := 0;
        Return := LDecPoidsNet;
    end;
}

