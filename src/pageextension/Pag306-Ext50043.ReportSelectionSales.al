namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.Reporting;
pageextension 50043 ReportSelectionSales extends "Report Selection - Sales" //306
{
    layout
    {
        addafter("Report Caption")
        {
            field("Custom Report Layout Code"; Rec."Custom Report Layout Code")
            {
                Editable = true;
                TableRelation = "Custom Report Layout".Code where(Code = field("Custom Report Layout Code"));
            }
        }
    }
}