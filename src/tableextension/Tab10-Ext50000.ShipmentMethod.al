namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Shipping;
tableextension 50000 ShipmentMethod extends "Shipment Method" //10
{
    fields
    {
        field(50000; Incoterms; Boolean)
        {
            Caption = 'Incoterms';
        }
    }
}

