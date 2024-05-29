namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
pageextension 50029 PostedSalesInvoices extends "Posted Sales Invoices" //143
{
    layout
    {
        addafter("Document Exchange Status")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        DeleteErr: Label 'Deletion not authorized', Comment = 'FRA="Suppresion non autorisée"';
    begin
        Error(DeleteErr);
    end;

}

