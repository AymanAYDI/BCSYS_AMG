namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Sales.History;
table 50010 Colisage
{
    DrillDownPageID = Package;
    LookupPageID = Package;

    fields
    {
        field(1; "No."; Code[10])
        {
            TableRelation = Colis."No.";
            Caption = 'N°';
        }
        field(2; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(5; "No. expedition"; Code[20])
        {
            Caption = 'N° expédition';
        }
        field(6; "No. ligne expedition"; Integer)
        {
            TableRelation = "Sales Shipment Line"."Line No." where("Document No." = field("No. expedition"));
            Caption = 'N° ligne expédition';
        }
        field(10; "Quantite"; Decimal)
        {
            Caption = 'Quantité';
        }
        field(15; "No. article"; Code[20])
        {
            FieldClass = Normal;
            Caption = 'N° article';
        }
        field(20; "Poids Unitaire Net"; Decimal)
        {
            CalcFormula = lookup(Item."Net Weight" where("No." = field("No. article")));
            FieldClass = FlowField;
            Caption = 'Poids Unitaire Net';
        }
        field(21; "Poids Unitaire Brut"; Decimal)
        {
            CalcFormula = lookup(Item."Gross Weight" where("No." = field("No. article")));
            FieldClass = FlowField;
            Caption = 'Poids Unitaire Brut';
        }
    }

    keys
    {
        key(Key1; "No.", "No. ligne")
        {
            Clustered = true;
        }
        key(Key2; "No. expedition", "No. ligne expedition")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "No. ligne")
        {
        }
    }

    procedure NextLineNo(PNumColis: Code[20]) Return: Integer
    var
        LRecColisage: Record Colisage;
    begin
        LRecColisage.SETRANGE("No.", PNumColis);
        if LRecColisage.FINDLAST() then
            Return := LRecColisage."No. ligne" + 1;
    end;

    procedure FCalcPoidsNetColis(PColisNo: Code[10]) Return: Decimal
    var
        LRecColissage: Record Colisage;
        LDecPoidsNet: Decimal;
    begin
        LDecPoidsNet := 0;
        LRecColissage.SETRANGE("No.", PColisNo);
        if LRecColissage.FINDFIRST() then
            repeat
                LRecColissage.CALCFIELDS("Poids Unitaire Net");
                LDecPoidsNet += (LRecColissage."Poids Unitaire Net" * LRecColissage."Quantite");
            until LRecColissage.NEXT() = 0
        else
            LDecPoidsNet := 0;
        Return := LDecPoidsNet;
    end;
}

