namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
codeunit 50003 "AMG Shipment Line - Edit"
{
    Permissions = TableData "Sales Shipment Line" = m,
                  TableData "Sales Cr.Memo Line" = m;
    TableNo = "Sales Shipment Line";

    trigger OnRun()
    begin
        SalesShptLine := Rec;
        SalesShptLine.LOCKTABLE();
        SalesShptLine.FIND();
        SalesShptLine."No. Colis" := Rec."No. Colis";
        SalesShptLine.MODIFY();
        Rec := SalesShptLine;
    end;

    var
        SalesShptLine: Record "Sales Shipment Line";
}
