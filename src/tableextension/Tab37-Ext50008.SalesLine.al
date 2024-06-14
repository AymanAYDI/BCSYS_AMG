namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
tableextension 50008 SalesLine extends "Sales Line" //37
{
    fields
    {
        //TODO: Code dans le trigger OnDelete impossible à migrer
        field(50001; Marge; Decimal)
        {
            Caption = 'Marge', Comment = 'FRA="Marge"';
        }
        field(50002; Marque; Decimal)
        {
            Caption = '% Marge';
            trigger OnValidate()
            begin
                //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
                FCalculateOnMargeChange();
            end;
        }
        field(50010; "Fournisseur article"; Code[20])
        {
            CalcFormula = lookup(Item."Vendor No." where("No." = field("No.")));
            Caption = 'Vendor', Comment = 'FRA="Fabricant"';
            FieldClass = FlowField;
        }
        field(50020; "Nom Client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Caption = 'Customer Name', Comment = 'FRA="Nom Client"';
            FieldClass = FlowField;
        }
        field(50030; Sel; Boolean)
        {
            Caption = 'Sel';
            DataClassification = ToBeClassified;
        }
    }
    procedure FCalculeMarge()
    var
        LRecItem: Record Item;
    begin
        Marge := 0;
        if LRecItem.GET("No.") then
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                Marge := Amount - ("Quantity (Base)" * LRecItem."Last Direct Cost")
            else
                Marge := Amount - ("Quantity (Base)" * LRecItem."Unit Cost");
    end;

    procedure FCalculeMarque()
    begin
        Marque := 0;
        if Amount <> 0 then
            Marque := (Marge / Amount) * 100;
    end;

    procedure FCalculateOnMargeChange()
    var
        LRecItem: Record Item;
        LDecUnitCost: Decimal;
    begin
        // DELPHI AUB 27.06.2019
        if LRecItem.GET("No.") then begin
            //DELPHI AUB 15.10.2019
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                LDecUnitCost := LRecItem."Last Direct Cost" * "Quantity (Base)"
            else
                LDecUnitCost := LRecItem."Unit Cost" * "Quantity (Base)";
            //END DELPHI AUB 15.10.2019
            if "Line Discount %" <> 0 then begin
                "Unit Price" := ((LDecUnitCost / Quantity) / (1 - (Marque / 100))) * (1 + ("Line Discount %" / 100));
                VALIDATE("Unit Price");
            end else begin
                "Unit Price" := (LDecUnitCost / Quantity) / (1 - (Marque / 100));
                VALIDATE("Unit Price");
            end;

            Marge := Amount - (Quantity * "Unit Cost");
        end;

        //END DELPHI AUB 27.06.2019
    end;

    procedure FCalculateMargeOnLineDiscountChange()
    var
        LRecItem: Record Item;
        LDecUnitCost: Decimal;
    begin
        // DELPHI AUB 27.06.2019
        if LRecItem.GET("No.") then begin //DELPHI AUB 15.10.2019
            if (LRecItem."Price/Profit Calculation" = LRecItem."Price/Profit Calculation"::"Price=Last Direct Cost+Profit") and (LRecItem."Last Direct Cost" > 0) then
                LDecUnitCost := LRecItem."Last Direct Cost" * "Quantity (Base)"
            else
                LDecUnitCost := LRecItem."Unit Cost" * "Quantity (Base)";
            //END DELPHI AUB 15.10.2019
            if "Line Discount %" <> 0 then
                "Unit Price" := (LDecUnitCost / Quantity) / (1 - (Marque / 100));

            Marge := Amount - (Quantity * "Unit Cost");
        end;

        //END DELPHI AUB 27.06.2019
    end;

    procedure FAddLinesForCarbo(DELRecSalesHeader: Record "Sales Header"; DELCodItemNo: Code[20]; DELDecQty: Decimal)
    var
        LRecSalesLine: Record "Sales Line";
        LRecItem: Record Item;
        LRecSalesLinetoInsert: Record "Sales Line";
        LIntLineNo: Integer;
    begin
        //DELPHI AUB 26.02.2021 AMG.CARBO
        // Si un article avec la case "type carbo" est cochée, affichage d'une fenêtre de choix
        //ajout d'une ligne de boîte carbo

        LRecSalesLine.RESET();
        LRecSalesLine.SETFILTER("Document No.", DELRecSalesHeader."No.");
        LRecSalesLine.SETRANGE("Document Type", DELRecSalesHeader."Document Type");
        if LRecSalesLine.FINDLAST() then
            LIntLineNo := LRecSalesLine."Line No." + 15000
        else
            LIntLineNo := 15000;

        LRecItem.RESET();
        //Récupération de l'article boîte carbo à insérer dans les lignes
        if LRecItem.GET(DELCodItemNo) then begin
            LRecSalesLinetoInsert.RESET();
            LRecSalesLinetoInsert.SETRANGE("Document No.", DELRecSalesHeader."No.");
            LRecSalesLinetoInsert.SETRANGE("Document Type", DELRecSalesHeader."Document Type");
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
            //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
            LRecSalesLinetoInsert.FCalculeMarge();
            LRecSalesLinetoInsert.FCalculeMarque();
            // LRecSalesLinetoInsert.VALIDATE("VAT Bus. Posting Group",LRecItem.VAT);
            LRecSalesLinetoInsert.VALIDATE("VAT Prod. Posting Group", LRecItem."VAT Prod. Posting Group");
            LRecSalesLinetoInsert."Location Code" := 'AMGALLOIS';
            LRecSalesLinetoInsert.INSERT();
            COMMIT();
        end;

    end;
}

