namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Projects.Resources.Resource;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using System.IO;
tableextension 50008 SalesLine extends "Sales Line" //37 //TODOD : TO MERGE
{
    fields
    {
        field(50001; Marge; Decimal)
        {
            Caption = 'Marge';
            DataClassification = ToBeClassified;
            Description = 'AMG';
        }
        field(50002; Marque; Decimal)
        {
            Caption = '% Marge';
            DataClassification = ToBeClassified;
            Description = 'AMG';

            trigger OnValidate()
            begin
                //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
                FCalculateOnMargeChange();
            end;
        }
        field(50010; "Fournisseur article"; Code[20])
        {
            CalcFormula = Lookup(Item."Vendor No." WHERE("No." = FIELD("No.")));
            Caption = 'Vendor';
            Description = 'AMG,EVO34';
            FieldClass = FlowField;
        }
        field(50020; "Nom Client"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Sell-to Customer No.")));
            Caption = 'Customer Name';
            Description = 'AMG';
            FieldClass = FlowField;
        }
        field(50030; Sel; Boolean)
        {
            Caption = 'Sel';
            DataClassification = ToBeClassified;
            Description = 'AMG';
        }
    }
    procedure FCalculeMarge("Item No": Code[20]; Quantiter: Decimal; "Prix Vente Remiser": Decimal) Marge: Decimal
    var
        LRecItem: Record Item;
        LDecMarge: Decimal;
    begin
        Marge := 0;
        if LRecItem.Get("Item No") then
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                Marge := "Prix Vente Remiser" - (Quantiter * LRecItem."Last Direct Cost")
            else
                Marge := "Prix Vente Remiser" - (Quantiter * LRecItem."Unit Cost");
        exit(Marge);
    end;

    procedure FCalculeMarque(Marge: Decimal; "Prix Vente Remiser": Decimal) Marque: Decimal
    begin
        Marque := 0;
        if "Prix Vente Remiser" <> 0 then
            Marque := (Marge / "Prix Vente Remiser") * 100;
        exit(Marque);
    end;

    procedure FCalculateOnMargeChange(NoItem: Code[20]; Marque: Decimal)
    var
        LRecItem: Record Item;
        LDecUnitCost: Decimal;
    begin
        if LRecItem.Get(NoItem) then begin
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                LDecUnitCost := LRecItem."Last Direct Cost" * "Quantity (Base)"
            else
                LDecUnitCost := LRecItem."Unit Cost" * "Quantity (Base)";
            if "Line Discount %" <> 0 then begin
                "Unit Price" := ((LDecUnitCost / Quantity) / (1 - (Marque / 100))) * (1 + ("Line Discount %" / 100));
                Validate("Unit Price");
            end else begin
                "Unit Price" := (LDecUnitCost / Quantity) / (1 - (Marque / 100));
                Validate("Unit Price");
            end;

            Marge := Amount - (Quantity * "Unit Cost");
        end;
    end;

    procedure FCalculateMargeOnLineDiscountChange(ItemNo: Code[20])
    var
        LRecItem: Record Item;
        LDecUnitCost: Decimal;
    begin
        if LRecItem.Get(ItemNo) then begin
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                LDecUnitCost := LRecItem."Last Direct Cost" * "Quantity (Base)"
            else
                LDecUnitCost := LRecItem."Unit Cost" * "Quantity (Base)";
            if "Line Discount %" <> 0 then begin
                "Unit Price" := (LDecUnitCost / Quantity) / (1 - (Marque / 100));
                Validate("Unit Price");
            end else
                Validate("Unit Price");
            Marge := Amount - (Quantity * "Unit Cost");
        end;
    end;

    procedure FAddLinesForCarbo(DELRecSalesHeader: Record "Sales Header"; DELCodItemNo: Code[20]; DELDecQty: Decimal)
    var
        LRecItem: Record Item;
        LRecSalesLine: Record "Sales Line";
        LRecSalesLinetoInsert: Record "Sales Line";
        LIntLineNo: Integer;
    begin
        // Si un article avec la case "type carbo" est cochée, affichage d'une fenêtre de choix
        //ajout d'une ligne de boîte carbo

        LRecSalesLine.Reset();
        LRecSalesLine.SETFILTER("Document No.", DELRecSalesHeader."No.");
        LRecSalesLine.SetRange("Document Type", DELRecSalesHeader."Document Type");
        if LRecSalesLine.FINDLAST() then
            LIntLineNo := LRecSalesLine."Line No." + 15000
        else
            LIntLineNo := 15000;

        LRecItem.Reset();
        //Récupération de l'article boîte carbo à insérer dans les lignes
        if LRecItem.Get(DELCodItemNo) then begin
            LRecSalesLinetoInsert.Reset();
            LRecSalesLinetoInsert.SetRange("Document No.", DELRecSalesHeader."No.");
            LRecSalesLinetoInsert.SetRange("Document Type", DELRecSalesHeader."Document Type");
            //  LRecSalesLinetoInsert.FINDLAST;

            LRecSalesLinetoInsert.INIT();
            LRecSalesLinetoInsert."Line No." := LIntLineNo;
            LRecSalesLinetoInsert."Document No." := DELRecSalesHeader."No.";
            LRecSalesLinetoInsert."Document Type" := DELRecSalesHeader."Document Type";

            LRecSalesLinetoInsert.Validate(Type, LRecSalesLinetoInsert.Type::Item);
            LRecSalesLinetoInsert.Validate("No.", LRecItem."No.");
            LRecSalesLinetoInsert.Validate(Description, LRecItem.Description);
            LRecSalesLinetoInsert.Validate(Quantity, DELDecQty);
            LRecSalesLinetoInsert.Validate("Unit Price", LRecItem."Unit Price");
            LRecSalesLinetoInsert.Marge := FCalculeMarge(LRecItem."No.", DELDecQty, LRecItem."Unit Price");
            LRecSalesLinetoInsert.Marque := FCalculeMarque(LRecSalesLinetoInsert.Marge, LRecItem."Unit Price");
            // LRecSalesLinetoInsert.Validate("VAT Bus. Posting Group",LRecItem.VAT);
            LRecSalesLinetoInsert.Validate("VAT Prod. Posting Group", LRecItem."VAT Prod. Posting Group");
            LRecSalesLinetoInsert."Location Code" := 'AMGALLOIS';
            LRecSalesLinetoInsert.INSERT();
            COMMIT();
        end;

    end;

    var
        LRecItem: Record Item;
        XMLBuffer: Record "XML Buffer";
        XMLSpecialInterestNode: Record "XML Buffer";
        FindRecordMgt: codeunit "Find Record Management";
        XMLBufferWriter: codeunit "XML Buffer Writer";
        LCodItemNo: Code[20];
        LDecQty: Decimal;
        LTextParam: Text;
        NodeNotFoundErr: Text;

    //TODO Ondelete
    //TODO Onvalidate No. line 
    //TODO Onvalidate location code line 437
    //TODO Onvalidate Allow Invoice Disc. line 985
    //TODO prod CalcBaseQty line 2930
    //TODO verif  line 2974
    //TODO prod GetItem line 3121
    //TODO prod UpdateVATAmounts line 3364
    //TODO prod UpdateVATAmounts 
    //TODO prod additem line 3893
    //TODO  line 4373
    //TODO verif prod ValidateCrossReferenceNo line 4811
    //TODO verifier prod CheckApplFromItemLedgEntry line 4950
}

