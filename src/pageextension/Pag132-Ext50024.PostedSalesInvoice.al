namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;

pageextension 50024 "PostedSalesInvoice" extends "Posted Sales Invoice" //132
{
    layout
    {
        modify("External Document No.")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(CorrectInvoice)
        {
            Promoted = true;
            PromotedOnly = true;
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        DeleteErr: Label 'Deletion not authorized', Comment = 'FRA="Suppresion non autorisée"';
    begin
        Error(DeleteErr);
    end;
}
