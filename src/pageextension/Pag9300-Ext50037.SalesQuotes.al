namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.Document;
pageextension 50037 SalesQuotes extends "Sales Quotes" //9300
{
    //todo SourceTableView cannot be customized
    //todo check line 103
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record 50000;
            begin
                LRecHisto.DELAddDevis(Rec."No.", Rec."Document Date");
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                LRecHisto: Record 50000;
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

