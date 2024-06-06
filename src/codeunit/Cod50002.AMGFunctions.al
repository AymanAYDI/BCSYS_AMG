codeunit 50002 "AMG_Functions"
{
    SingleInstance = true;

    var
        CalledFromAdjustment: Boolean;
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













    //Codeunit 22 dupliqué
    procedure GetProdOrderLine(var ProdOrderLine: Record "Prod. Order Line"; OrderNo: Code[20]; OrderLineNo: Integer)
    begin
        ProdOrderLine.Get(ProdOrderLine.Status::Released, OrderNo, OrderLineNo);
    end;
    //Codeunit 22 dupliqué
    procedure SetOrderAdjmtProperties(ItemLedgEntryType: Enum "Item Ledger Entry Type"; OrderType: Enum "Inventory Order Type";
                                                             OrderNo: Code[20];
                                                             OrderLineNo: Integer;
                                                             OriginalPostingDate: Date;
                                                             ValuationDate: Date)
    var
        AssemblyHeader: Record "Assembly Header";
        InventoryAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)";
        ProdOrderLine: Record "Prod. Order Line";
        ValueEntry: Record "Value Entry";
        ItemJN: Codeunit "Item Jnl.-Post Line";
        ModifyOrderAdjmt: Boolean;
    begin
        if not (OrderType in [ValueEntry."Order Type"::Production,
                            ValueEntry."Order Type"::Assembly])
      then
            exit;

        if ItemLedgEntryType in [ValueEntry."Item Ledger Entry Type"::Output,
                                 ValueEntry."Item Ledger Entry Type"::"Assembly Output"]
        then
            exit;

        if InventoryAdjmtEntryOrder.Get(OrderType, OrderNo, OrderLineNo) then begin
            if InventoryAdjmtEntryOrder."Allow Online Adjustment" or InventoryAdjmtEntryOrder."Cost is Adjusted" then begin
                InventoryAdjmtEntryOrder.LOCKTABLE();
                if InventoryAdjmtEntryOrder."Cost is Adjusted" then begin
                    InventoryAdjmtEntryOrder."Cost is Adjusted" := false;
                    ModifyOrderAdjmt := true;
                end;
                if InventoryAdjmtEntryOrder."Allow Online Adjustment" then begin
                    InventoryAdjmtEntryOrder."Allow Online Adjustment" := ItemJN.AllowAdjmtOnPosting(OriginalPostingDate);
                    ModifyOrderAdjmt := ModifyOrderAdjmt or not InventoryAdjmtEntryOrder."Allow Online Adjustment";
                end;
                if ModifyOrderAdjmt then
                    InventoryAdjmtEntryOrder.Modify();
            end;
        end else
            case OrderType of
                InventoryAdjmtEntryOrder."Order Type"::Production:
                    begin
                        GetProdOrderLine(ProdOrderLine, OrderNo, OrderLineNo);
                        InventoryAdjmtEntryOrder.SetProdOrderLine(ProdOrderLine);
                        SetOrderAdjmtProperties(ItemLedgEntryType, OrderType, OrderNo, OrderLineNo, OriginalPostingDate, ValuationDate);
                    end;
                InventoryAdjmtEntryOrder."Order Type"::Assembly:
                    begin
                        if OrderLineNo = 0 then begin
                            AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, OrderNo);
                            InventoryAdjmtEntryOrder.SetAsmOrder(AssemblyHeader);
                        end;
                        SetOrderAdjmtProperties(ItemLedgEntryType, OrderType, OrderNo, 0, OriginalPostingDate, ValuationDate);
                    end;
            end;
    end;
    //Codeunit 22 dupliqué
    procedure MaxConsumptionValuationDate(ItemLedgerEntry: Record "Item Ledger Entry"): Date
    var
        ValueEntry: Record "Value Entry";
        ValuationDate: Date;
    begin
        ValueEntry.SetCurrentKey("Item Ledger Entry Type", "Order No.", "Valuation Date");
        ValueEntry.SetRange("Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SetRange("Order No.", ItemLedgerEntry."Order No.");
        ValueEntry.SetRange("Order Line No.", ItemLedgerEntry."Order Line No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Consumption);
        if ValueEntry.FindLast() then
            repeat
                if (ValueEntry."Valuation Date" > ValuationDate) and
                   (ValueEntry."Entry Type" <> ValueEntry."Entry Type"::Revaluation)
                then
                    ValuationDate := ValueEntry."Valuation Date";
            until ValueEntry.Next() = 0;
        exit(ValuationDate);
    end;
    //Codeunit 5804 dupliqué
    procedure CalculateAverageCost(var Item: Record Item; var AverageCost: Decimal; var AverageCostACY: Decimal): Boolean
    var
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        NeedCalcPreciseAmt: Boolean;
        NeedCalcPreciseAmtACY: Boolean;
        AverageQty: Decimal;
        CostAmt: Decimal;
        CostAmtACY: Decimal;
    begin
        AverageCost := 0;
        AverageCostACY := 0;
        GLSetup.Get();
        if CalledFromAdjustment then
            ExcludeOpenOutbndCosts(Item, AverageCost, AverageCostACY, AverageQty);
        AverageQty := AverageQty + CalculateQuantity(Item);
        if AverageQty <> 0 then begin
            CostAmt := AverageCost + CalculateCostAmt(Item, true) + CalculateCostAmt(Item, false);
            if (CostAmt <> 0) and (ABS(CostAmt) = GLSetup."Amount Rounding Precision") then begin
                NeedCalcPreciseAmt := true;
                CostAmt := AverageCost;
            end;
            if GLSetup."Additional Reporting Currency" <> '' then begin
                Currency.Get(GLSetup."Additional Reporting Currency");
                CostAmtACY := AverageCostACY + CalculateCostAmtACY(Item, true) + CalculateCostAmtACY(Item, false);
                if (CostAmtACY <> 0) and (ABS(CostAmtACY) = Currency."Amount Rounding Precision") then begin
                    NeedCalcPreciseAmtACY := true;
                    CostAmtACY := AverageCostACY;
                end;
            end;
            if NeedCalcPreciseAmt or NeedCalcPreciseAmtACY then
                CalculatePreciseCostAmounts(Item, NeedCalcPreciseAmt, NeedCalcPreciseAmtACY, CostAmt, CostAmtACY);

            AverageCost := CostAmt / AverageQty;
            AverageCostACY := CostAmtACY / AverageQty;
            if AverageCost < 0 then
                AverageCost := 0;
            if AverageCostACY < 0 then
                AverageCostACY := 0;
        end else begin
            AverageCost := 0;
            AverageCostACY := 0;
        end;
        if AverageQty <= 0 then
            exit(false);

        exit(true);
    end;
    //Codeunit 5804 dupliqué
    procedure ExcludeOpenOutbndCosts(var Item: Record Item; var CostAmt: Decimal; var CostAmtACY: Decimal; var Quantity: Decimal)
    var
        OpenItemLedgEntry: Record "Item Ledger Entry";
        OpenValueEntry: Record "Value Entry";
    begin
        OpenItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive);
        OpenItemLedgEntry.SetRange("Item No.", Item."No.");
        OpenItemLedgEntry.SetRange(Open, true);
        OpenItemLedgEntry.SetRange(Positive, false);
        OpenItemLedgEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        OpenItemLedgEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        OpenValueEntry.SetCurrentKey("Item Ledger Entry No.");
        if OpenItemLedgEntry.findfirst() then
            repeat
                OpenValueEntry.SetRange("Item Ledger Entry No.", OpenItemLedgEntry."Entry No.");
                if OpenValueEntry.findfirst() then
                    repeat
                        CostAmt := CostAmt - OpenValueEntry."Cost Amount (Actual)" - OpenValueEntry."Cost Amount (Expected)";
                        CostAmtACY := CostAmtACY - OpenValueEntry."Cost Amount (Actual) (ACY)" - OpenValueEntry."Cost Amount (Expected) (ACY)";
                        Quantity := Quantity - OpenValueEntry."Item Ledger Entry Quantity";
                    until OpenValueEntry.Next() = 0;
            until OpenItemLedgEntry.Next() = 0;
    end;
    //Codeunit 5804 dupliqué
    procedure CalculateQuantity(var Item: Record Item) CalcQty: Decimal
    var
        ValueEntry: Record "Value Entry";
        ItemCostManagement: codeunit ItemCostManagement;
    begin
        ItemCostManagement.SetFilters(ValueEntry, Item);
        ValueEntry.CalcSums("Item Ledger Entry Quantity");
        CalcQty := ValueEntry."Item Ledger Entry Quantity";
        exit(CalcQty);
    end;
    //Codeunit 5804 dupliqué
    procedure CalculateCostAmt(var Item: Record Item; Actual: Boolean) CostAmount: Decimal
    var
        ValueEntry: Record "Value Entry";
        ItemCostManagement: codeunit ItemCostManagement;
    begin
        ItemCostManagement.SetFilters(ValueEntry, Item);
        if Actual then begin
            ValueEntry.CalcSums("Cost Amount (Actual)");
            exit(ValueEntry."Cost Amount (Actual)");
        end;
        ValueEntry.CalcSums("Cost Amount (Expected)");
        exit(ValueEntry."Cost Amount (Expected)");
    end;
    //Codeunit 5804 dupliqué
    procedure CalculateCostAmtACY(var Item: Record Item; Actual: Boolean): Decimal
    var
        ValueEntry: Record "Value Entry";
        ItemCostManagement: codeunit ItemCostManagement;
    begin
        ItemCostManagement.SetFilters(ValueEntry, Item);
        if Actual then begin
            ValueEntry.CalcSums("Cost Amount (Actual) (ACY)");
            exit(ValueEntry."Cost Amount (Actual) (ACY)");
        end;
        ValueEntry.CalcSums("Cost Amount (Expected) (ACY)");
        exit(ValueEntry."Cost Amount (Expected) (ACY)");
    end;
    //Codeunit 5804 dupliqué   //TODO verifier line 365
    procedure CalculatePreciseCostAmounts(var Item: Record Item; NeedCalcPreciseAmt: Boolean; NeedCalcPreciseAmtACY: Boolean; var PreciseAmt: Decimal; var PreciseAmtACY: Decimal)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        OpenInbndItemLedgEntry: Record "Item Ledger Entry";
        OpenOutbndItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
    begin
        // Collect precise (not rounded) remaining cost on:
        // 1. open inbound item ledger entries;
        // 2. closed inbound item ledger entries the open outbound item entries are applied to.
        PreciseAmt := 0;
        PreciseAmtACY := 0;

        OpenInbndItemLedgEntry.SetRange("Item No.", Item."No.");
        OpenInbndItemLedgEntry.SetRange(Open, true);
        OpenInbndItemLedgEntry.SetRange(Positive, true);
        OpenInbndItemLedgEntry.SetRange("Location Code", Item.GetFilter("Location Filter"));
        OpenInbndItemLedgEntry.SetRange("Variant Code", Item.GetFilter("Variant Filter"));
        if OpenInbndItemLedgEntry.FindSet() then
            repeat
                TempItemLedgerEntry := OpenInbndItemLedgEntry;
                TempItemLedgerEntry.Insert();
            until OpenInbndItemLedgEntry.Next() = 0;

        OpenOutbndItemLedgEntry.CopyFilters(OpenInbndItemLedgEntry);
        OpenOutbndItemLedgEntry.SetRange(Positive, false);
        if OpenOutbndItemLedgEntry.FindSet() then
            repeat
                if ItemApplicationEntry.GetInboundEntriesTheOutbndEntryAppliedTo(OpenOutbndItemLedgEntry."Entry No.") then
                    repeat
                        if TempItemLedgerEntry.Get(ItemApplicationEntry."Inbound Item Entry No.") then begin
                            TempItemLedgerEntry."Remaining Quantity" -= ItemApplicationEntry.Quantity;
                            TempItemLedgerEntry.Modify();
                        end else begin
                            OpenInbndItemLedgEntry.Get(ItemApplicationEntry."Inbound Item Entry No.");
                            TempItemLedgerEntry := OpenInbndItemLedgEntry;
                            TempItemLedgerEntry."Remaining Quantity" := -ItemApplicationEntry.Quantity;
                            TempItemLedgerEntry.Insert();
                        end;
                    until ItemApplicationEntry.Next() = 0;
            until OpenOutbndItemLedgEntry.Next() = 0;

        TempItemLedgerEntry.Reset();
        if TempItemLedgerEntry.FindSet() then
            repeat
                if NeedCalcPreciseAmt then begin
                    TempItemLedgerEntry.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                    PreciseAmt += (TempItemLedgerEntry."Cost Amount (Actual)" + TempItemLedgerEntry."Cost Amount (Expected)") / TempItemLedgerEntry.Quantity * TempItemLedgerEntry."Remaining Quantity";
                end;
                if NeedCalcPreciseAmtACY then begin
                    TempItemLedgerEntry.CalcFields("Cost Amount (Actual) (ACY)", "Cost Amount (Expected) (ACY)");
                    PreciseAmtACY += (TempItemLedgerEntry."Cost Amount (Actual) (ACY)" + TempItemLedgerEntry."Cost Amount (Expected) (ACY)") / TempItemLedgerEntry.Quantity * TempItemLedgerEntry."Remaining Quantity";
                end;
            until TempItemLedgerEntry.Next() = 0;
    end;
    //Codeunit 5804 dupliqué
    procedure CalcLastAdjEntryAvgCost(var Item: Record Item; var AverageCost: Decimal; var AverageCostACY: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ItemCostManagement: codeunit ItemCostManagement;
        ComputeThisEntry: Boolean;
        IsSubOptimal: Boolean;
    begin
        AverageCost := 0;
        AverageCostACY := 0;

        if CalculateQuantity(Item) <> 0 then
            exit;
        if not HasOpenEntries(Item) then
            exit;

        ItemCostManagement.SetFilters(ValueEntry, Item);
        if ValueEntry.findlast() then
            repeat
                ComputeThisEntry := (ValueEntry."Item Ledger Entry Quantity" < 0) and not ValueEntry.Adjustment and not ValueEntry."Drop Shipment";
                if ComputeThisEntry then begin
                    ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.");
                    IsSubOptimal :=
                      ItemLedgEntry.Correction or
                      ((Item."Costing Method" = Item."Costing Method"::Average) and not ValueEntry."Valued By Average Cost");

                    if not IsSubOptimal or (IsSubOptimal and (AverageCost = 0)) then begin
                        ItemLedgEntry.CalcFields(
                          "Cost Amount (Expected)", "Cost Amount (Actual)",
                          "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)");
                        AverageCost :=
                          (ItemLedgEntry."Cost Amount (Expected)" +
                           ItemLedgEntry."Cost Amount (Actual)") /
                          ItemLedgEntry.Quantity;
                        AverageCostACY :=
                          (ItemLedgEntry."Cost Amount (Expected) (ACY)" +
                           ItemLedgEntry."Cost Amount (Actual) (ACY)") /
                          ItemLedgEntry.Quantity;
                        if (AverageCost <> 0) and not IsSubOptimal then
                            exit;
                    end;
                end;
            until ValueEntry.Next(-1) = 0;
    end;
    //Codeunit 5804 dupliqué
    local procedure HasOpenEntries(var Item: Record Item): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentKey("Item No.", Open);
        ItemLedgEntry.SetRange("Item No.", Item."No.");
        ItemLedgEntry.SetRange(Open, true);
        ItemLedgEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ItemLedgEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        exit(not ItemLedgEntry.FindFirst())
    end;
    //Codeunit 5804 dupliqué
    procedure SetProperties(NewCalledFromAdjustment: Boolean)
    begin
        CalledFromAdjustment := NewCalledFromAdjustment;
    end;
}
