namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Archive;
table 50000 "Sales Archive"
{
    DrillDownPageID = "Historique ventes article";
    LinkedObject = false;
    LookupPageID = "Historique ventes article";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name', Comment = 'Customer Name';
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(10; "Sales Document Date"; Date)
        {
            Caption = 'Sales Document Date', Comment = 'Sales Document Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Quote No."; Code[20])
        {
            Caption = 'Quote No.', Comment = 'Quote No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(12; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.', Comment = 'Sales Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(13; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.', Comment = 'Sales Invoice No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(20; "Reference"; Code[20])
        {
            Caption = 'Reference', Comment = 'Reference';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(21; Description; Text[100])
        {
            Caption = 'Description', Comment = 'Description';
            DataClassification = ToBeClassified;
        }
        field(22; "External Reference"; Code[50])
        {
            Caption = 'External Reference', Comment = 'External Reference';
            DataClassification = ToBeClassified;
        }
        field(30; "Quantity"; Decimal)
        {
            Caption = 'Quantity', Comment = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(31; "Sales Amount"; Decimal)
        {
            Caption = 'Sales Amount', Comment = 'Sales Amount';
            DataClassification = ToBeClassified;
        }
        field(32; "% Discount"; Decimal)
        {
            Caption = '% Discount', Comment = '% Discount';
            DataClassification = ToBeClassified;
        }
        field(40; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', Comment = 'Purchase Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No.";
        }
        field(50; "Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.', Comment = 'Sales Line No.';
            DataClassification = ToBeClassified;
        }
        field(68; Inventory; Decimal)
        {
            Caption = 'Inventory', Comment = 'Inventory';
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field(Reference)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Archive; Boolean)
        {
            Caption = 'Archive', Comment = 'Archive';
            DataClassification = ToBeClassified;
            InitValue = false;
        }
    }

    keys
    {
        key(Key1; "Reference", "Customer No.", "Quote No.", "Sales Line No.", "Sales Order No.", "Sales Invoice No.")
        {
            Clustered = true;
        }
        key(Key2; "Sales Document Date", "Reference", "Customer No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.", "Reference", "Sales Amount")
        {
        }
        fieldgroup(Brick; "Customer No.", "Reference", "Sales Amount")
        {
        }
    }

    procedure DELDeleteCmdVente(DocumentNo: Code[20])
    var
        LRecHisto: Record "Sales Archive";
    begin
        //Suppression des lignes de la commande vente dans l'historique
        LRecHisto.SetRange("Sales Order No.", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddCmdVente(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesHeader: Record "Sales Header";
        LRecSalesLine: Record "Sales Line";
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
                LRecHisto.Reset();
                if LRecSalesHeader.Get(LRecSalesLine."Document Type", LRecSalesLine."Document No.") then;
                LRecHisto."Quote No." := LRecSalesHeader."Quote No.";
                LRecHisto."Customer No." := LRecSalesLine."Sell-to Customer No.";
                LRecHisto."Customer Name" := LRecSalesLine."Customer Name";
                LRecHisto."Sales Document Date" := DocumentDate;
                LRecHisto."Sales Order No." := LRecSalesLine."Document No.";
                LRecHisto.Reference := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                LRecHisto."External Reference" := LRecSalesLine."Item Reference No.";
                LRecHisto.Quantity := LRecSalesLine.Quantity;
                LRecHisto."Sales Amount" := LRecSalesLine."Unit Price";
                LRecHisto."% Discount" := LRecSalesLine."Line Discount %";
                LRecHisto."Purchase Order No." := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."Sales Line No." := LRecSalesLine."Line No.";

                LRecHisto.INSERT(false);
            until LRecSalesLine.Next() <= 0;
    end;

    procedure DELTransfCmdFactV(DELCodCmdeVente: Code[20]; DELCodFactVente: Code[20])
    var
        LRecHisto: Record "Sales Archive";
        LRecFactVenteHeader: Record "Sales Invoice Header";
        LRecLignesFV: Record "Sales Invoice Line";
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
                if LRecFactVenteHeader.Get(LRecLignesFV."Document No.") then;
                LRecHisto.Reset();
                LRecHisto."Quote No." := LRecFactVenteHeader."Quote No.";
                LRecHisto."Customer No." := LRecLignesFV."Sell-to Customer No.";
                LRecHisto."Sales Document Date" := LRecLignesFV."Posting Date";
                LRecHisto."Sales Order No." := DELCodCmdeVente;
                LRecHisto."Sales Order No." := LRecFactVenteHeader."Order No.";
                LRecHisto."Sales Invoice No." := LRecLignesFV."Document No.";
                LRecHisto.Reference := LRecLignesFV."No.";
                LRecHisto.Description := LRecLignesFV.Description;
                LRecHisto."External Reference" := LRecLignesFV."Item Reference No.";
                LRecHisto.Quantity := LRecLignesFV.Quantity;
                LRecHisto."Sales Amount" := LRecLignesFV."Unit Price";
                LRecHisto."% Discount" := LRecLignesFV."Line Discount %";
                LRecHisto."Sales Line No." := LRecLignesFV."Line No.";

                LRecHisto.INSERT(false);

            until LRecLignesFV.Next() <= 0;
    end;

    procedure DELAddDevis(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesLine: Record "Sales Line";
    begin
        // Récupération des lignes du devis pour ajout dans l'historique
        LRecSalesLine.Reset();
        LRecSalesLine.SETFILTER(Type, 'Item');
        LRecSalesLine.SETFILTER("Document No.", DocumentNo);
        LRecSalesLine.SETFILTER(Quantity, '>0');
        LRecSalesLine.SetRange("Document Type", LRecSalesLine."Document Type"::Quote);

        if LRecSalesLine.FINDSET(false) then
            repeat
                // Suppression d'une version archivée de ce devis pour cet article et cette ligne de vente
                LRecHisto.Reset();
                LRecHisto.SETFILTER("Quote No.", LRecSalesLine."Document No.");
                LRecHisto.SetRange(Reference, LRecSalesLine."No.");
                LRecHisto.SetRange("Sales Line No.", LRecSalesLine."Line No.");
                LRecHisto.SetRange(Archive, true);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.Reset();
                LRecHisto.SETFILTER("Quote No.", LRecSalesLine."Document No.");
                LRecHisto.SetRange(Reference, LRecSalesLine."No.");
                LRecHisto.SetRange("Sales Line No.", LRecSalesLine."Line No.");
                LRecHisto.SetRange(Archive, false);
                if LRecHisto.FINDFIRST() then LRecHisto.DELETE();
                LRecHisto.Reset();
                LRecHisto."Customer No." := LRecSalesLine."Sell-to Customer No.";
                LRecHisto."Customer Name" := LRecSalesLine."Customer Name";
                LRecHisto."Sales Document Date" := DocumentDate;
                LRecHisto."Quote No." := LRecSalesLine."Document No.";
                LRecHisto.Reference := LRecSalesLine."No.";
                LRecHisto.Description := LRecSalesLine.Description;
                LRecHisto."External Reference" := LRecSalesLine."Item Reference No.";
                LRecHisto.Quantity := LRecSalesLine.Quantity;
                LRecHisto."Sales Amount" := LRecSalesLine."Unit Price";
                LRecHisto."% Discount" := LRecSalesLine."Line Discount %";
                LRecHisto."Purchase Order No." := LRecSalesLine."Special Order Purchase No.";
                LRecHisto."Sales Line No." := LRecSalesLine."Line No.";

                if LRecHisto.INSERT(false) then;
            until LRecSalesLine.Next() <= 0;
    end;

    procedure DELDeleteDevis(DocumentNo: Code[20])
    var
        LRecHisto: Record "Sales Archive";
    begin
        //Suppression des lignes du devis dans l'historique
        LRecHisto.SetRange("Quote No.", DocumentNo);
        LRecHisto.DELETEALL();
    end;

    procedure DELAddDevisArchive(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesLineArchive: Record "Sales Line Archive";
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
                LRecHisto.Reset();
                LRecHisto.SetRange("Quote No.", LRecSalesLineArchive."Document No.");
                LRecHisto.SetRange(Reference, LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.Reset();
                    LRecHisto."Customer No." := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Sales Document Date" := DocumentDate;
                    LRecHisto."Quote No." := LRecSalesLineArchive."Document No.";
                    LRecHisto.Reference := LRecSalesLineArchive."No.";
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
            until LRecSalesLineArchive.Next() = 0;
    end;

    procedure DELAddCmdVenteArchive(DocumentNo: Code[20]; DocumentDate: Date)
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesLineArchive: Record "Sales Line Archive";
    begin
        // Récupération des lignes du devis archivé pour ajout dans l'historique

        LRecSalesLineArchive.Reset();
        LRecSalesLineArchive.SETFILTER(Type, 'Item');
        LRecSalesLineArchive.SetRange("Document Type", LRecSalesLineArchive."Document Type"::Order);
        LRecSalesLineArchive.SETFILTER("Document No.", DocumentNo);
        LRecSalesLineArchive.SETFILTER(Quantity, '>0');


        if LRecSalesLineArchive.FINDSET(false) then
            repeat
                LRecHisto.Reset();
                LRecHisto.SETFILTER("Quote No.", LRecSalesLineArchive."Document No.");
                LRecHisto.SetRange(Reference, LRecSalesLineArchive."No.");
                if not LRecHisto.FINDFIRST() then begin
                    LRecHisto.Reset();
                    LRecHisto."Customer No." := LRecSalesLineArchive."Sell-to Customer No.";
                    LRecHisto."Sales Document Date" := DocumentDate;
                    LRecHisto."Quote No." := LRecSalesLineArchive."Document No.";
                    LRecHisto.Reference := LRecSalesLineArchive."No.";
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
            until LRecSalesLineArchive.Next() = 0;
    end;

    procedure DELSupprDevisHisto(DocumentNo: Code[20])
    var
        LRecHisto: Record "Sales Archive";
        LRecSalesLineHeader: Record "Sales Header";
        LRecSalesLine: Record "Sales Line";
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
                LRecHisto.SETFILTER("Quote No.", LRecSalesLineHeader."Quote No.");
                LRecHisto.SetRange(Reference, LRecSalesLine."No.");
                LRecHisto.SetRange("Customer No.", LRecSalesLine."Sell-to Customer No.");
                LRecHisto.SETFILTER(Archive, 'TRUE');
                if LRecHisto.FINDSET(false) then
                    LRecHisto.DELETEALL();
            until LRecSalesLine.Next() = 0;
    end;
}

