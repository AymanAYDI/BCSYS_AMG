namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;

pageextension 50017 "SalesInvoiceSubform" extends "Sales Invoice Subform" //47
{
    layout
    {
        addafter(LineDiscExists)
        {
            field(Marge; Rec.Marge)
            {
                Importance = Standard;
                Style = Strong;
                StyleExpr = true;
                ApplicationArea = All;
            }
            field(Marque; Rec.Marque)
            {
                Style = StrongAccent;
                StyleExpr = true;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
    }
}
