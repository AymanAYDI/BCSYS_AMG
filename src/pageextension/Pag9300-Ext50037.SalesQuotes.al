namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
pageextension 50037 SalesQuotes extends "Sales Quotes" //9300
{
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Historique ventes";
            begin
                LRecHisto.DELAddDevis(Rec."No.", Rec."Document Date");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Historique ventes";
            begin
                LRecHisto.DELDeleteDevis(Rec."No.");
            end;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.", "Document Type");
        Rec.Ascending(false);
    end;
}

