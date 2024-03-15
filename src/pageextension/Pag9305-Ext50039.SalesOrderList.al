namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
using BCSYS.AMGALLOIS.Basic;
pageextension 50039 SalesOrderList extends "Sales Order List" //9305
{
    //TODO SourceTableView cannot be customized
    layout
    {
        modify("Quote No.")
        {
            Visible = false;
        }
        moveafter("No."; "Your Reference")
    }
    actions
    {
        modify("Delete Invoiced")
        {
            ApplicationArea = All;
        }
        modify(Release)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Sales Archive";
            begin
                // ajout des lignes de vente … l'historique
                LRecHisto.DELAddCmdVente(Rec."No.", Rec."Document Date");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Sales Archive";
            begin
                // suppression des lignes de vente dans l'historique
                LRecHisto.DELDeleteCmdVente(Rec."No.");
            end;
        }
    }
    //TODO i can't find solution for Onopenpage 
}

