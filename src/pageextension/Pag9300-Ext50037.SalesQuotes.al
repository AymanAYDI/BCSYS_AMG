namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using BCSYS.AMGALLOIS.Basic;
pageextension 50037 SalesQuotes extends "Sales Quotes" //9300
{
    //TODO SourceTableView cannot be customized
    //TODO check line 103
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Sales Archive";
            begin
                LRecHisto.DELAddDevis(Rec."No.", Rec."Document Date");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record "Sales Archive";
            begin
                LRecHisto.DELDeleteDevis(Rec."No.");
            end;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FindFirst();
    end;


}

