namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Journal;
tableextension 50016 ItemJournalLine extends "Item Journal Line" //83
{
    fields
    {
        modify("Derived from Blanket Order")
        {
            Caption = 'Derived from Blanket Order';
        }

        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Item No." <> xRec."Item No." Then BEGIN
          "Variant Code" := '';
          "Bin Code" := '';
          if CurrFieldNo <> 0 Then
            WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FieldCaption("Item No."));
          if ("Location Code" <> '') AND ("Item No." <> '') Then BEGIN
            GetLocation("Location Code");
            if Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" Then
              WMSManagement.GetDefaultBin("Item No.","Variant Code","Location Code","Bin Code")
          END;
          if ("Entry Type" = "Entry Type"::Transfer) AND ("Location Code" = "New Location Code") Then
            "New Bin Code" := "Bin Code";
        END;

        if "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] Then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if "Item No." = '' Then BEGIN
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");
          EXIT;
        END;

        GetItem;
        OnValidateItemNoOnAfterGetItem(Rec,Item);
        DisplayErrorIfItemIsBlocked(Item);
        ValidateTypeWithItemNo;

        if "Value Entry Type" = "Value Entry Type"::Revaluation Then
          Item.TESTFIELD("Inventory Value Zero",FALSE);
        Description := Item.Description;
        "Inventory Posting Group" := Item."Inventory Posting Group";
        "Item Category Code" := Item."Item Category Code";

        if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        Then BEGIN
          if "Item No." <> xRec."Item No." Then BEGIN
            TESTFIELD("Partial Revaluation",FALSE);
            RetrieveCosts;
            "Indirect Cost %" := 0;
            "Overhead Rate" := 0;
            "Inventory Value Per" := "Inventory Value Per"::" ";
            VALIDATE("Applies-to Entry",0);
            "Partial Revaluation" := FALSE;
          END;
        END else BEGIN
          "Indirect Cost %" := Item."Indirect Cost %";
          "Overhead Rate" := Item."Overhead Rate";
          if NOT "Phys. Inventory" OR (Item."Costing Method" = Item."Costing Method"::Standard) Then BEGIN
            RetrieveCosts;
            "Unit Cost" := UnitCost;
          END else
            UnitCost := "Unit Cost";
        END;

        if (("Entry Type" = "Entry Type"::Output) AND (WorkCenter."No." = '') AND (MachineCenter."No." = '')) OR
           ("Entry Type" <> "Entry Type"::Output) OR
           ("Value Entry Type" = "Value Entry Type"::Revaluation)
        Then
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";

        CASE "Entry Type" OF
          "Entry Type"::Purchase,
          "Entry Type"::Output,
          "Entry Type"::"Assembly Output":
            PurchPriceCalcMgt.FindItemJnlLinePrice(Rec,FieldNo("Item No."));
          "Entry Type"::"Positive Adjmt.",
          "Entry Type"::"Negative Adjmt.",
          "Entry Type"::Consumption,
          "Entry Type"::"Assembly Consumption":
            "Unit Amount" := UnitCost;
          "Entry Type"::Sale:
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,FieldNo("Item No."));
          "Entry Type"::Transfer:
            BEGIN
              "Unit Amount" := 0;
              "Unit Cost" := 0;
              Amount := 0;
            END;
        END;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            "Unit of Measure Code" := Item."Purch. Unit of Measure";
          "Entry Type"::Sale:
            "Unit of Measure Code" := Item."Sales Unit of Measure";
          "Entry Type"::Output:
            BEGIN
              Item.TESTFIELD("Inventory Value Zero",FALSE);
              ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderLine.SetRange("Item No.","Item No.");
              if ProdOrderLine.FINDFIRST Then BEGIN
                "Routing No." := ProdOrderLine."Routing No.";
                "Source Type" := "Source Type"::Item;
                "Source No." := ProdOrderLine."Item No.";
              END else
                if ("Value Entry Type" <> "Value Entry Type"::Revaluation) AND
                   (CurrFieldNo <> 0)
                Then
                  Error(Text031,"Item No.","Order No.");
              if ProdOrderLine.COUNT = 1 Then
                CopyFromProdOrderLine(ProdOrderLine)
              else
                "Unit of Measure Code" := Item."Base Unit of Measure";
            END;
          "Entry Type"::Consumption:
            BEGIN
              ProdOrderComp.SetFilterByReleasedOrderNo("Order No.");
              ProdOrderComp.SetRange("Item No.","Item No.");
              if ProdOrderComp.COUNT = 1 Then BEGIN
                ProdOrderComp.FINDFIRST;
                CopyFromProdOrderComp(ProdOrderComp);
              END else BEGIN
                "Unit of Measure Code" := Item."Base Unit of Measure";
                VALIDATE("Prod. Order Comp. Line No.",0);
              END;
            END;
          else
            "Unit of Measure Code" := Item."Base Unit of Measure";
        END;

        if "Value Entry Type" = "Value Entry Type"::Revaluation Then
          "Unit of Measure Code" := Item."Base Unit of Measure";
        VALIDATE("Unit of Measure Code");
        if "Variant Code" <> '' Then
          VALIDATE("Variant Code");

        OnAfterOnValidateItemNoAssignByEntryType(Rec,Item);

        CheckItemAvailable(FieldNo("Item No."));

        if ((NOT ("Order Type" IN ["Order Type"::Production,"Order Type"::Assembly])) OR ("Order No." = '')) AND NOT "Phys. Inventory"
        Then
          CreateDim(
            DATABASE::Item,"Item No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::"Work Center","Work Center No.");

        OnBeforeVerifyReservedQty(Rec,xRec,FieldNo("Item No."));
        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..27
        DisplayErrorIfItemIsBlocked;
        #29..143
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Entry Type" <= "Entry Type"::Transfer) AND (Quantity <> 0) Then
          TESTFIELD("Item No.");

        if NOT PhysInvtEntered Then
          TESTFIELD("Phys. Inventory",FALSE);

        CallWhseCheck :=
          ("Entry Type" = "Entry Type"::"Assembly Consumption") OR
          ("Entry Type" = "Entry Type"::Consumption) OR
          ("Entry Type" = "Entry Type"::Output) AND
          LastOutputOperation(Rec);
        if CallWhseCheck Then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if CurrFieldNo <> 0 Then
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FieldCaption(Quantity));

        "Quantity (Base)" := UOMMgt.CalcBaseQty(Quantity,"Qty. per Unit of Measure");
        if ("Entry Type" = "Entry Type"::Output) AND
           ("Value Entry Type" <> "Value Entry Type"::Revaluation)
        Then
          "Invoiced Quantity" := 0
        else
          "Invoiced Quantity" := Quantity;
        "Invoiced Qty. (Base)" := UOMMgt.CalcBaseQty("Invoiced Quantity","Qty. per Unit of Measure");

        OnValidateQuantityOnBeforeGetUnitAmount(Rec,xRec,CurrFieldNo);

        GetUnitAmount(FieldNo(Quantity));
        UpdateAmount;

        CheckItemAvailable(FieldNo(Quantity));

        if "Entry Type" = "Entry Type"::Transfer Then BEGIN
          "Qty. (Calculated)" := 0;
          "Qty. (Phys. Inventory)" := 0;
          "Last Item Ledger Entry No." := 0;
        END;

        CALCFIELDS("Reserved Qty. (Base)");
        if ABS("Quantity (Base)") < ABS("Reserved Qty. (Base)") Then
          Error(Text001,FieldCaption("Reserved Qty. (Base)"));

        if Item."Item Tracking Code" <> '' Then
          ReserveItemJnlLine.VerifyQuantity(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..17
        "Quantity (Base)" := CalcBaseQty(Quantity);
        #19..24
        "Invoiced Qty. (Base)" := CalcBaseQty("Invoiced Quantity");
        #26..45
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Entry"(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Applies-to Entry" <> 0 Then BEGIN
          ItemLedgEntry.Get("Applies-to Entry");

          if "Value Entry Type" = "Value Entry Type"::Revaluation Then BEGIN
            if "Inventory Value Per" <> "Inventory Value Per"::" " Then
              Error(Text006,FieldCaption("Applies-to Entry"));

            if "Inventory Value Per" = "Inventory Value Per"::" " Then
              if NOT RevaluationPerEntryAllowed("Item No.") Then
                Error(RevaluationPerEntryNotAllowedErr);

            InitRevalJnlLine(ItemLedgEntry);
            ItemLedgEntry.TESTFIELD(Positive,TRUE);
          END else BEGIN
            TESTFIELD(Quantity);
            if Signed(Quantity) * ItemLedgEntry.Quantity > 0 Then BEGIN
              if Quantity > 0 Then
                FIELDERROR(Quantity,Text030);
              if Quantity < 0 Then
                FIELDERROR(Quantity,Text029);
            END;
            if ItemLedgEntry.TrackingExists Then
              Error(Text033,FieldCaption("Applies-to Entry"),ItemTrackingLines.CAPTION);

            if NOT ItemLedgEntry.Open Then
              MESSAGE(Text032,"Applies-to Entry");

            if "Entry Type" = "Entry Type"::Output Then BEGIN
              ItemLedgEntry.TESTFIELD("Order Type","Order Type"::Production);
              ItemLedgEntry.TESTFIELD("Order No.","Order No.");
              ItemLedgEntry.TESTFIELD("Order Line No.","Order Line No.");
              ItemLedgEntry.TESTFIELD("Entry Type","Entry Type");
            END;
          END;

          "Location Code" := ItemLedgEntry."Location Code";
          "Variant Code" := ItemLedgEntry."Variant Code";
        END else
          if "Value Entry Type" = "Value Entry Type"::Revaluation Then BEGIN
            VALIDATE("Unit Amount",0);
            VALIDATE(Quantity,0);
            "Inventory Value (Calculated)" := 0;
            "Inventory Value (Revalued)" := 0;
            "Location Code" := '';
            "Variant Code" := '';
            "Bin Code" := '';
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
                Error(Text034);
        #11..47
        */
        //end;


        //Unsupported feature: Code Modification on ""Order No."(Field 91).OnValidate".

        //trigger "(Field 91)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Order Type" OF
          "Order Type"::Production,"Order Type"::Assembly:
            BEGIN
              if "Order No." = '' Then BEGIN
                CASE "Order Type" OF
                  "Order Type"::Production:
                    CreateProdDim;
                  "Order Type"::Assembly:
                    CreateAssemblyDim;
                END;
                EXIT;
              END;

              CASE "Order Type" OF
                "Order Type"::Production:
                  BEGIN
                    GetMfgSetup;
                    if MfgSetup."Doc. No. Is Prod. Order No." Then
                      "Document No." := "Order No.";
                    ProdOrder.Get(ProdOrder.Status::Released,"Order No.");
                    ProdOrder.TESTFIELD(Blocked,FALSE);
                    Description := ProdOrder.Description;
                    OnValidateOrderNoOrderTypeProduction(Rec,ProdOrder);
                  END;
                "Order Type"::Assembly:
                  BEGIN
                    AssemblyHeader.Get(AssemblyHeader."Document Type"::Order,"Order No.");
                    Description := AssemblyHeader.Description;
                  END;
              END;

              "Gen. Bus. Posting Group" := ProdOrder."Gen. Bus. Posting Group";
              CASE TRUE OF
                "Entry Type" = "Entry Type"::Output:
                  BEGIN
                    "Inventory Posting Group" := ProdOrder."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := ProdOrder."Gen. Prod. Posting Group";
                  END;
                "Entry Type" = "Entry Type"::"Assembly Output":
                  BEGIN
                    "Inventory Posting Group" := AssemblyHeader."Inventory Posting Group";
                    "Gen. Prod. Posting Group" := AssemblyHeader."Gen. Prod. Posting Group";
                  END;
                "Entry Type" = "Entry Type"::Consumption:
                  BEGIN
                    ProdOrderLine.SetFilterByReleasedOrderNo("Order No.");
                    if ProdOrderLine.COUNT = 1 Then BEGIN
                      ProdOrderLine.FINDFIRST;
                      VALIDATE("Order Line No.",ProdOrderLine."Line No.");
                    END;
                  END;
              END;

              if ("Order No." <> xRec."Order No.") OR ("Order Type" <> xRec."Order Type") Then
                CASE "Order Type" OF
                  "Order Type"::Production:
                    CreateProdDim;
                  "Order Type"::Assembly:
                    CreateAssemblyDim;
                END;
            END;
          "Order Type"::Transfer,"Order Type"::Service,"Order Type"::" ":
            Error(Text002,FieldCaption("Order No."),FieldCaption("Order Type"),"Order Type");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..22
        #24..64
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnBeforeValidateUnitOfMeasureCode(Rec,IsHandled);
        if IsHandled Then
          EXIT;

        GetItem;
        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

        if "Entry Type" IN ["Entry Type"::Consumption,"Entry Type"::Output] Then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        if CurrFieldNo <> 0 Then
          WMSManagement.CheckItemJnlLineFieldChange(Rec,xRec,FieldCaption("Unit of Measure Code"));

        GetUnitAmount(FieldNo("Unit of Measure Code"));
        if "Value Entry Type" = "Value Entry Type"::Revaluation Then
          TESTFIELD("Qty. per Unit of Measure",1);

        ReadGLSetup;
        IsHandled := FALSE;
        OnValidateUnitOfMeasureCodeOnBeforeCalcUnitCost(Rec,UnitCost,IsHandled);
        if NOT IsHandled Then
          "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");

        if "Entry Type" = "Entry Type"::Consumption Then BEGIN
          "Indirect Cost %" := ROUND(Item."Indirect Cost %" * "Qty. per Unit of Measure",1);
          "Overhead Rate" :=
            ROUND(Item."Overhead Rate" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          "Unit Amount" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        END;

        if "No." <> '' Then
          VALIDATE("Cap. Unit of Measure Code");

        VALIDATE("Unit Amount");

        if "Entry Type" = "Entry Type"::Output Then BEGIN
          VALIDATE("Output Quantity");
          VALIDATE("Scrap Quantity");
        END else
          VALIDATE(Quantity);

        CheckItemAvailable(FieldNo("Unit of Measure Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #5..18
        "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        #23..42
        */
        //end;


        //Unsupported feature: Code Modification on ""Output Quantity"(Field 5846).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        if SubcontractingWorkCenterUsed AND ("Output Quantity" <> 0) Then
          Error(SubcontractedErr,FieldCaption("Output Quantity"),"Line No.");

        ConfirmOutputOnFinishedOperation;

        if LastOutputOperation(Rec) Then
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        "Output Quantity (Base)" := UOMMgt.CalcBaseQty("Output Quantity","Qty. per Unit of Measure");

        VALIDATE(Quantity,"Output Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        "Output Quantity (Base)" := CalcBaseQty("Output Quantity");

        VALIDATE(Quantity,"Output Quantity");
        */
        //end;


        //Unsupported feature: Code Modification on ""Scrap Quantity"(Field 5847).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        "Scrap Quantity (Base)" := UOMMgt.CalcBaseQty("Scrap Quantity","Qty. per Unit of Measure");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        "Scrap Quantity (Base)" := CalcBaseQty("Scrap Quantity");
        */
        //end;


        //Unsupported feature: Code Modification on ""Cap. Unit of Measure Code"(Field 5858).OnValidate".

        //trigger  Unit of Measure Code"(Field 5858)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type <> Type::Resource Then BEGIN
          "Qty. per Cap. Unit of Measure" :=
            ROUND(
              CalendarMgt.QtyperTimeUnitofMeasure(
                "Work Center No.","Cap. Unit of Measure Code"),
              UOMMgt.QtyRndPrecision);

          VALIDATE("Setup Time");
          VALIDATE("Run Time");
          VALIDATE("Stop Time");
        END;

        if "Order No." <> '' Then
          CASE "Order Type" OF
            "Order Type"::Production:
              BEGIN
                GetProdOrderRtngLine(ProdOrderRtngLine);
                "Unit Cost" := ProdOrderRtngLine."Unit Cost per";

                CostCalcMgt.RoutingCostPerUnit(
                  Type,"No.","Unit Amount","Indirect Cost %","Overhead Rate","Unit Cost","Unit Cost Calculation");
              END;
            "Order Type"::Assembly:
              CostCalcMgt.ResourceCostPerUnit("No.","Unit Amount","Indirect Cost %","Overhead Rate","Unit Cost");
          END;

        ReadGLSetup;
        "Unit Cost" :=
          ROUND("Unit Cost" * "Qty. per Cap. Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        "Unit Amount" :=
          ROUND("Unit Amount" * "Qty. per Cap. Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        VALIDATE("Unit Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
              0.00001);
        #7..32
        */
        //end;


        //Unsupported feature: Code Modification on ""Scrap Code"(Field 5896).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsHandled := FALSE;
        OnBeforeValidateScrapCode(Rec,IsHandled);
        if IsHandled Then
          EXIT;

        TESTFIELD(Type,Type::"Machine Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type,Type::"Machine Center");
        */
        //end;
        field(50000; "Shelf No."; Code[10])
        {
            CalcFormula = lookup(Item."Shelf No." where(No.=field(Item No.)));
            Caption = 'Shelf No.';
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "CalcBaseTime(PROCEDURE 28)".

    //procedure CalcBaseTime();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Run Time" <> 0 Then
          TESTFIELD("Qty. per Cap. Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Cap. Unit of Measure",UOMMgt.TimeRndPrecision));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        if "Run Time" <> 0 Then
          TESTFIELD("Qty. per Cap. Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Cap. Unit of Measure",0.00001));
        */
    //end;


    //Unsupported feature: Code Modification on "SelectItemEntry(PROCEDURE 3)".

    //procedure SelectItemEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeSelectItemEntry(Rec,xRec,CurrentFieldNo);

        if ("Entry Type" = "Entry Type"::Output) AND
           ("Value Entry Type" <> "Value Entry Type"::Revaluation) AND
           (CurrentFieldNo = FieldNo("Applies-to Entry"))
        Then BEGIN
          ItemLedgEntry.SETCURRENTKEY(
            "Order Type","Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.");
          ItemLedgEntry.SetRange("Order Type","Order Type"::Production);
          ItemLedgEntry.SetRange("Order No.","Order No.");
          ItemLedgEntry.SetRange("Order Line No.","Order Line No.");
          ItemLedgEntry.SetRange("Entry Type","Entry Type");
          ItemLedgEntry.SetRange("Prod. Order Comp. Line No.",0);
        END else BEGIN
          ItemLedgEntry.SETCURRENTKEY("Item No.",Positive);
          ItemLedgEntry.SetRange("Item No.","Item No.");
        END;

        if "Location Code" <> '' Then
          ItemLedgEntry.SetRange("Location Code","Location Code");

        if CurrentFieldNo = FieldNo("Applies-to Entry") Then BEGIN
          ItemLedgEntry.SetRange(Positive,(Signed(Quantity) < 0) OR ("Value Entry Type" = "Value Entry Type"::Revaluation));
          if "Value Entry Type" <> "Value Entry Type"::Revaluation Then BEGIN
            ItemLedgEntry.SETCURRENTKEY("Item No.",Open);
            ItemLedgEntry.SetRange(Open,TRUE);
          END;
        END else
          ItemLedgEntry.SetRange(Positive,FALSE);

        OnSelectItemEntryOnBeforeOpenPage(ItemLedgEntry,Rec);

        if PAGE.RUNMODAL(PAGE::"Item Ledger Entries",ItemLedgEntry) = ACTION::LookupOK Then BEGIN
          ItemJnlLine2 := Rec;
          if CurrentFieldNo = FieldNo("Applies-to Entry") Then
            ItemJnlLine2.VALIDATE("Applies-to Entry",ItemLedgEntry."Entry No.")
          else
            ItemJnlLine2.VALIDATE("Applies-from Entry",ItemLedgEntry."Entry No.");
          CheckItemAvailable(CurrentFieldNo);
          Rec := ItemJnlLine2;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..30
        #33..41
        */
    //end;


    //Unsupported feature: Code Modification on "CheckItemAvailable(PROCEDURE 1)".

    //procedure CheckItemAvailable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if (CurrFieldNo = 0) OR (CurrFieldNo <> CalledByFieldNo) Then // Prevent two checks on quantity
          EXIT;

        IsHandled := FALSE;
        OnBeforeCheckItemAvailable(Rec,CalledByFieldNo,IsHandled);
        if IsHandled Then
          EXIT;

        if (CurrFieldNo <> 0) AND ("Item No." <> '') AND (Quantity <> 0) AND
           ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." = '')
        Then
          if ItemCheckAvail.ItemJnlCheckLine(Rec) Then
            ItemCheckAvail.RaiseUpdateInterruptedError;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        #9..13
        */
    //end;


    //Unsupported feature: Code Modification on "GetUnitAmount(PROCEDURE 6)".

    //procedure GetUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RetrieveCosts;
        if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        Then
          EXIT;

        OnBeforeGetUnitAmount(Rec,CalledByFieldNo,IsHandled);
        if IsHandled Then
          EXIT;

        UnitCostValue := UnitCost;
        if (CalledByFieldNo = FieldNo(Quantity)) AND
           (Item."No." <> '') AND (Item."Costing Method" <> Item."Costing Method"::Standard)
        Then
          UnitCostValue := "Unit Cost" / UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            PurchPriceCalcMgt.FindItemJnlLinePrice(Rec,CalledByFieldNo);
          "Entry Type"::Sale:
            SalesPriceCalcMgt.FindItemJnlLinePrice(Rec,CalledByFieldNo);
          "Entry Type"::"Positive Adjmt.":
            "Unit Amount" :=
              ROUND(
                ((UnitCostValue - "Overhead Rate") * "Qty. per Unit of Measure") / (1 + "Indirect Cost %" / 100),
                GLSetup."Unit-Amount Rounding Precision");
          "Entry Type"::"Negative Adjmt.":
            "Unit Amount" := UnitCostValue * "Qty. per Unit of Measure";
          "Entry Type"::Transfer:
            "Unit Amount" := 0;
        END;
        OnAfterGetUnitAmount(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        #11..31
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "CreateProdDim(PROCEDURE 25)".


    //Unsupported feature: Property Insertion (Local) on "CreateProdDim(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "CreateProdDim(PROCEDURE 25)".

    //procedure CreateProdDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" := 0;
        if ("Order Type" <> "Order Type"::Production) OR ("Order No." = '') Then
          EXIT;
        ProdOrder.Get(ProdOrder.Status::Released,"Order No.");
        i := 1;
        DimSetIDArr[i] := ProdOrder."Dimension Set ID";
        if "Order Line No." <> 0 Then BEGIN
          i := i + 1;
          ProdOrderLine.Get(ProdOrderLine.Status::Released,"Order No.","Order Line No.");
          DimSetIDArr[i] := ProdOrderLine."Dimension Set ID";
        END;
        if "Prod. Order Comp. Line No." <> 0 Then BEGIN
          i := i + 1;
          ProdOrderComp.Get(ProdOrderLine.Status::Released,"Order No.","Order Line No.","Prod. Order Comp. Line No.");
          DimSetIDArr[i] := ProdOrderComp."Dimension Set ID";
        END;

        OnCreateProdDimOnAfterCreateDimSetIDArr(Rec,DimSetIDArr,i);
        "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetIDArr,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetIDArr,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAssemblyDim(PROCEDURE 42)".

    //procedure CreateAssemblyDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" := 0;
        if ("Order Type" <> "Order Type"::Assembly) OR ("Order No." = '') Then
          EXIT;
        AssemblyHeader.Get(AssemblyHeader."Document Type"::Order,"Order No.");
        i := 1;
        DimSetIDArr[i] := AssemblyHeader."Dimension Set ID";
        if "Order Line No." <> 0 Then BEGIN
          i := i + 1;
          AssemblyLine.Get(AssemblyLine."Document Type"::Order,"Order No.","Order Line No.");
          DimSetIDArr[i] := AssemblyLine."Dimension Set ID";
        END;

        OnCreateAssemblyDimOnAfterCreateDimSetIDArr(Rec,DimSetIDArr,i);
        "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetIDArr,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
        "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetIDArr,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
    //end;


    //Unsupported feature: Code Modification on "ReadGLSetup(PROCEDURE 5801)".

    //procedure ReadGLSetup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if NOT GLSetupRead Then BEGIN
          GLSetup.Get;
          GLSetupRead := TRUE;
        END;

        OnAfterReadGLSetup(GLSetup);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ProdOrderRtngLine) (VariableCollection) on "ItemPosting(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "ItemPosting(PROCEDURE 33)".

    //procedure ItemPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if ("Entry Type" = "Entry Type"::Output) AND ("Output Quantity" <> 0) AND ("Operation No." <> '') Then BEGIN
          ProdOrderRoutingLine.Get(
            ProdOrderRoutingLine.Status::Released,"Order No.","Routing Reference No.","Routing No.","Operation No.");
          IsHandled := FALSE;
          OnAfterItemPosting(ProdOrderRoutingLine,NextOperationNoIsEmpty,IsHandled);
          if IsHandled Then
            EXIT(NextOperationNoIsEmpty);
          EXIT(ProdOrderRoutingLine."Next Operation No." = '');
        END;

        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        if ("Entry Type" = "Entry Type"::Output) AND
           ("Output Quantity" <> 0) AND
           ("Operation No." <> '')
        Then BEGIN
          ProdOrderRtngLine.Get(
            ProdOrderRtngLine.Status::Released,
            "Order No.",
            "Routing Reference No.",
            "Routing No.",
            "Operation No.");
          EXIT(ProdOrderRtngLine."Next Operation No." = '');
        END;
        EXIT(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "LookupItemNo(PROCEDURE 37)".

    //procedure LookupItemNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeLookupItemNo(Rec,IsHandled);
        if IsHandled Then
          EXIT;

        CASE "Entry Type" OF
          "Entry Type"::Consumption:
            LookupProdOrderComp;
          "Entry Type"::Output:
            LookupProdOrderLine;
          else BEGIN
            ItemList.LOOKUPMODE := TRUE;
            if ItemList.RUNMODAL = ACTION::LookupOK Then BEGIN
              ItemList.GETRECORD(Item);
              VALIDATE("Item No.",Item."No.");
            END;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #6..18
        */
    //end;


    //Unsupported feature: Code Modification on "RecalculateUnitAmount(PROCEDURE 38)".

    //procedure RecalculateUnitAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetItem;

        if ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
           ("Item Charge No." <> '')
        Then BEGIN
          "Indirect Cost %" := 0;
          "Overhead Rate" := 0;
        END else BEGIN
          "Indirect Cost %" := Item."Indirect Cost %";
          "Overhead Rate" := Item."Overhead Rate";
        END;

        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        GetUnitAmount(FieldNo("Unit of Measure Code"));

        ReadGLSetup;

        UpdateAmount;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            BEGIN
              ItemJnlLine1.COPY(Rec);
              PurchPriceCalcMgt.FindItemJnlLinePrice(ItemJnlLine1,FieldNo("Unit of Measure Code"));
              "Unit Cost" := ROUND(ItemJnlLine1."Unit Amount" * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
            END;
          "Entry Type"::Sale:
            "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
          "Entry Type"::"Positive Adjmt.":
            "Unit Cost" :=
              ROUND(
                "Unit Amount" * (1 + "Indirect Cost %" / 100),GLSetup."Unit-Amount Rounding Precision") +
              "Overhead Rate" * "Qty. per Unit of Measure";
          "Entry Type"::"Negative Adjmt.":
            if NOT "Phys. Inventory" Then
              "Unit Cost" := UnitCost * "Qty. per Unit of Measure";
        END;

        if "Entry Type" IN ["Entry Type"::Purchase,"Entry Type"::"Positive Adjmt."] Then BEGIN
          if Item."Costing Method" = Item."Costing Method"::Standard Then
            "Unit Cost" := ROUND(UnitCost * "Qty. per Unit of Measure",GLSetup."Unit-Amount Rounding Precision");
        END;

        OnAfterRecalculateUnitAmount(Rec,xRec,CurrFieldNo);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..42
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "DisplayErrorIfItemIsBlocked(PROCEDURE 83)".


    //Unsupported feature: Property Insertion (Local) on "DisplayErrorIfItemIsBlocked(PROCEDURE 83)".



    //Unsupported feature: Code Modification on "DisplayErrorIfItemIsBlocked(PROCEDURE 83)".

    //procedure DisplayErrorIfItemIsBlocked();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeDisplayErrorIfItemIsBlocked(Item,Rec,IsHandled);
        if IsHandled Then
          EXIT;

        if Item.Blocked Then
          Error(BlockedErr);

        if "Item Charge No." <> '' Then
          EXIT;

        CASE "Entry Type" OF
          "Entry Type"::Purchase:
            if Item."Purchasing Blocked" AND
               NOT ("Document Type" IN ["Document Type"::"Purchase Return Shipment","Document Type"::"Purchase Credit Memo"])
            Then
              Error(PurchasingBlockedErr);
          "Entry Type"::Sale:
            if Item."Sales Blocked" AND
               NOT ("Document Type" IN ["Document Type"::"Sales Return Receipt","Document Type"::"Sales Credit Memo"])
            Then
              Error(SalesBlockedErr);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #6..8
        if "Entry Type" = "Entry Type"::Purchase Then
          if Item."Purchasing Blocked" Then
            Error(PurchasingBlockedErr);
        if "Entry Type" = "Entry Type"::Sale Then
          if Item."Sales Blocked" Then
            Error(SalesBlockedErr);
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "CalcBaseQty(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Name) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14)".

    //procedure OnCreateProdDimOnAfterCreateDimSetIDArr();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CheckItemAvailable(PROCEDURE 1).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetUnitAmount(PROCEDURE 6).IsHandled(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ItemPosting(PROCEDURE 33).ProdOrderRoutingLine(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ItemPosting(PROCEDURE 33).NextOperationNoIsEmpty(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ItemPosting(PROCEDURE 33).IsHandled(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "LookupItemNo(PROCEDURE 37).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "DisplayErrorIfItemIsBlocked(PROCEDURE 83).Item(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "DisplayErrorIfItemIsBlocked(PROCEDURE 83).IsHandled(Variable 1001)".


    //Unsupported feature: Property Deletion (AsVar) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).ItemJournalLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).ItemJournalLine(Parameter 1000)".


    //Unsupported feature: Property Deletion (Subtype) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).ItemJournalLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).ItemJournalLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).DimSetIDArr(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnCreateProdDimOnAfterCreateDimSetIDArr(PROCEDURE 14).i(Parameter 1001)".


    var
        Text034: Label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
}

