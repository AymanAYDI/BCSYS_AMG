namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Archive;
pageextension 50041 SalesOrderArchives extends "Sales Order Archives" //9349
{
    layout
    {
        addafter("Interaction Exist")
        {
            field("Order Date"; Rec."Order Date")
            {
            }
        }
    }
    actions
    {
    }
}

