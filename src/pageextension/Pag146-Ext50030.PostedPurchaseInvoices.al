namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
pageextension 50030 PostedPurchaseInvoices extends "Posted Purchase Invoices" //146
{
    trigger OnOpenPage()
    var
        LRecParamAchat: Record "Purchases & Payables Setup";
        LTextDate: Text[30];
    begin
        Rec.FindFirst();
        // r‚cup‚ration de la date saisie dans les paramŠtres achats pour affichage des factures achat enregistr‚es
        // dont la date de comptabilisation est sup‚rieure ou ‚gale … la date dans les paramŠtres
        LRecParamAchat.FINDFIRST();
        if LRecParamAchat."Date debut factures achats" <> 0D then begin
            LTextDate := FORMAT(LRecParamAchat."Date debut factures achats", 0, '<Day,2><Month,2><Year4>');
            Rec.SETFILTER("Posting Date", '>' + LTextDate);
        end;
    end;
}

