namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50017 SalesShipmentHeader extends "Sales Shipment Header" //110
{
    fields
    {
        field(50000; "Packing detail"; Text[80])
        {
            Caption = 'Packing details', Comment = 'FRA="Détails d''emballage"';
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Additional terms of delivery', Comment = 'FRA="Conditions de livraison sup."';
        }
    }
}