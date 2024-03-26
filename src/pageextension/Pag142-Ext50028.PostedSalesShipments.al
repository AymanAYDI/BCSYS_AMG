namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;

pageextension 50028 "PostedSalesShipments" extends "Posted Sales Shipments" //142
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Your Reference"; rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
        }
    }
    actions
    {
        modify("Update Document")
        {
            Visible = false;
        }
    }
}
