namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Projects.Resources.Resource;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using System.IO;
tableextension 50008 SalesLine extends "Sales Line" //37
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"),
                "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true),
                                                                                          "Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if (Type = const("G/L Account"),
               "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Item)) Item where(Blocked = const(false), "Sales Blocked" = const(false));
        }
        modify(Description)
        {
            TableRelation = if (Type = const("G/L Account"),
                                "System-Created Entry" = const(false)) "G/L Account".Name where("Direct Posting" = const(true),
                                                                                          "Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account".Name
            else
            if (Type = const(Item)) Item.Description where(Blocked = const(false), "Sales Blocked" = const(false))
            else
            if (Type = const(Resource)) Resource.Name
            else
            if (Type = const("Fixed Asset")) "Fixed Asset".Description
            else
            if (Type = const("Charge (Item)")) "Item Charge".Description;
        }
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }
        field(50001; Marge; Decimal)
        {
            Caption = 'Marge';
            DataClassification = ToBeClassified;
        }
        field(50002; Marque; Decimal)
        {
            Caption = '% Marge';
            DataClassification = ToBeClassified;
        }
        field(50010; "Item supplier"; Code[20])
        {
            CalcFormula = lookup(Item."Vendor No." where("No." = field("No.")));
            Caption = 'Vendor';
            FieldClass = FlowField;
        }
        field(50020; "Customer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Caption = 'Customer Name';
            FieldClass = FlowField;
        }
        field(50030; Sel; Boolean)
        {
            Caption = 'Sel';
            DataClassification = ToBeClassified;
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
                VALIDATE("Unit Price");
            end else begin
                "Unit Price" := (LDecUnitCost / Quantity) / (1 - (Marque / 100));
                VALIDATE("Unit Price");
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
                VALIDATE("Unit Price");
            end else
                VALIDATE("Unit Price");
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

            LRecSalesLinetoInsert.VALIDATE(Type, LRecSalesLinetoInsert.Type::Item);
            LRecSalesLinetoInsert.VALIDATE("No.", LRecItem."No.");
            LRecSalesLinetoInsert.VALIDATE(Description, LRecItem.Description);
            LRecSalesLinetoInsert.VALIDATE(Quantity, DELDecQty);
            LRecSalesLinetoInsert.VALIDATE("Unit Price", LRecItem."Unit Price");
            LRecSalesLinetoInsert.Marge := FCalculeMarge(LRecItem."No.", DELDecQty, LRecItem."Unit Price");
            LRecSalesLinetoInsert.Marque := FCalculeMarque(LRecSalesLinetoInsert.Marge, LRecItem."Unit Price");
            // LRecSalesLinetoInsert.VALIDATE("VAT Bus. Posting Group",LRecItem.VAT);
            LRecSalesLinetoInsert.VALIDATE("VAT Prod. Posting Group", LRecItem."VAT Prod. Posting Group");
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

