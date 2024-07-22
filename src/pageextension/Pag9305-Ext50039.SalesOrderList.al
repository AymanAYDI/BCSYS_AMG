namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using BCSYS.AMGALLOIS.Basic;
pageextension 50039 SalesOrderList extends "Sales Order List" //9305
{
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Historique ventes";
            begin
                // ajout des lignes de vente … l'historique
                LRecHisto.DELAddCmdVente(Rec."No.", Rec."Document Date");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Historique ventes";
            begin
                // suppression des lignes de vente dans l'historique
                LRecHisto.DELDeleteCmdVente(Rec."No.");
            end;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.", "Document Type");
        Rec.Ascending(false);
    end;
}

