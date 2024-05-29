namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
tableextension 50018 SalesShipmentLine extends "Sales Shipment Line" //111
{
    fields
    {
        field(50000; "Outstanding Qty"; Decimal)
        {
            CalcFormula = lookup("Sales Line"."Outstanding Quantity" where("Document Type" = const(Order),
                                                                            Type = const(Item),
                                                                            "Document No." = field("Order No."),
                                                                            "Line No." = field("Order Line No.")));
            Caption = 'Outstanding Qty', Comment = 'FRA="Qté restante"';
            FieldClass = FlowField;
        }
        field(50001; "Outstandin Qty report"; Decimal)
        {
            Caption = 'Outstanding Qty', Comment = 'FRA="Qté restante"';
        }
        field(50010; "No. Colis"; Code[20])
        {
            TableRelation = Colis."No." where("No. expedition" = field("Document No."));
            Caption = 'No. Colis', Comment = 'FRA="N° Colis"';
        }
        field(50020; "Code ONU"; Code[10])
        {
            CalcFormula = lookup(Item."Code ONU" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Code ONU', Comment = 'FRA="Code ONU"';
        }
    }
}

