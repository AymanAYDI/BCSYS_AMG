namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Reporting;

enumextension 50001 "ReportSelectionUsage" extends "Report Selection Usage" //77
{

    value(50000; "P.OrderVAT")
    {
        Caption = 'P.OrderVAT', Comment = 'FRA="P.Commande avec TVA"';
    }
    value(50001; "S.Proforma")
    {
        Caption = 'S.Proforma', Comment = 'FRA="S.Proforma"';
    }
}
