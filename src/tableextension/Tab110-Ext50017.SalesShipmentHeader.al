namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50017 SalesShipmentHeader extends "Sales Shipment Header" //110
{
    fields
    {
        //TODO traduction
        modify("On Hold")
        {
            Caption = 'On Hold', Comment = 'FRA="En attente"';
        }
        field(50000; "Packing detail"; Text[80])
        {
            Caption = 'Packing details';
            DataClassification = ToBeClassified;
        }
        field(50001; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Additional terms of delivery';
            DataClassification = ToBeClassified;
        }
    }
    //TODO Requested Delivery Date AccessByPermission
}

