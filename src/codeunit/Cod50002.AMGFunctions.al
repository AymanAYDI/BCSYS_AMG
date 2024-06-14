namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.ExtendedText;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Foundation.Period;
using System.Utilities;

codeunit 50002 "AMG_Functions"
{
    SingleInstance = true;

    //Codeunit 5702
    procedure GetNewSpecialOrders(var PurchHeader: Record "Purchase Header");
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        LRecSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        Vendor: Record Vendor;
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        LPageSalesLine: Page "Lignes Commandes Vte Speciales";
        NextLineNo: Integer;
        Text000: Label 'Il n"existe aucun article avec la référence externe %1.';
        Text001: Label 'The Quantity per Unit of Measure %1 has changed from %2 to %3 since the sales order was created. Adjust the quantity on the sales order or the unit of measure.', Comment = '%1=Unit of Measure Code,%2=Qty. per Unit of Measure in Sales Line,%3=Qty. per Unit of Measure in Item Unit of Measure';
    begin
        PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::Order);

        LRecSalesLine.SETRANGE("Document Type", LRecSalesLine."Document Type"::Order);
        LRecSalesLine.SETRANGE(Type, LRecSalesLine.Type::Item);
        LRecSalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
        LRecSalesLine.SETRANGE("Fournisseur article", PurchHeader."Buy-from Vendor No.");
        LRecSalesLine.SETFILTER("Special Order Purchase No.", '=%1', '');
        LRecSalesLine.SETRANGE("Special Order", true);
        LPageSalesLine.SETTABLEVIEW(LRecSalesLine);
        if (LPageSalesLine.RUNMODAL() <> ACTION::OK) then
            exit;

        PurchHeader.LOCKTABLE();
        if Vendor.GET(PurchHeader."Buy-from Vendor No.") then
            PurchHeader.VALIDATE("Shipment Method Code", Vendor."Shipment Method Code");

        PurchLine.LOCKTABLE();
        SalesLine.LOCKTABLE();

        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if PurchLine.FINDLAST() then
            NextLineNo := PurchLine."Line No." + 10000
        else
            NextLineNo := 10000;

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Special Order", true);
        SalesLine.SETFILTER("Outstanding Quantity", '<>0');
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETRANGE("Special Order Purch. Line No.", 0);
        SalesLine.SETRANGE(Sel, true);

        if SalesLine.FINDSET() then
            repeat
                if (SalesLine.Type = SalesLine.Type::Item) and ItemUnitOfMeasure.GET(SalesLine."No.", SalesLine."Unit of Measure Code") then
                    if SalesLine."Qty. per Unit of Measure" <> ItemUnitOfMeasure."Qty. per Unit of Measure" then
                        ERROR(Text001,
                          SalesLine."Unit of Measure Code",
                          SalesLine."Qty. per Unit of Measure",
                          ItemUnitOfMeasure."Qty. per Unit of Measure");
                PurchLine.INIT();
                PurchLine."Document Type" := PurchLine."Document Type"::Order;
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := NextLineNo;
                CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, PurchLine);
                PurchLine.GetItemTranslation();
                PurchLine."Special Order" := true;
                PurchLine."Purchasing Code" := SalesLine."Purchasing Code";
                PurchLine."Special Order Sales No." := SalesLine."Document No.";
                PurchLine."Special Order Sales Line No." := SalesLine."Line No.";
                PurchLine.INSERT();
                NextLineNo := NextLineNo + 10000;

                SalesLine."Unit Cost (LCY)" := PurchLine."Unit Cost (LCY)";
                SalesLine.VALIDATE("Unit Cost (LCY)");
                SalesLine."Special Order Purchase No." := PurchLine."Document No.";
                SalesLine."Special Order Purch. Line No." := PurchLine."Line No.";
                SalesLine.Sel := false;
                // DELPHI DEB 26/10/2018 MultiSelection.
                SalesLine.MODIFY();
                if TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, true) then begin
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
                    if PurchLine2.FINDLAST() then
                        NextLineNo := PurchLine2."Line No.";
                    NextLineNo := NextLineNo + 10000;
                end;
            until SalesLine.NEXT() = 0
        else
            if SalesHeader."No." <> '' then
                ERROR(
                  Text000,
                  SalesHeader."No.")
            else
                MESSAGE('Aucune ligne sélectionnée');
        PurchHeader.MODIFY();
    end;

    procedure VerifiyDateFilter("Filter": Text[30])
    var
        Text10800: Label 'The selected date is not a starting period.', Comment = 'FRA="La date choisie n''est pas un début de période."';
    begin
        if Filter = ',,,' then
            Error(Text10800);
    end;

    procedure CheckFiscalYearStatus(PeriodRange: Text[30]): Text[30]
    var
        AccountingPeriod: Record "Accounting Period";
        Date: Record Date;
        Text009: Label 'Fiscally Closed', Comment = 'FRA="Clôturé fiscalement"';
        Text010: Label 'Fiscally Open', Comment = 'FRA="Ouvert fiscalement"';
    begin
        Date.SetRange("Period Type", Date."Period Type"::Date);
        Date.SetFilter("Period Start", PeriodRange);
        Date.FindLast();
        AccountingPeriod.SetFilter("Starting Date", '<=%1', Date."Period Start");
        AccountingPeriod.SetRange("New Fiscal Year", true);
        AccountingPeriod.FindLast();
        if AccountingPeriod."Fiscally Closed" then
            exit(Text009);

        exit(Text010);
    end;
}
