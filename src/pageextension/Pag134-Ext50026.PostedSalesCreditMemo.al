namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
pageextension 50026 PostedSalesCreditMemo extends "Posted Sales Credit Memo" //134
{
    trigger OnDeleteRecord(): Boolean
    var
        DeleteErr: Label 'Deletion not authorized', Comment = 'FRA="Suppresion non autorisée"';
    begin
        Error(DeleteErr);
    end;
}

