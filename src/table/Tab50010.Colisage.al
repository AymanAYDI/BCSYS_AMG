namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.History;
table 50010 Colisage
{
    DrillDownPageID = 50020;
    LookupPageID = 50020;

    fields
    {
        field(1; "N°"; Code[20])
        {
            TableRelation = Colis."N°";
        }
        field(2; "N° ligne"; Integer)
        {
        }
        field(5; "N° expédition"; Code[20])
        {
        }
        field(6; "N° ligne expédition"; Integer)
        {
            TableRelation = "Sales Shipment Line"."Line No." where("Document No." = field("N° expédition"));
        }
        field(10; "Quantité"; Decimal)
        {
        }
        field(15; "N° article"; Code[20])
        {
            FieldClass = Normal;
        }
        field(20; "Poids Unitaire Net"; Decimal)
        {
            CalcFormula = lookup(Item."Net Weight" where("No." = field("N° article")));
            FieldClass = FlowField;
        }
        field(21; "Poids Unitaire Brut"; Decimal)
        {
            CalcFormula = lookup(Item."Gross Weight" where("No." = field("N° article")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "N°", "N° ligne")
        {
            Clustered = true;
        }
        key(Key2; "N° expédition", "N° ligne expédition")
        {
        }
    }

    fieldgroups
    {
        //todo Field80 ,Field100
        // fieldgroup(DropDown; "N°", "N° ligne", Field80, Field100)
        // {
        // }
    }

    procedure NextLineNo(PNumColis: Code[20]) Return: Integer
    var
        LRecColisage: Record Colisage;
    begin
        LRecColisage.SetRange("N°", PNumColis);
        if LRecColisage.FINDLAST() then
            Return := LRecColisage."N° ligne" + 1;
    end;

    procedure FCalcPoidsNetColis(PColisNo: Code[10]) Return: Decimal
    var
        LRecColissage: Record Colisage;
        LDecPoidsNet: Decimal;
    begin
        LDecPoidsNet := 0;
        LRecColissage.SetRange("N°", PColisNo);
        if LRecColissage.FINDFIRST() then
            repeat
                LRecColissage.CALCFIELDS("Poids Unitaire Net");
                LDecPoidsNet += (LRecColissage."Poids Unitaire Net" * LRecColissage.Quantité);
            until LRecColissage.NEXT() = 0
        else
            LDecPoidsNet := 0;
        Return := LDecPoidsNet;
    end;
}

