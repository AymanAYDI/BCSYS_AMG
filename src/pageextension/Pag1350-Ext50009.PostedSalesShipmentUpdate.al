namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;

pageextension 50009 "PostedSalesShipmentUpdate" extends "Posted Sales Shipment - Update" //1350
{
    layout
    {
        addlast(General)
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addfirst(Shipping)
        {
            field("Compl. cond. livraison"; Rec."Compl. cond. livraison")
            {
                ApplicationArea = All;
            }
        }
    }
}
