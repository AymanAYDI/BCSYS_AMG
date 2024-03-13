namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
tableextension 50018 SalesShipmentLine extends "Sales Shipment Line" //111
{
    fields
    {
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }
        field(50000; "Outstanding Qty"; Decimal)
        {
            CalcFormula = lookup("Sales Line"."Outstanding Quantity" where("Document Type" = const(Order),
                                                                            Type = const(Item),
                                                                            "Document No." = field("Order No."),
                                                                            "Line No." = field("Order Line No.")));
            Caption = 'Outstanding Qty';
            FieldClass = FlowField;
        }
        field(50001; "Outstandin Qty report"; Decimal)
        {
            Caption = 'Outstanding Qty';
        }
        field(50010; "N° Package"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Package."Package No." where("Shipping No." = field("Document No."));
        }
        field(50020; "Code ONU"; Code[10])
        {
            CalcFormula = lookup(Item."Code ONU" where("No." = field("No.")));
            FieldClass = FlowField;
        }
    }
    procedure ZeroIsBlanckInteger("Integer": Integer) Return: Text[50]
    begin
        if Integer <> 0 then
            Return := FORMAT(Integer)
        else
            Return := '';
    end;

    procedure ZeroIsBlanckDecimal(Decimale: Decimal) Return: Text[50]
    begin
        if Decimale <> 0 then
            Return := FORMAT(Decimale, 10, '<Standard Format,0>')
        else
            Return := '';
    end;
    //todo Requested Delivery Date AccessByPermission
}

