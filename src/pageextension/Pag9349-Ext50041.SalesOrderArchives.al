namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Archive;
pageextension 50041 SalesOrderArchives extends "Sales Order Archives" //9349
{
    layout
    {
        addafter("Interaction Exist")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

