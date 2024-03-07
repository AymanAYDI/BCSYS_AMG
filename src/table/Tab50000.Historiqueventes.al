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
    DrillDownPageID = 50010;
    LinkedObject = false;
    LookupPageID = 50010;

    fields
    {
        field(1; "N° client"; Code[20])
        {
            Caption = 'N° client';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; "Nom client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("N° client")));
            FieldClass = FlowField;
        }
        field(10; "Date document vente"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "N° devis"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(12; "N° commande vente"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(13; "N° facture vente"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(20; "Référence"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(21; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Référence externe"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Quantité"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Prix de vente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "% de remise"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "N° commande achat"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No.";
        }
        field(50; "N° ligne vente"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(68; Inventory; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field(Référence)));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }
    }

    keys
    {
        key(Key1; "Référence", "N° client", "N° devis", "N° ligne vente", "N° commande vente", "N° facture vente")
        {
            Clustered = true;
        }
        key(Key2; "Date document vente", "Référence", "N° client")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "N° client", "Référence", "Prix de vente")
        {
        }
        fieldgroup(Brick; "N° client", "Référence", "Prix de vente")
        {
        }
    }

    procedure DELDeleteCmdVente(DocumentNo: Code[20])
    var
        LRecHisto: Record "Historique ventes";
    begin
        //Suppression des lignes de la commande vente dans l'historique
        LRecHisto.SetRange("N° commande vente", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddCmdVente(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
        LRecSalesHeader: Record "Sales Header";
    begin
        // -> suppression des lignes de la commande vente dans l'historique
        DELDeleteCmdVente(DocumentNo);
        // Récupération des lignes de la commande pour ajout dans l'historique
        LRecSalesLine.Reset();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SetRange("Document Type", LRecSalesLine."Document Type"::Order);

        if LRecSalesLine.FINDSET(false) then
            repeat
                //todo field spe ,field removed
                LRecHisto.Reset();
                if LRecSalesHeader.Get(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                LRecHisto."N° devis" := LRecSalesHeader."Quote No.";
                LRecHisto."N° client" := LRecSalesLine."Sell-to Customer No.";
                //    LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                LRecHisto."Date document vente" := DocumentDate;
                LRecHisto."N° commande vente" := LRecSalesLine."Document No.";
                LRecHisto.Référence := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                // LRecHisto."Référence externe" := LRecSalesLine."Cross-Reference No.";
                LRecHisto.Quantité := LRecSalesLine.Quantity;
                LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                LRecHisto."N° commande achat" := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."N° ligne vente" := LRecSalesLine."Line No.";

                LRecHisto.INSERT(false);
            until LRecSalesLine.NEXT() <= 0;
    end;

    procedure DELTransfCmdFactV(DELCodCmdeVente: Code[20]; DELCodFactVente: Code[20])
    var
        LRecLignesFV: Record "Sales Invoice Line";
        LRecHisto: Record "Historique ventes";
        LRecFactVenteHeader: Record "Sales Invoice Header";
    begin
        // Lors de la validation d'une commande vente
        // -> suppression des lignes de la commande vente dans l'historique
        DELDeleteCmdVente(DELCodCmdeVente);
        // -> ajout des lignes de la facture vente dans l'historique
        LRecLignesFV.Reset();
        LRecLignesFV.SETFILTER("Document No.", DELCodFactVente);
        LRecLignesFV.SETFILTER(Type, 'Item');
        LRecLignesFV.SETFILTER(Quantity, '>0');
        if LRecLignesFV.FINDSET(false) then
            repeat
                //todo field spe ,field removed
                if LRecFactVenteHeader.Get(LRecLignesFV."Document No.") then;
                LRecHisto.Reset();
                LRecHisto."N° devis" := LRecFactVenteHeader."Quote No.";
                LRecHisto."N° client" := LRecLignesFV."Sell-to Customer No.";
                LRecHisto."Date document vente" := LRecLignesFV."Posting Date";
                // LRecHisto."N° commande vente" := DELCodCmdeVente;
                LRecHisto."N° commande vente" := LRecFactVenteHeader."Order No.";
                LRecHisto."N° facture vente" := LRecLignesFV."Document No.";
                LRecHisto.Référence := LRecLignesFV."No.";
                LRecHisto.Description := LRecLignesFV.Description;
                //  LRecHisto."Référence externe" := LRecLignesFV."Cross-Reference No.";
                LRecHisto.Quantité := LRecLignesFV.Quantity;
                LRecHisto."Prix de vente" := LRecLignesFV."Unit Price";
                LRecHisto."% de remise" := LRecLignesFV."Line Discount %";
                LRecHisto."N° ligne vente" := LRecLignesFV."Line No.";

                LRecHisto.INSERT(false);

            until LRecLignesFV.NEXT() <= 0;
    end;

    procedure DELAddDevis(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLine: Record "Sales Line";
        LRecHisto: Record "Historique ventes";
    begin
        // Récupération des lignes du devis pour ajout dans l'historique
        LRecSalesLine.Reset();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SetRange("Document Type", LRecSalesLine."Document Type"::Quote);

        if LRecSalesLine.FINDSET(false) then
            repeat
                //todo field spe ,field removed
                // Suppression d'une version archivée de ce devis pour cet article et cette ligne de vente
                LRecHisto.Reset();
                LRecHisto.SETFILTER("N° devis", LRecSalesLine."Document No.");
                LRecHisto.SetRange(Référence, LRecSalesLine."No.");
                LRecHisto.SetRange("N° ligne vente", LRecSalesLine."Line No.");
                LRecHisto.SetRange(Archive, true);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.Reset();
                LRecHisto.SETFILTER("N° devis", LRecSalesLine."Document No.");
                LRecHisto.SetRange(Référence, LRecSalesLine."No.");
                LRecHisto.SetRange("N° ligne vente", LRecSalesLine."Line No.");
                LRecHisto.SetRange(Archive, false);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.Reset();
                LRecHisto."N° client" := LRecSalesLine."Sell-to Customer No.";
                // LRecHisto."Nom client" := LRecSalesLine."Nom Client";
                LRecHisto."Date document vente" := DocumentDate;
                LRecHisto."N° devis" := LRecSalesLine."Document No.";
                LRecHisto.Référence := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                //   LRecHisto."Référence externe" := LRecSalesLine."Cross-Reference No.";
                LRecHisto.Quantité := LRecSalesLine.Quantity;
                LRecHisto."Prix de vente" := LRecSalesLine."Unit Price";
                LRecHisto."% de remise" := LRecSalesLine."Line Discount %";
                LRecHisto."N° commande achat" := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."N° ligne vente" := LRecSalesLine."Line No.";

                if LRecHisto.INSERT(false) then;
            until LRecSalesLine.NEXT() <= 0;
    end;

    procedure DELDeleteDevis(DocumentNo: Code[20])
    var
        LRecHisto: Record "Historique ventes";
    begin
        //Suppression des lignes du devis dans l'historique
        LRecHisto.SetRange("N° devis", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddDevisArchive(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecSalesLineArchive: Record "Sales Line Archive";
        LRecHisto: Record "Historique ventes";
    begin
        // Récupération des lignes du devis archivé pour ajout dans l'historique
        LRecSalesLineArchive.Reset();
        LRecSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Version No.", "Doc. No. Occurrence", "Line No.");
        LRecSalesLineArchive.SETASCENDING("Version No.", false);
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SetRange("Document Type", LRecSalesLineArchive."Document Type"::Quote);
        LRecSalesLineArchive.SetRange("Document No.", DocumentNo);
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');

        if LRecSalesLineArchive.FINDSET(false) then
            repeat
                //todo field spe ,field removed
                LRecHisto.Reset();
                LRecHisto.SetRange("N° devis", LRecSalesLineArchive."Document No.");
                LRecHisto.SetRange(Référence, LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.Reset();
                    LRecHisto."N° client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := DocumentDate;
                    LRecHisto."N° devis" := LRecSalesLineArchive."Document No.";
                    LRecHisto.Référence := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    //  LRecHisto."Référence externe" := LRecSalesLineArchive."Cross-Reference No.";
                    LRecHisto.Quantité := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."N° commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."N° ligne vente" := LRecSalesLineArchive."Line No.";
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
        // Récupération des lignes du devis archivé pour ajout dans l'historique

        LRecSalesLineArchive.Reset();
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SetRange("Document Type", LRecSalesLineArchive."Document Type"::Order);
        LRecSalesLineArchive.SETFILTER("Document No.", DocumentNo);
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');


        if LRecSalesLineArchive.FINDSET(false) then
            repeat
                //todo field removed
                LRecHisto.Reset();
                LRecHisto.SETFILTER("N° devis", LRecSalesLineArchive."Document No.");
                LRecHisto.SetRange(Référence, LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.Reset();
                    LRecHisto."N° client" := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Date document vente" := DocumentDate;
                    LRecHisto."N° devis" := LRecSalesLineArchive."Document No.";
                    LRecHisto.Référence := LRecSalesLineArchive."No.";
                    LRecHisto.Description := LRecSalesLineArchive.Description;
                    //   LRecHisto."Référence externe" := LRecSalesLineArchive."Cross-Reference No.";
                    LRecHisto.Quantité := LRecSalesLineArchive.Quantity;
                    LRecHisto."Prix de vente" := LRecSalesLineArchive."Unit Price";
                    LRecHisto."% de remise" := LRecSalesLineArchive."Line Discount %";
                    LRecHisto."N° commande achat" := LRecSalesLineArchive."Special Order Purchase No.";
                    LRecHisto."N° ligne vente" := LRecSalesLineArchive."Line No.";
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
        // Suppression des lignes du devis archivé dans l'historique
        LRecSalesLine.Reset();
        LRecSalesLine.SETFILTER(Type, 'Item');
        //LRecSalesLineArchive.SetRange("Document Type", LRecSalesLineArchive."Document Type"::Order);
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        //LRecSalesLineArchive.SETFILTER(Quantity,'>0');


        if LRecSalesLine.FINDSET(false) then
            repeat
                if LRecSalesLineHeader.Get(LRecSalesLineHeader."Document Type", LRecSalesLineHeader."No.") then;
                LRecHisto.Reset();
                LRecHisto.SETFILTER("N° devis", LRecSalesLineHeader."Quote No.");
                LRecHisto.SetRange(Référence, LRecSalesLine."No.");
                LRecHisto.SetRange("N° client", LRecSalesLine."Sell-to Customer No.");
                LRecHisto.SETFILTER(Archive, 'TRUE');
                if LRecHisto.FINDSET(false) then
                    LRecHisto.DELETEALL();
            until LRecSalesLine.NEXT() = 0;
    end;
}

