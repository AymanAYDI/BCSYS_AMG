namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Archive;
report 50020 CopyLinesHisto
{
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = None;
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
        GRecHisto: Record "Historique ventes";

    local procedure DelphiCopySalesLinesHisto()
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
        LRecSalesHeader: Record "Sales Header";
    begin
        //DEV MLA
        // Insert Devis Histo
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETFILTER("Document Type", 'Quote');
        if LRecSalesLine.FINDSET() then
            repeat
                if LRecSalesHeader.GET(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE(Reference, LRecSalesLine."No.");
                LRecHisto.SETRANGE("No. client", LRecSalesLine."Sell-to Customer No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."No. client" := LRecSalesLine."Sell-to Customer No.";
                    LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                    LRecHisto."Date document vente" := LRecSalesHeader."Document Date";
                    LRecHisto."No. devis" := LRecSalesHeader."No.";
                    LRecHisto.Reference := LRecSalesLine."No.";
                    LRecHisto.Description := LRecSalesLine.Description;
                    LRecHisto."Reference externe" := LRecSalesLine."Item Reference No.";
                    LRecHisto.Quantite := LRecSalesLine.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLine."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLine."Line No.";
                    LRecHisto.INSERT(false);
                end
            until LRecSalesLine.NEXT() = 0;

        //Insert commande Histo
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETFILTER("Document Type", 'Order');
        if LRecSalesLine.FINDSET() then
            repeat
                if LRecSalesHeader.GET(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE(Reference, LRecSalesLine."No.");
                LRecHisto.SETRANGE("No. client", LRecSalesLine."Sell-to Customer No.");
                LRecHisto.SETRANGE("No. devis", LRecSalesHeader."Quote No.");
                if LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."No. commande vente" := LRecSalesLine."Document No.";
                    LRecHisto.MODIFY();
                end;
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."No. client" := LRecSalesLine."Sell-to Customer No.";
                    LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                    LRecHisto."Date document vente" := LRecSalesHeader."Document Date";
                    LRecHisto."No. commande vente" := LRecSalesLine."Document No.";
                    LRecHisto."No. devis" := LRecSalesHeader."Quote No.";
                    LRecHisto.Reference := LRecSalesLine."No.";
                    LRecHisto.Description := LRecSalesLine.Description;
                    LRecHisto."Reference externe" := LRecSalesLine."Item Reference No.";
                    LRecHisto.Quantite := LRecSalesLine.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLine."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLine."Line No.";
                    LRecHisto.INSERT(false);
                end;
            until LRecSalesLine.NEXT() = 0;
    end;

    local procedure DelphiCopySalesInvoiceLinesHisto()
    var
        LRecHisto: Record "Historique ventes";
        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
        LRecSalesInvoiceLine: Record "Sales Invoice Line";
    begin

        LRecSalesInvoiceLine.RESET();
        LRecSalesInvoiceLine.SETFILTER(Type, 'Item');
        LRecSalesInvoiceLine.SETFILTER(Quantity, '>0');
        if LRecSalesInvoiceLine.FINDSET() then
            repeat
                if LRecSalesInvoiceHeader.GET(LRecSalesInvoiceLine."Document No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE("No. commande vente", LRecSalesInvoiceLine."Document No.");
                LRecHisto.SETRANGE("No. client", LRecSalesInvoiceLine."Bill-to Customer No.");
                LRecHisto.SETRANGE(Reference, LRecSalesInvoiceLine."No.");
                if LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."No. facture vente" := LRecSalesInvoiceLine."Document No.";
                    LRecHisto.MODIFY()
                end;
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."No. client" := LRecSalesInvoiceLine."Sell-to Customer No.";
                    LRecHisto."Date document vente" := LRecSalesInvoiceLine."Posting Date";
                    LRecHisto."No. devis" := LRecSalesInvoiceHeader."Quote No.";
                    LRecHisto."No. commande vente" := LRecSalesInvoiceHeader."Order No.";
                    LRecHisto."No. facture vente" := LRecSalesInvoiceHeader."No.";
                    LRecHisto.Reference := LRecSalesInvoiceLine."No.";
                    LRecHisto.Description := LRecSalesInvoiceLine.Description;
                    LRecHisto."Reference externe" := LRecSalesInvoiceLine."Item Reference No.";
                    LRecHisto.Quantite := LRecSalesInvoiceLine.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesInvoiceLine."Unit Price";
                    LRecHisto."% de remise" := LRecSalesInvoiceLine."Line Discount %";
                    //LRecHisto."No. commande achat" :=
                    LRecHisto."No. ligne vente" := LRecSalesInvoiceLine."Line No.";
                    LRecHisto.INSERT(false);
                end;
            until LRecSalesInvoiceLine.NEXT() = 0;


        /*
        //DELPHI AUB 30.06.2020
        // Récupération des données existantes dans les lignes de vente pour construire les premières données d'historique
        LRecSalesLine.RESET;
        LRecSalesLine.SETFILTER(Type,'Item');
        LRecSalesLine.SETFILTER(Quantity,'>0');
        IF LRecSalesLine.FINDSET(FALSE,FALSE) THEN BEGIN
        REPEAT
          LRecHisto.RESET;
          IF LRecSalesInvoiceHeader.GET(LRecSalesLine."Document No.") THEN;
            //MODIF MLA
          LRecHisto.SETRANGE(Reference, LRecSalesLine."No.");
          LRecHisto.SETRANGE("No. client", LRecSalesLine."Sell-to Customer No.");
          IF NOT LRecHisto.FINDFIRST THEN BEGIN
            LRecHisto.RESET;
            CLEAR(LRecHisto);
            //END MODIF MLA
            LRecHisto."No. client" := LRecSalesLine."Sell-to Customer No.";
            LRecHisto."Date document vente" := LRecSalesLine."Posting Date";
            LRecHisto."No. devis" := LRecSalesInvoiceHeader."Quote No.";
            LRecHisto."No. commande vente" := LRecSalesInvoiceHeader."Order No.";
            LRecHisto."No. facture vente" := LRecSalesInvoiceHeader."No.";
            LRecHisto.Reference := LRecSalesLine."No.";
            LRecHisto.Description := LRecSalesLine.Description;
            LRecHisto."Reference externe" := LRecSalesLine."Item Reference No.";
            LRecHisto.Quantite := LRecSalesLine.Quantity;
            LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
            LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
            LRecHisto."No. ligne vente" := LRecSalesLine."Line No.";
        
            LRecHisto.INSERT(FALSE);
          END
        UNTIL LRecSalesLine.NEXT = 0;
        END;
        
        */

    end;

    local procedure DelphiDeleteLineArchive()
    var
        LRecHisto: Record "Historique ventes";
    begin


        LRecHisto.RESET();
        LRecHisto.SETFILTER(Archive, 'TRUE');
        if LRecHisto.FINDSET() then
            repeat
                if LRecHisto.FINDFIRST() then
                    LRecHisto.RESET();
                LRecHisto.SETFILTER(Archive, 'TRUE');

                LRecHisto.DELETEALL();
            until LRecHisto.NEXT() = 0;
    end;

    local procedure DelphiInsertArchiveLineHisto()
    var
        LRecHisto: Record "Historique ventes";
        LRecSalesLineArchive: Record "Sales Line Archive";
        LRecSalesHeaderArchive: Record "Sales Header Archive";
    begin
        //DEVIS VENTE ARCHVE
        LRecSalesLineArchive.RESET();
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.", false);
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');
        LRecSalesLineArchive.SETFILTER("Document Type", 'Quote');
        if LRecSalesLineArchive.FINDSET() then
            repeat
                if LRecSalesHeaderArchive.GET(LRecSalesLineArchive."Document Type", LRecSalesLineArchive."Document No.", LRecSalesLineArchive."Doc. No. Occurrence", LRecSalesLineArchive."Version No.") then;
                LRecHisto.RESET();
                LRecHisto.SETRANGE(Reference, LRecSalesLineArchive."No.");
                LRecHisto.SETRANGE("No. client", LRecSalesLineArchive."Sell-to Customer No.");
                LRecHisto.SETFILTER("No. devis", LRecSalesLineArchive."Document No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := LRecSalesHeaderArchive."Document Date";
                    LRecHisto."No. devis" := LRecSalesLineArchive."Document No.";
                    LRecHisto.Reference := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto.Quantite := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
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
        if LRecSalesLineArchive.FINDSET() then
            repeat
                if LRecSalesHeaderArchive.GET(LRecSalesLineArchive."Document Type", LRecSalesLineArchive."Document No.", LRecSalesLineArchive."Doc. No. Occurrence", LRecSalesLineArchive."Version No.") then;
                CLEAR(LRecHisto);
                LRecHisto.RESET();
                LRecHisto.SETRANGE(Reference, LRecSalesLineArchive."No.");
                LRecHisto.SETRANGE("No. client", LRecSalesLineArchive."Sell-to Customer No.");
                //LRecHisto.SETRANGE("No. devis", LRecSalesHeaderArchive."Sales Quote No.");
                //LRecHisto.SETRANGE("No. ligne vente", LRecSalesLineArchive."Line No.");
                LRecHisto.SETRANGE(Quantite, LRecSalesLineArchive.Quantity);
                //LRecHisto.SETFILTER(Archive, 'True');
                if LRecHisto.FINDFIRST() then
                    if LRecHisto."No. devis" = LRecSalesHeaderArchive."Sales Quote No." then
                        if LRecHisto.Archive = true then begin
                            LRecHisto.RESET();
                            LRecHisto."No. commande vente" := LRecSalesLineArchive."Document No.";
                            if LRecHisto.MODIFY() then;
                        end;
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    CLEAR(LRecHisto);
                    LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := LRecSalesHeaderArchive."Document Date";
                    LRecHisto."No. devis" := LRecSalesHeaderArchive."Sales Quote No.";
                    LRecHisto."No. commande vente" := LRecSalesLineArchive."Document No.";
                    LRecHisto.Reference := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto.Quantite := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
                    LRecHisto.Archive := true;
                    if LRecHisto.INSERT(false) then;
                end;
            until LRecSalesLineArchive.NEXT() = 0;
















        /*
            LRecHisto.RESET;
            LRecHisto.SETRANGE(Reference, LRecSalesLineArchive."No.");
            LRecHisto.SETRANGE("No. client", LRecSalesLineArchive."Sell-to Customer No.");
            IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Quote THEN
              LRecHisto.SETFILTER("No. devis", LRecSalesLineArchive."Document No.");
            IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Order THEN
              LRecHisto.SETFILTER("No. commande vente", LRecSalesLineArchive."Document No.");
            IF NOT LRecHisto.FINDSET(TRUE,TRUE) THEN
            BEGIN
              LRecHisto.RESET;
              CLEAR(LRecHisto);
              LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
              LRecHisto."Date document vente" := LRecSalesHeaderArchive."Document Date";
              IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Quote THEN
                LRecHisto."No. devis" := LRecSalesLineArchive."Document No."
              ELSE IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Order THEN
                LRecHisto."No. commande vente" := LRecSalesLineArchive."Document No."
              ELSE IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Invoice THEN
                LRecHisto."No. facture vente" := LRecSalesLineArchive."Document No.";
              LRecHisto.Reference := LRecSalesLineArchive."No.";
              LRecHisto.Description := LRecSalesLineArchive.Description;
              LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
              LRecHisto.Quantite := LRecSalesLineArchive.Quantity;
              LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
              LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
              LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
              LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
              LRecHisto.Archive := TRUE;
              LRecHisto.INSERT(FALSE);
            END;
          UNTIL LRecSalesLineArchive.NEXT = 0;
        END;
        */
        /*
        // Delphisoft MLA 20/06/2022
        // Récupération des lignes du devis archivé pour ajout dans l'historique
        LRecSalesLineArchive.RESET;
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.",FALSE);
        LRecSalesLineArchive.SETFILTER(Type,'Item');
        //LRecSalesLineArchive.SETRANGE("Document Type", LRecSalesLineArchive."Document Type"::Quote);
        LRecSalesLineArchive.SETFILTER(Quantity,'>0');
        
        IF LRecSalesLineArchive.FINDSET(FALSE,FALSE) THEN BEGIN
        REPEAT
          LRecHisto.RESET;
        //  IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Quote THEN
        //    LRecHisto.SETRANGE("No. devis", LRecSalesLineArchive."Document No.")
        //  ELSE
        //    LRecHisto.SETRANGE("No. commande vente", LRecSalesLineArchive."Document No.");
          LRecHisto.SETRANGE(Reference, LRecSalesLineArchive."No.");
          IF NOT LRecHisto.FINDFIRST THEN
          BEGIN
            IF LRecSalesHeaderArchive.GET(LRecSalesLineArchive."Document Type",LRecSalesLineArchive."Document No.",LRecSalesLineArchive."Doc. No. Occurrence",LRecSalesLineArchive."Version No.") THEN;
            LRecHisto.RESET;
            LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
            LRecHisto."Date document vente" := LRecSalesHeaderArchive."Document Date";
            //DEB MODIF MLA 04052023
            LRecHisto."No. devis" := LRecSalesLineArchive."Document No.";
            {
            IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Quote THEN
              LRecHisto."No. devis" := LRecSalesLineArchive."Document No."
            ELSE IF LRecSalesLineArchive."Document Type" = LRecSalesLineArchive."Document Type"::Order THEN
              LRecHisto."No. commande vente" := LRecSalesLineArchive."Document No.";
            }
            //FIN MODIF MLA 04052023
            LRecHisto.Reference := LRecSalesLineArchive."No.";
            LRecHisto.Description := LRecSalesLineArchive.Description;
            LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
            LRecHisto.Quantite := LRecSalesLineArchive.Quantity;
            LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
            LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
            LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
            LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
            LRecHisto.Archive := TRUE;
            IF LRecHisto.INSERT(FALSE) THEN;
          END;
        UNTIL LRecSalesLineArchive.NEXT = 0;
        END;
        */

    end;
}

