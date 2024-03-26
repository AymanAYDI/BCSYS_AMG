namespace BCSYS.AMGALLOIS.Basic;

using BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Archive;
report 50020 CopyLinesHisto
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GRecHisto.DELETEALL();
        //DelphiDeleteLineArchive;
        DelphiCopySalesLinesHisto();
        //DelphiCopySalesLinesHistoQuote;
        DelphiCopySalesInvoiceLinesHisto();
        DelphiInsertArchiveLineHisto();
        //GRecHisto.DELETEALL;
    end;

    var
        GRecHisto: Record "Sales Archive";

    local procedure DelphiCopySalesLinesHisto()
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesHeader: Record "Sales Header";
        LRecSalesLine: Record "Sales Line";
    begin
        //DEV MLA
        // Insert Devis Histo
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETFILTER("Document Type", 'Quote');
        if LRecSalesLine.FindSet() then
            repeat
                if LRecSalesHeader.GET(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE("Reference", LRecSalesLine."No.");
                LRecHisto.SETRANGE("Customer No.", LRecSalesLine."Sell-to Customer No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."Customer No." := LRecSalesLine."Sell-to Customer No.";
                    LRecHisto."Customer Name" := LRecSalesLine."Customer Name";
                    LRecHisto."Sales Document Date" := LRecSalesHeader."Document Date";
                    LRecHisto."Quote No." := LRecSalesHeader."No.";
                    LRecHisto."Reference" := LRecSalesLine."No.";
                    LRecHisto.Description := LRecSalesLine.Description;
                    LRecHisto."External Reference" := LRecSalesLine."Item Reference No.";
                    LRecHisto.Quantity := LRecSalesLine.Quantity;
                    LRecHisto."Sales Amount" := LRecSalesLine."Unit Price";
                    LRecHisto."% Discount" := LRecSalesLine."Line Discount %";
                    LRecHisto."Purchase Order No." := LRecSalesLine."Special Order Purchase No.";
                    LRecHisto."Sales Line No." := LRecSalesLine."Line No.";
                    LRecHisto.INSERT(false);
                end
            until LRecSalesLine.NEXT() = 0;


        //Insert commande Histo
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETFILTER("Document Type", 'Order');
        if LRecSalesLine.FindSet() then
            repeat
                if LRecSalesHeader.GET(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE("Reference", LRecSalesLine."No.");
                LRecHisto.SETRANGE("Customer No.", LRecSalesLine."Sell-to Customer No.");
                LRecHisto.SETRANGE("Quote No.", LRecSalesHeader."Quote No.");
                if LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."Sales Order No." := LRecSalesLine."Document No.";
                    LRecHisto.MODIFY();
                end;
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."Customer No." := LRecSalesLine."Sell-to Customer No.";
                    LRecHisto."Customer Name" := LRecSalesLine."Customer Name";
                    LRecHisto."Sales Document Date" := LRecSalesHeader."Document Date";
                    LRecHisto."Sales Order No." := LRecSalesLine."Document No.";
                    LRecHisto."Quote No." := LRecSalesHeader."Quote No.";
                    LRecHisto."Reference" := LRecSalesLine."No.";
                    LRecHisto.Description := LRecSalesLine.Description;
                    LRecHisto."External Reference" := LRecSalesLine."Item Reference No.";
                    LRecHisto.Quantity := LRecSalesLine.Quantity;
                    LRecHisto."Sales Amount" := LRecSalesLine."Unit Price";
                    LRecHisto."% Discount" := LRecSalesLine."Line Discount %";
                    LRecHisto."Purchase Order No." := LRecSalesLine."Special Order Purchase No.";
                    LRecHisto."Sales Line No." := LRecSalesLine."Line No.";
                    LRecHisto.INSERT(false);
                end;
            until LRecSalesLine.NEXT() = 0;
    end;

    local procedure DelphiCopySalesInvoiceLinesHisto()
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
        LRecSalesInvoiceLine: Record "Sales Invoice Line";
    begin

        LRecSalesInvoiceLine.RESET();
        LRecSalesInvoiceLine.SETFILTER(Type, 'Item');
        LRecSalesInvoiceLine.SETFILTER(Quantity, '>0');
        if LRecSalesInvoiceLine.FindSet() then
            repeat
                if LRecSalesInvoiceHeader.GET(LRecSalesInvoiceLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE("Sales Order No.", LRecSalesInvoiceLine."Document No.");
                LRecHisto.SETRANGE("Customer No.", LRecSalesInvoiceLine."Bill-to Customer No.");
                LRecHisto.SETRANGE("Reference", LRecSalesInvoiceLine."No.");
                if LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."Sales Invoice No." := LRecSalesInvoiceLine."Document No.";
                    LRecHisto.MODIFY()
                end;
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."Customer No." := LRecSalesInvoiceLine."Sell-to Customer No.";
                    LRecHisto."Sales Document Date" := LRecSalesInvoiceLine."Posting Date";
                    LRecHisto."Quote No." := LRecSalesInvoiceHeader."Quote No.";
                    LRecHisto."Sales Order No." := LRecSalesInvoiceHeader."Order No.";
                    LRecHisto."Sales Invoice No." := LRecSalesInvoiceHeader."No.";
                    LRecHisto."Reference" := LRecSalesInvoiceLine."No.";
                    LRecHisto.Description := LRecSalesInvoiceLine.Description;
                    LRecHisto."External Reference" := LRecSalesInvoiceLine."Item Reference No.";
                    LRecHisto.Quantity := LRecSalesInvoiceLine.Quantity;
                    LRecHisto."Sales Amount" := LRecSalesInvoiceLine."Unit Price";
                    LRecHisto."% Discount" := LRecSalesInvoiceLine."Line Discount %";
                    //LRecHisto."Purchase Order No." :=
                    LRecHisto."Sales Line No." := LRecSalesInvoiceLine."Line No.";
                    LRecHisto.INSERT(false);
                end;
            until LRecSalesInvoiceLine.NEXT() = 0;
    end;

    local procedure DelphiDeleteLineArchive()
    var
        LRecHisto: Record "Sales Archive";
    begin
        LRecHisto.RESET();
        LRecHisto.SETFILTER(Archive, 'TRUE');
        if LRecHisto.FindSet() then
            repeat
                if LRecHisto.FINDFIRST() then
                    LRecHisto.RESET();
                LRecHisto.SETFILTER(Archive, 'TRUE');

                LRecHisto.DELETEALL();
            until LRecHisto.Next() = 0;
    end;

    local procedure DelphiInsertArchiveLineHisto()
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesHeaderArchive: Record "Sales Header Archive";
        LRecSalesLineArchive: Record "Sales Line Archive";
    begin
        //DEVIS VENTE ARCHVE
        LRecSalesLineArchive.RESET();
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.", false);
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');
        LRecSalesLineArchive.SETFILTER("Document Type", 'Quote');
        if LRecSalesLineArchive.FindSet() then
            repeat
                if LRecSalesHeaderArchive.GET(LRecSalesLineArchive."Document Type", LRecSalesLineArchive."Document No.", LRecSalesLineArchive."Doc. No. Occurrence", LRecSalesLineArchive."Version No.") then;
                LRecHisto.RESET();
                LRecHisto.SETRANGE("Reference", LRecSalesLineArchive."No.");
                LRecHisto.SETRANGE("Customer No.", LRecSalesLineArchive."Sell-to Customer No.");
                LRecHisto.SETFILTER("Quote No.", LRecSalesLineArchive."Document No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."Customer No." := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Sales Document Date" := LRecSalesHeaderArchive."Document Date";
                    LRecHisto."Quote No." := LRecSalesLineArchive."Document No.";
                    LRecHisto."Reference" := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."External Reference" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto.Quantity := LRecSalesLineArchive.Quantity;
                    LRecHisto."Sales Amount" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% Discount" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."Purchase Order No." := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."Sales Line No." := LRecSalesLineArchive."Line No.";
                    LRecHisto.Archive := true;
                    LRecHisto.INSERT(false);
                end;
            until LRecSalesLineArchive.NEXT() = 0;
        //COMMANDE VENTE ARCHVE
        LRecSalesLineArchive.RESET();
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.", false);
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');
        LRecSalesLineArchive.SETFILTER("Document Type", 'Order');
        if LRecSalesLineArchive.FindSet() then
            repeat
                if LRecSalesHeaderArchive.GET(LRecSalesLineArchive."Document Type", LRecSalesLineArchive."Document No.", LRecSalesLineArchive."Doc. No. Occurrence", LRecSalesLineArchive."Version No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE("Reference", LRecSalesLineArchive."No.");
                LRecHisto.SETRANGE("Customer No.", LRecSalesLineArchive."Sell-to Customer No.");
                //LRecHisto.SETRANGE("Quote No.", LRecSalesHeaderArchive."Sales Quote No.");
                //LRecHisto.SETRANGE("Sales Line No.", LRecSalesLineArchive."Line No.");
                LRecHisto.SETRANGE(Quantity, LRecSalesLineArchive.Quantity);
                //LRecHisto.SETFILTER(Archive, 'True');
                if LRecHisto.FINDFIRST() then
                    if LRecHisto."Quote No." = LRecSalesHeaderArchive."Sales Quote No." then
                        if LRecHisto.Archive = true then begin
                            LRecHisto.RESET();
                            LRecHisto."Sales Order No." := LRecSalesLineArchive."Document No.";
                            if LRecHisto.MODIFY() then;
                        end;

                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."Customer No." := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Sales Document Date" := LRecSalesHeaderArchive."Document Date";
                    LRecHisto."Quote No." := LRecSalesHeaderArchive."Sales Quote No.";
                    LRecHisto."Sales Order No." := LRecSalesLineArchive."Document No.";
                    LRecHisto."Reference" := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."External Reference" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto.Quantity := LRecSalesLineArchive.Quantity;
                    LRecHisto."Sales Amount" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% Discount" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."Purchase Order No." := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."Sales Line No." := LRecSalesLineArchive."Line No.";
                    LRecHisto.Archive := true;
                    if LRecHisto.INSERT(false) then;
                end;
            until LRecSalesLineArchive.NEXT() = 0;
    end;
}

