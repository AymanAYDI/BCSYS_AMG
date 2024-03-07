namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.History;
pageextension 50030 PostedPurchaseInvoices extends "Posted Purchase Invoices" //146
{
    layout
    {
        //todo DrillDown cannot be customized
        // modify(Amount)
        // {
        //     DrillDown = false;
        // }

        //todo DrillDown cannot be customized
        // modify("Amount Including VAT")
        // {
        //     DrillDown = false;
        // }
    }
    actions
    {
        modify("Update Document")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    var
        LRecParamAchat: Record 312;
        LTextDate: Text[30];
    begin
        Rec.FindFirst();
        // r‚cup‚ration de la date saisie dans les paramŠtres achats pour affichage des factures achat enregistr‚es
        // dont la date de comptabilisation est sup‚rieure ou ‚gale … la date dans les paramŠtres
        LRecParamAchat.FINDFIRST();
        if LRecParamAchat."Date début factures achats" <> 0D then begin
            LTextDate := FORMAT(LRecParamAchat."Date début factures achats", 0, '<Day,2><Month,2><Year4>');
            Rec.SETFILTER("Posting Date", '>' + LTextDate);
        end;
    end;
}

