namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Archive;
table 50000 "Historique ventes"
{
    DrillDownPageID = "Historique ventes article";
    LinkedObject = false;
    LookupPageID = "Historique ventes article";

    fields
    {
        field(1; "No. client"; Code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'N° client';
        }
        field(2; "Nom client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("No. client")));
            FieldClass = FlowField;
            Caption = 'Nom client';
        }
        field(10; "Date document vente"; Date)
        {
            Caption = 'Date document vente';
        }
        field(11; "No. devis"; Code[20])
        {
            TableRelation = "Sales Header"."No.";
            Caption = 'N° devis';
        }
        field(12; "No. commande vente"; Code[20])
        {
            TableRelation = "Sales Header"."No.";
            Caption = 'N° commande vente';
        }
        field(13; "No. facture vente"; Code[20])
        {
            Editable = false;
            TableRelation = "Sales Invoice Header"."No.";
            Caption = 'N° facture vente';
        }
        field(20; "Reference"; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'Référence';
        }
        field(21; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(22; "Reference externe"; Code[50])
        {
            Caption = 'Référence externe';
        }
        field(30; "Quantite"; Decimal)
        {
            Caption = 'Quantité';
        }
        field(31; "Prix de vente"; Decimal)
        {
            Caption = 'Prix de vente';
        }
        field(32; "% de remise"; Decimal)
        {
            Caption = '% de remise';
        }
        field(40; "No. commande achat"; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            Caption = 'N° commande achat';
        }
        field(50; "No. ligne vente"; Integer)
        {
            Caption = 'N° ligne vente';
        }
        field(68; Inventory; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Reference")));
            Caption = 'Inventory', Comment = 'FRA="Stock actuel"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Archive; Boolean)
        {
            InitValue = false;
            Caption = 'Archive';
        }
    }

    keys
    {
        key(Key1; "Reference", "No. client", "No. devis", "No. ligne vente", "No. commande vente", "No. facture vente")
        {
            Clustered = true;
        }
        key(Key2; "Date document vente", "Reference", "No. client")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No. client", "Reference", "Prix de vente")
        {
        }
        fieldgroup(Brick; "No. client", "Reference", "Prix de vente")
        {
        }
    }

    procedure DELDeleteCmdVente(DocumentNo: Code[20])
    var
        LRecHisto: Record "Historique ventes";
    begin
        //DELPHI AUB 25.06.2020
        //Suppression des lignes de la commande vente dans l'historique
        LRecHisto.SETRANGE("No. commande vente", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddCmdVente(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
        LRecSalesHeader: Record "Sales Header";
    begin
        //DELPHI AUB 25.06.2020
        // -> suppression des lignes de la commande vente dans l'historique
        DELDeleteCmdVente(DocumentNo);
        // Récupération des lignes de la commande pour ajout dans l'historique
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETRANGE("Document Type", LRecSalesLine."Document Type"::Order);

        if LRecSalesLine.FINDSET() then
            repeat
                LRecHisto.RESET();
                if LRecSalesHeader.GET(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                LRecHisto."No. devis" := LRecSalesHeader."Quote No.";
                LRecHisto."No. client" := LRecSalesLine."Sell-to Customer No.";
                LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                LRecHisto."Date document vente" := DocumentDate;
                LRecHisto."No. commande vente" := LRecSalesLine."Document No.";
                LRecHisto."Reference" := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                LRecHisto."Reference externe" := LRecSalesLine."Item Reference No.";
                LRecHisto."Quantite" := LRecSalesLine.Quantity;
                LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                LRecHisto."No. commande achat" := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."No. ligne vente" := LRecSalesLine."Line No.";

                LRecHisto.INSERT(false);
            until LRecSalesLine.NEXT() <= 0;
    end;

    procedure DELTransfCmdFactV(DELCodCmdeVente: Code[20]; DELCodFactVente: Code[20])
    var
        LRecLignesFV: Record "Sales Invoice Line";
        LRecHisto: Record "Historique ventes";
        LRecFactVenteHeader: Record "Sales Invoice Header";
    begin
        //DELPHI AUB 01.07.2020
        // Lors de la validation d'une commande vente
        // -> suppression des lignes de la commande vente dans l'historique
        DELDeleteCmdVente(DELCodCmdeVente);
        // -> ajout des lignes de la facture vente dans l'historique
        LRecLignesFV.RESET();
        //DELPHI AUB 29.01.2021
        LRecLignesFV.SETFILTER("Document No.", DELCodFactVente);
        LRecLignesFV.SETFILTER(Type, 'Item');
        LRecLignesFV.SETFILTER(Quantity, '>0');
        //DELPHI AUB 29.01.2021 END
        if LRecLignesFV.FINDSET() then
            repeat
                if LRecFactVenteHeader.GET(LRecLignesFV."Document No.") then;
                LRecHisto.RESET();
                LRecHisto."No. devis" := LRecFactVenteHeader."Quote No.";
                LRecHisto."No. client" := LRecLignesFV."Sell-to Customer No.";
                LRecHisto."Date document vente" := LRecLignesFV."Posting Date";
                // LRecHisto."N° commande vente" := DELCodCmdeVente;
                LRecHisto."No. commande vente" := LRecFactVenteHeader."Order No.";
                LRecHisto."No. facture vente" := LRecLignesFV."Document No.";
                LRecHisto."Reference" := LRecLignesFV."No.";
                LRecHisto.Description := LRecLignesFV.Description;
                LRecHisto."Reference externe" := LRecLignesFV."Item Reference No.";
                LRecHisto."Quantite" := LRecLignesFV.Quantity;
                LRecHisto."Prix de vente" := LRecLignesFV."Unit Price";
                LRecHisto."% de remise" := LRecLignesFV."Line Discount %";
                LRecHisto."No. ligne vente" := LRecLignesFV."Line No.";

                LRecHisto.INSERT(false);

            until LRecLignesFV.NEXT() <= 0;
        //END DELPHI AUB
    end;

    procedure DELAddDevis(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
    begin
        //DELPHI AUB 25.06.2020
        // Récupération des lignes du devis pour ajout dans l'historique
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SETRANGE("Document Type", LRecSalesLine."Document Type"::Quote);

        if LRecSalesLine.FINDSET() then
            repeat
                // Suppression d'une version archivée de ce devis pour cet article et cette ligne de vente
                LRecHisto.RESET();
                LRecHisto.SETFILTER("No. devis", LRecSalesLine."Document No.");
                LRecHisto.SETRANGE("Reference", LRecSalesLine."No.");
                LRecHisto.SETRANGE("No. ligne vente", LRecSalesLine."Line No.");
                LRecHisto.SETRANGE(Archive, true);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.RESET();
                LRecHisto.SETFILTER("No. devis", LRecSalesLine."Document No.");
                LRecHisto.SETRANGE("Reference", LRecSalesLine."No.");
                LRecHisto.SETRANGE("No. ligne vente", LRecSalesLine."Line No.");
                LRecHisto.SETRANGE(Archive, false);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.RESET();
                LRecHisto."No. client" := LRecSalesLine."Sell-to Customer No.";
                LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                LRecHisto."Date document vente" := DocumentDate;
                LRecHisto."No. devis" := LRecSalesLine."Document No.";
                LRecHisto."Reference" := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                LRecHisto."Reference externe" := LRecSalesLine."Item Reference No.";
                LRecHisto."Quantite" := LRecSalesLine.Quantity;
                LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                LRecHisto."No. commande achat" := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."No. ligne vente" := LRecSalesLine."Line No.";

                if LRecHisto.INSERT(false) then;
            until LRecSalesLine.NEXT() <= 0;
    end;

    procedure DELDeleteDevis(DocumentNo: Code[20])
    var
        LRecHisto: Record "Historique ventes";
    begin
        //DELPHI AUB 95.06.2020
        //Suppression des lignes du devis dans l'historique
        LRecHisto.SETRANGE("No. devis", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddDevisArchive(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLineArchive: Record "Sales Line Archive";
        LRecHisto: Record "Historique ventes";
    begin
        // Delphisoft MLA 20/06/2022
        // Récupération des lignes du devis archivé pour ajout dans l'historique
        LRecSalesLineArchive.RESET();
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.", false);
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SETRANGE("Document Type", LRecSalesLineArchive."Document Type"::Quote);
        LRecSalesLineArchive.SETRANGE("Document No.", DocumentNo);
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');

        if LRecSalesLineArchive.FINDSET() then
            repeat
                LRecHisto.RESET();
                LRecHisto.SETRANGE("No. devis", LRecSalesLineArchive."Document No.");
                LRecHisto.SETRANGE("Reference", LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := DocumentDate;
                    LRecHisto."No. devis" := LRecSalesLineArchive."Document No.";
                    LRecHisto."Reference" := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto."Quantite" := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
                    LRecHisto.Archive := true;
                    if LRecHisto.INSERT(false) then;
                end;
            until LRecSalesLineArchive.NEXT() = 0;
    end;

    procedure DELAddCmdVenteArchive(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLineArchive: Record "Sales Line Archive";
        LRecHisto: Record "Historique ventes";
    begin
        // Delphisoft MLA 20/06/2022
        // Récupération des lignes du devis archivé pour ajout dans l'historique

        LRecSalesLineArchive.RESET();
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SETRANGE("Document Type", LRecSalesLineArchive."Document Type"::Order);
        LRecSalesLineArchive.SETFILTER("Document No.", DocumentNo);
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');


        if LRecSalesLineArchive.FINDSET() then
            repeat
                LRecHisto.RESET();
                LRecHisto.SETFILTER("No. devis", LRecSalesLineArchive."Document No.");
                LRecHisto.SETRANGE("Reference", LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.RESET();
                    LRecHisto."No. client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := DocumentDate;
                    LRecHisto."No. devis" := LRecSalesLineArchive."Document No.";
                    LRecHisto."Reference" := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    LRecHisto."Reference externe" := LRecSalesLineArchive."Item Reference No.";
                    LRecHisto."Quantite" := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."No. commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."No. ligne vente" := LRecSalesLineArchive."Line No.";
                    LRecHisto.Archive := true;
                    if LRecHisto.INSERT(false) then;
                end;
            until LRecSalesLineArchive.NEXT() = 0;
    end;

    procedure DELSupprDevisHisto(DocumentNo: Code[20])
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
        LRecSalesLineHeader: Record "Sales Header";
    begin
        // Delphisoft MLA 20/06/2022
        // Suppression des lignes du devis archivé dans l'historique
        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER(Type, 'Item');
        //LRecSalesLineArchive.SETRANGE("Document Type", LRecSalesLineArchive."Document Type"::Order);
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        //LRecSalesLineArchive.SETFILTER(Quantity,'>0');


        if LRecSalesLine.FINDSET() then
            repeat
                if LRecSalesLineHeader.GET(LRecSalesLineHeader."Document Type", LRecSalesLineHeader."No.") then;
                LRecHisto.RESET();
                LRecHisto.SETFILTER("No. devis", LRecSalesLineHeader."Quote No.");
                LRecHisto.SETRANGE("Reference", LRecSalesLine."No.");
                LRecHisto.SETRANGE("No. client", LRecSalesLine."Sell-to Customer No.");
                LRecHisto.SETFILTER(Archive, 'TRUE');
                if LRecHisto.FINDSET() then
                    LRecHisto.DELETEALL();
            until LRecSalesLine.NEXT() = 0;
    end;
}

