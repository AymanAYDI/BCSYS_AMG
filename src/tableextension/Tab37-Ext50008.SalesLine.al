namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
tableextension 50008 SalesLine extends "Sales Line" //37 //TODO: To merge
{
    fields
    {

        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesSetup;
        IF SalesSetup."Create Item from Item No." THEN
          "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestJobPlanningLine;
        TestStatusOpen;
        CheckItemAvailable(FIELDNO("No."));

        IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
          TESTFIELD("Qty. to Asm. to Order (Base)",0);
          CALCFIELDS("Reserved Qty. (Base)");
          TESTFIELD("Reserved Qty. (Base)",0);
          IF Type = Type::Item THEN
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          OnValidateNoOnAfterVerifyChange(Rec,xRec);
        END;

        TESTFIELD("Qty. Shipped Not Invoiced",0);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');

        TESTFIELD("Prepmt. Amt. Inv.",0);

        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
        TESTFIELD("Return Qty. Received",0);
        TESTFIELD("Return Receipt No.",'');

        IF "No." = '' THEN
          ATOLink.DeleteAsmFromSalesLine(Rec);
        CheckAssocPurchOrder(FIELDCAPTION("No."));
        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
        TempSalesLine := Rec;
        INIT;
        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;
        Type := TempSalesLine.Type;
        "No." := TempSalesLine."No.";
        OnValidateNoOnCopyFromTempSalesLine(Rec,TempSalesLine);
        IF "No." = '' THEN
          EXIT;

        IF HasTypeToFillMandatoryFields THEN
          Quantity := TempSalesLine.Quantity;

        "System-Created Entry" := TempSalesLine."System-Created Entry";
        GetSalesHeader;
        InitHeaderDefaults(SalesHeader);
        CALCFIELDS("Substitution Available");

        "Promised Delivery Date" := SalesHeader."Promised Delivery Date";
        "Requested Delivery Date" := SalesHeader."Requested Delivery Date";
        "Shipment Date" :=
          CalendarMgmt.CalcDateBOC(
            '',SalesHeader."Shipment Date",CalChange."Source Type"::Location,"Location Code",'',
            CalChange."Source Type"::"Shipping Agent","Shipping Agent Code","Shipping Agent Service Code",FALSE);

        OnValidateNoOnBeforeUpdateDates(Rec,xRec,SalesHeader,CurrFieldNo);
        UpdateDates;

        OnAfterAssignHeaderValues(Rec,SalesHeader);

        CASE Type OF
          Type::" ":
            CopyFromStandardText;
          Type::"G/L Account":
            CopyFromGLAccount;
          Type::Item:
            CopyFromItem;
          Type::Resource:
            CopyFromResource;
          Type::"Fixed Asset":
            CopyFromFixedAsset;
          Type::"Charge (Item)":
            CopyFromItemCharge;
        END;

        OnAfterAssignFieldsForNo(Rec,xRec,SalesHeader);

        IF HasTypeToFillMandatoryFields AND (Type <> Type::"Fixed Asset") THEN
          VALIDATE("VAT Prod. Posting Group");

        UpdatePrepmtSetupFields;

        IF HasTypeToFillMandatoryFields THEN BEGIN
          VALIDATE("Unit of Measure Code");
          IF Quantity <> 0 THEN BEGIN
            InitOutstanding;
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              InitQtyToReceive
            ELSE
              InitQtyToShip;
            InitQtyToAsm;
            UpdateWithWarehouseShip;
          END;
          UpdateUnitPrice(FIELDNO("No."));
        END;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        IF "No." <> xRec."No." THEN BEGIN
          IF Type = Type::Item THEN
            IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
              ReserveSalesLine.VerifyChange(Rec,xRec);
              WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            END;
          GetDefaultBin;
          AutoAsmToOrder;
          DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          IF Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        END;

        UpdateItemCrossRef;

        PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..122

        //DELPHI AUB AMG.CARBO 01.03.2021
        LCodItemNo := '';
        LDecQty := 0;
        IF LRecItem.GET("No.") THEN BEGIN
          IF LRecItem."Type carbo" THEN BEGIN
            LTextParam := REPORT.RUNREQUESTPAGE(50030); //récupération des valeurs saisies sur la RequestPage
            //MESSAGE(LTextParam);
            IF (LTextParam <> '') THEN
              BEGIN

                XMLBufferWriter.InitializeXMLBufferFromText(XMLBuffer,LTextParam);
                XMLBuffer.SETFILTER(Path,'/ReportParameters/Options/Field/@name');
                XMLBuffer.SETRANGE(Value,'ItemNo'); //on récupère le code article de l'emballage carbo
                IF XMLBuffer.FINDLAST THEN
                  IF XMLSpecialInterestNode.GET(XMLBuffer."Parent Entry No.") THEN
                    LCodItemNo := XMLSpecialInterestNode.Value;
                 { ELSE
                    ERROR(NodeNotFoundErr);
                    }

                //On récupère la quantité
                XMLBuffer.SETRANGE(Value,'GDecQty');
                IF XMLBuffer.FINDLAST THEN
                  IF XMLSpecialInterestNode.GET(XMLBuffer."Parent Entry No.") THEN
                    EVALUATE(LDecQty,XMLSpecialInterestNode.Value);

                XMLBuffer.DELETEALL;
                //Insertion de la ligne emballage carbo
                IF (LCodItemNo <> '') AND (LDecQty >0) THEN
                  FAddLinesForCarbo(SalesHeader,LCodItemNo,LDecQty)
               END;
          END;
        END;
        //END DELPHI AUB 01.03.2021
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;

        CheckAssocPurchOrder(FIELDCAPTION(Quantity));

        IF "Shipment No." <> '' THEN
          CheckShipmentRelation
        ELSE
          IF "Return Receipt No." <> '' THEN
            CheckRetRcptRelation;

        "Quantity (Base)" := CalcBaseQty(Quantity);

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          IF (Quantity * "Return Qty. Received" < 0) OR
             ((ABS(Quantity) < ABS("Return Qty. Received")) AND ("Return Receipt No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received")));
          IF ("Quantity (Base)" * "Return Qty. Received (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Return Qty. Received (Base)")) AND ("Return Receipt No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received (Base)")));
        END ELSE BEGIN
          IF (Quantity * "Quantity Shipped" < 0) OR
             ((ABS(Quantity) < ABS("Quantity Shipped")) AND ("Shipment No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Quantity Shipped")));
          IF ("Quantity (Base)" * "Qty. Shipped (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Qty. Shipped (Base)")) AND ("Shipment No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Qty. Shipped (Base)")));
        END;

        IF (Type = Type::"Charge (Item)") AND (CurrFieldNo <> 0) THEN BEGIN
          IF (Quantity = 0) AND ("Qty. to Assign" <> 0) THEN
            FIELDERROR("Qty. to Assign",STRSUBSTNO(Text009,FIELDCAPTION(Quantity),Quantity));
          IF (Quantity * "Qty. Assigned" < 0) OR (ABS(Quantity) < ABS("Qty. Assigned")) THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Qty. Assigned")));
        END;

        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
          InitOutstanding;
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
            InitQtyToReceive
          ELSE
            InitQtyToShip;
          InitQtyToAsm;
          SetDefaultQuantity;
        END;

        CheckItemAvailable(FIELDNO(Quantity));

        IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
          InitItemAppl(FALSE);

        IF Type = Type::Item THEN BEGIN
          UpdateUnitPrice(FIELDNO(Quantity));
          IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
            OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO(Quantity));
            ReserveSalesLine.VerifyQuantity(Rec,xRec);
            IF NOT "Drop Shipment" THEN
              UpdateWithWarehouseShip;
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            IF ("Quantity (Base)" * xRec."Quantity (Base)" <= 0) AND ("No." <> '') THEN BEGIN
              GetItem(Item);
              IF (Item."Costing Method" = Item."Costing Method"::Standard) AND NOT IsShipment THEN
                GetUnitCost;
            END;
          END;
          VALIDATE("Qty. to Assemble to Order");
          IF (Quantity = "Quantity Invoiced") AND (CurrFieldNo <> 0) THEN
            CheckItemChargeAssgnt;
          CheckApplFromItemLedgEntry(ItemLedgEntry);
        END ELSE
          VALIDATE("Line Discount %");

        IF (xRec.Quantity <> Quantity) AND (Quantity = 0) AND
           ((Amount <> 0) OR ("Amount Including VAT" <> 0) OR ("VAT Base Amount" <> 0))
        THEN BEGIN
          Amount := 0;
          "Amount Including VAT" := 0;
          "VAT Base Amount" := 0;
        END;

        UpdatePrePaymentAmounts;

        CheckWMS;

        UpdatePlanned;
        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO(Quantity));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..92

        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        FCalculeMarge();
        FCalculeMarque();
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        FCalculeMarge();
        FCalculeMarque();
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) AND
           ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")
        THEN
          CheckAssocPurchOrder(FIELDCAPTION("Unit Cost (LCY)"));

        IF (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) AND
           (Type = Type::Item) AND ("No." <> '') AND ("Quantity (Base)" <> 0)
        THEN BEGIN
          TestJobPlanningLine;
          GetItem(Item);
          IF (Item."Costing Method" = Item."Costing Method"::Standard) AND NOT IsShipment THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              ERROR(
                Text037,
                FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),
                Item."Costing Method",FIELDCAPTION(Quantity));
            ERROR(
              Text038,
              FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),
              Item."Costing Method",FIELDCAPTION(Quantity));
          END;
        END;

        GetSalesHeader;
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
          Currency.TESTFIELD("Unit-Amount Rounding Precision");
          "Unit Cost" :=
            ROUND(
              CurrExchRate.ExchangeAmtLCYToFCY(
                GetDate,SalesHeader."Currency Code",
                "Unit Cost (LCY)",SalesHeader."Currency Factor"),
              Currency."Unit-Amount Rounding Precision")
        END ELSE
          "Unit Cost" := "Unit Cost (LCY)";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..33
          "Unit Cost" := "Unit Cost (LCY)"
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount %"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateLineDiscountPercent(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        FCalculateMargeOnLineDiscountChange();
        ValidateLineDiscountPercent(TRUE);
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        FCalculeMarge();
        FCalculeMarque();
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          UpdateLineDiscPct;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        FCalculeMarge();
        FCalculeMarque();
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Qty. Shipped (Base)",0);
        TESTFIELD("Return Qty. Received",0);
        TESTFIELD("Return Qty. Received (Base)",0);
        IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
          TESTFIELD("Shipment No.",'');
          TESTFIELD("Return Receipt No.",'');
        END;

        CheckAssocPurchOrder(FIELDCAPTION("Unit of Measure Code"));

        IF "Unit of Measure Code" = '' THEN
          "Unit of Measure" := ''
        ELSE BEGIN
          IF NOT UnitOfMeasure.GET("Unit of Measure Code") THEN
            UnitOfMeasure.INIT;
          "Unit of Measure" := UnitOfMeasure.Description;
          GetSalesHeader;
          IF SalesHeader."Language Code" <> '' THEN BEGIN
            UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
            UnitOfMeasureTranslation.SETRANGE("Language Code",SalesHeader."Language Code");
            IF UnitOfMeasureTranslation.FINDFIRST THEN
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          END ELSE
            IF IdentityManagement.IsInvAppId THEN
              "Unit of Measure" := UnitOfMeasure.GetDescriptionInCurrentLanguage;
        END;
        DistIntegration.EnterSalesItemCrossRef(Rec);
        CASE Type OF
          Type::Item:
            BEGIN
              GetItem(Item);
              GetUnitCost;
              UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
              CheckItemAvailable(FIELDNO("Unit of Measure Code"));
              "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
              "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
              "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
              "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
              OnAfterAssignItemUOM(Rec,Item);
              IF (xRec."Unit of Measure Code" <> "Unit of Measure Code") AND (Quantity <> 0) THEN
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              IF "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" THEN
                InitItemAppl(FALSE);
            END;
          Type::Resource:
            BEGIN
              IF "Unit of Measure Code" = '' THEN BEGIN
                GetResource;
                "Unit of Measure Code" := Resource."Base Unit of Measure";
              END;
              ResUnitofMeasure.GET("No.","Unit of Measure Code");
              "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
              OnAfterAssignResourceUOM(Rec,Resource,ResUnitofMeasure);
              UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
              FindResUnitCost;
            END;
          Type::"G/L Account",Type::"Fixed Asset",
          Type::"Charge (Item)",Type::" ":
            "Qty. per Unit of Measure" := 1;
        END;
        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..64

        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        FCalculeMarge();
        FCalculeMarque();
        */
        //end;
        field(50001; Marge; Decimal)
        {
            Caption = 'Marge';
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
            Caption = 'Vendor';
            FieldClass = FlowField;
        }
        field(50020; "Nom Client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Caption = 'Customer Name';
            FieldClass = FlowField;
        }
        field(50030; Sel; Boolean)
        {
            Caption = 'Sel';
            DataClassification = ToBeClassified;
            Description = 'AMG';
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      ReserveSalesLine.DeleteLine(Rec);
      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
      IF "Shipment No." = '' THEN
        TESTFIELD("Qty. Shipped Not Invoiced",0);
      IF "Return Receipt No." = '' THEN
        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
      WhseValidateSourceLine.SalesLineDelete(Rec);
    END;

    IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    CleanDropShipmentFields;
    CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
    CatalogItemMgt.DelNonStockSales(Rec);

    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      SalesLine2.SETRANGE("Blanket Order No.","Document No.");
      SalesLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF SalesLine2.FINDFIRST THEN
        SalesLine2.TESTFIELD("Blanket Order Line No.",0);
    END;

    IF Type = Type::Item THEN BEGIN
      ATOLink.DeleteAsmFromSalesLine(Rec);
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
    END;

    IF Type = Type::"Charge (Item)" THEN
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    CapableToPromise.RemoveReqLines("Document No.","Line No.",0,FALSE);

    IF "Line No." <> 0 THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","Document No.");
      SalesLine2.SETRANGE("Attached to Line No.","Line No.");
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      SalesLine2.DELETEALL(TRUE);
    END;

    IF "Job Contract Entry No." <> 0 THEN
      JobCreateInvoice.DeleteSalesLine(Rec);

    SalesCommentLine.SETRANGE("Document Type","Document Type");
    SalesCommentLine.SETRANGE("No.","Document No.");
    SalesCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT SalesCommentLine.ISEMPTY THEN
      SalesCommentLine.DELETEALL;

    // In case we have roundings on VAT or Sales Tax, we should update some other line
    IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND ("Job Contract Entry No." = 0 ) AND
       (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
    THEN
      VALIDATE(Quantity,0);

    IF "Deferral Code" <> '' THEN
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetSalesDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    //DELPHI AUB 26.09.2019 add condition
    IF SalesHeader."Bill-to Customer No." = Rec."Bill-to Customer No." THEN
      CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
    //END DELPHI AUB
    #19..58
    //DELPHI AUB 26.09.2019
    {IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND ("Job Contract Entry No." = 0 ) AND
       (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
    THEN
      VALIDATE(Quantity,0);}
    IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND ("Job Contract Entry No." = 0 ) AND
       (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
    THEN BEGIN
      IF SalesHeader."Bill-to Customer No." = Rec."Bill-to Customer No." THEN
        VALIDATE(Quantity,0);
    END;

    //END DELPHI AUB
    #63..67
    */
    //end;


    //Unsupported feature: Code Modification on "GetItem(PROCEDURE 9)".

    //procedure GetItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("No.");
    Item.GET("No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("No.");
    //DELPHI AUB AMG.No2
    //Item.GET("No.");//standard
    IF "No." <> Item."No." THEN
      Item.GET("No.");
    */
    //end;


    //Unsupported feature: Code Modification on "CheckAssocPurchOrder(PROCEDURE 51)".

    //procedure CheckAssocPurchOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeCheckAssocPurchOrder(Rec,TheFieldCaption,IsHandled);
    IF IsHandled THEN
      EXIT;

    IF TheFieldCaption = '' THEN BEGIN // If sales line is being deleted
      IF "Purch. Order Line No." <> 0 THEN
        ERROR(Text000,"Purchase Order No.","Purch. Order Line No.");
      IF "Special Order Purch. Line No." <> 0 THEN
        CheckPurchOrderLineDeleted("Special Order Purchase No.","Special Order Purch. Line No.");
    END ELSE BEGIN
      IF "Purch. Order Line No." <> 0 THEN
        ERROR(Text002,TheFieldCaption,"Purchase Order No.","Purch. Order Line No.");

      IF "Special Order Purch. Line No." <> 0 THEN
        ERROR(Text002,TheFieldCaption,"Special Order Purchase No.","Special Order Purch. Line No.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..17
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Item) (VariableCollection) on "ValidateCrossReferenceNo(PROCEDURE 211)".



    //Unsupported feature: Code Modification on "ValidateCrossReferenceNo(PROCEDURE 211)".

    //procedure ValidateCrossReferenceNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReturnedItemCrossReference.INIT;
    IF "Item Reference No." <> '' THEN BEGIN
      IF SearchItem THEN
        DistIntegration.ICRLookupSalesItem(Rec,ReturnedItemCrossReference,CurrFieldNo <> 0)
      ELSE
        ReturnedItemCrossReference := ItemCrossReference;

      OnBeforeCrossReferenceNoAssign(Rec,ReturnedItemCrossReference);

      IF "No." <> ReturnedItemCrossReference."Item No." THEN
        VALIDATE("No.",ReturnedItemCrossReference."Item No.");
      IF ReturnedItemCrossReference."Variant Code" <> '' THEN
        VALIDATE("Variant Code",ReturnedItemCrossReference."Variant Code");

      IF ReturnedItemCrossReference."Unit of Measure" <> '' THEN
        VALIDATE("Unit of Measure Code",ReturnedItemCrossReference."Unit of Measure");
    END;

    "Unit of Measure (Cross Ref.)" := ReturnedItemCrossReference."Unit of Measure";
    "Cross-Reference Type" := ReturnedItemCrossReference."Cross-Reference Type";
    "Cross-Reference Type No." := ReturnedItemCrossReference."Cross-Reference Type No.";
    "Item Reference No." := ReturnedItemCrossReference."Item Reference No.";

    IF (ReturnedItemCrossReference.Description <> '') OR (ReturnedItemCrossReference."Description 2" <> '') THEN BEGIN
      Description := ReturnedItemCrossReference.Description;
      "Description 2" := ReturnedItemCrossReference."Description 2";
    END;

    UpdateUnitPrice(FIELDNO("Item Reference No."));
    UpdateICPartner;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
      //DEB DELPHI XAV
      GetItem(Item);
      IF ReturnedItemCrossReference."Description 2" = '' THEN
        "Description 2" := Item."Description 2";
      //DEB DELPHI XAV
    #27..30
    */
    //end;

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

    // var
    //     LRecItem: Record 27;
    //     LTextParam: Text;
    //     XMLBufferWriter: Codeunit "1235";
    //     XMLBuffer: Record "1235";
    //     XMLSpecialInterestNode: Record "1235";
    //     NodeNotFoundErr: Text;
    //     LCodItemNo: Code[20];
    //     LDecQty: Decimal;
}

