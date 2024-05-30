namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.Reporting;
pageextension 50042 CustomerReportSelections extends "Customer Report Selections" //9657
{
    layout
    {
        addafter(ReportCaption)
        {
            field("Custom Report Layout Code"; Rec."Custom Report Layout Code")
            {
                TableRelation = "Custom Report Layout" where(Code = field("Custom Report Layout Code"));
                ApplicationArea = All;
            }
        }
    }
}

