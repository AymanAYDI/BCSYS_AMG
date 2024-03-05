namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Requisition;
tableextension 50022 RequisitionLine extends "Requisition Line" //246
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(G/L Account)) "G/L Account"
                            else if (Type=CONST(Item)) Item WHERE (Type=CONST(Inventory));
        }

        //Unsupported feature: Code Modification on ""Location Code"(Field 17).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateLocationChange;
        CheckActionMessageNew;
        "Bin Code" := '';
        ReserveReqLine.VerifyChange(Rec,xRec);

        if Type = Type::Item Then BEGIN
          UpdateReplenishmentSystem;
          if "Location Code" <> xRec."Location Code" Then
            if ("Location Code" <> '') AND ("No." <> '') AND NOT IsDropShipment Then BEGIN
              GetLocation("Location Code");
              ShouldGetDefaultBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
              OnValidateLocationCodeOnBeforeGetDefaultBin(Rec,ShouldGetDefaultBin);
              if ShouldGetDefaultBin Then
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            END;
          if ItemVend.Get("Vendor No.","No.","Variant Code") Then
            "Vendor Item No." := ItemVend."Vendor Item No.";
        END;
        GetDirectCost(FieldNo("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
              if Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" Then
        #14..19
        */
        //end;


        //Unsupported feature: Code Modification on ""Variant Code"(Field 5402).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Variant Code" <> '' Then
          TESTFIELD(Type,Type::Item);
        CheckActionMessageNew;
        ReserveReqLine.VerifyChange(Rec,xRec);

        CALCFIELDS("Reserved Qty. (Base)");
        TESTFIELD("Reserved Qty. (Base)",0);

        GetDirectCost(FieldNo("Variant Code"));
        if "Variant Code" <> '' Then BEGIN
          UpdateDescription;
          UpdateReplenishmentSystem;
          if "Variant Code" <> xRec."Variant Code" Then BEGIN
            "Bin Code" := '';
            if ("Location Code" <> '') AND ("No." <> '') Then BEGIN
              GetLocation("Location Code");
              ShouldGetDefaultBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
              OnBeforeGetDefaultBin(Rec,ShouldGetDefaultBin);
              if ShouldGetDefaultBin Then
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
            END;
          END;
          if ItemVend.Get("Vendor No.","No.","Variant Code") Then
            "Vendor Item No." := ItemVend."Vendor Item No.";
        END else
          VALIDATE("No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..16
              if Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" Then
                WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
        #21..26
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckActionMessageNew;
        if (Type = Type::Item) AND
           ("No." <> '') AND
           ("Prod. Order No." = '')
        Then BEGIN
          GetItem;
          "Unit Cost" := Item."Unit Cost";
          "Overhead Rate" := Item."Overhead Rate";
          "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
          if "Unit of Measure Code" <> '' Then BEGIN
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Unit Cost" := ROUND(Item."Unit Cost" * "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
          END else
            "Qty. per Unit of Measure" := 1;
        END else
          if "Prod. Order No." = '' Then
            "Qty. per Unit of Measure" := 1
          else
            "Qty. per Unit of Measure" := 0;
        GetDirectCost(FieldNo("Unit of Measure Code"));

        if "Planning Line Origin" = "Planning Line Origin"::"Order Planning" Then
          SetSupplyQty("Demand Quantity (Base)","Needed Quantity (Base)")
        else
          VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
            "Unit Cost" := ROUND(Item."Unit Cost" * "Qty. per Unit of Measure",0.00001);
        #13..25
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Custom Sorting Order"(Field 7110)".

        field(50000; "Nom du client"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where(No.=field(Sell-to Customer No.)));
            Caption = 'Nom du client';
            FieldClass = FlowField;
        }
        field(50010;"Nom du fournisseur";Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE (No.=FIELD(Vendor No.)));
            Caption = 'Nom du fournisseur';
            FieldClass = FlowField;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Worksheet Template Name,Journal Batch Name,Custom Sorting Order"(Key)".

    }


    //Unsupported feature: Code Modification on "CalcBaseQty(PROCEDURE 14)".

    //procedure CalcBaseQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Prod. Order No." = '' Then
          TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        if "Prod. Order No." = '' Then
          TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateOrderReceiptDate(PROCEDURE 5)".

    //procedure UpdateOrderReceiptDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeUpdateOrderReceiptDate(Rec,LeadTimeCalc,IsHandled);
        if IsHandled Then
          EXIT;

        CALCFIELDS("Reserved Qty. (Base)");
        if "Reserved Qty. (Base)" = 0 Then BEGIN
          if "Order Date" <> 0D Then
            "Starting Date" := "Order Date"
          else BEGIN
            "Starting Date" := WORKDATE;
            "Order Date" := "Starting Date";
          END;
          CalcEndingDate(FORMAT(LeadTimeCalc));
          CheckEndingDate(ValidateFields);
          SetDueDate;
        END else
          if (FORMAT(LeadTimeCalc) = '') OR ("Due Date" = 0D) Then
            "Order Date" := 0D
          else
            if "Due Date" <> 0D Then BEGIN
              "Ending Date" :=
                LeadTimeMgt.PlannedEndingDate(
                  "No.","Location Code","Variant Code","Due Date",'',"Ref. Order Type");
              CalcStartingDate(FORMAT(LeadTimeCalc));
            END;

        SetActionMessage;
        UpdateDatetime;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #5..28
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateDescription(PROCEDURE 8)".

    //procedure UpdateDescription();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeUpdateDescription(Rec,CurrFieldNo,IsHandled);
        if IsHandled Then
          EXIT;
        if (Type <> Type::Item) OR ("No." = '') Then
          EXIT;
        if "Variant Code" = '' Then BEGIN
          GetItem;
          Description := Item.Description;
          "Description 2" := Item."Description 2";
          OnUpdateDescriptionFromItem(Rec,Item);
        END else BEGIN
          ItemVariant.Get("No.","Variant Code");
          Description := ItemVariant.Description;
          "Description 2" := ItemVariant."Description 2";
          OnUpdateDescriptionFromItemVariant(Rec,ItemVariant);
        END;

        if SalesLine.Get(SalesLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.") Then BEGIN
          Description := SalesLine.Description;
          "Description 2" := SalesLine."Description 2";
          OnUpdateDescriptionFromSalesLine(Rec,SalesLine);
        END;

        if "Vendor No." <> '' Then
          if NOT ItemCrossRef.GetItemDescription(
               Description,"Description 2","No.","Variant Code","Unit of Measure Code",
               ItemCrossRef."Cross-Reference Type"::Vendor,"Vendor No.")
          Then BEGIN
            Vend.Get("Vendor No.");
            if Vend."Language Code" <> '' Then
              if ItemTranslation.Get("No.","Variant Code",Vend."Language Code") Then BEGIN
                Description := ItemTranslation.Description;
                "Description 2" := ItemTranslation."Description 2";
                OnUpdateDescriptionFromItemTranslation(Rec,ItemTranslation);
              END;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #4..9
        #11..14
        #16..20
        #22..33
              END;
          END;
        */
    //end;


    //Unsupported feature: Code Modification on "TransferFromUnplannedDemand(PROCEDURE 46)".

    //procedure TransferFromUnplannedDemand();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        INIT;
        "Journal Batch Name" := GetJnlBatchNameForOrderPlanning;
        "Line No." := "Line No." + 10000;
        "Planning Line Origin" := "Planning Line Origin"::"Order Planning";

        Type := Type::Item;
        "No." := UnplannedDemand."Item No.";
        "Location Code" := UnplannedDemand."Location Code";
        "Bin Code" := UnplannedDemand."Bin Code";
        VALIDATE("No.");
        VALIDATE("Variant Code",UnplannedDemand."Variant Code");
        UpdateDescription;
        "Unit Of Measure Code (Demand)" := UnplannedDemand."Unit of Measure Code";
        "Qty. per UOM (Demand)" := UnplannedDemand."Qty. per Unit of Measure";
        Reserve := UnplannedDemand.Reserve;

        CASE UnplannedDemand."Demand Type" OF
          UnplannedDemand."Demand Type"::Sales:
            "Demand Type" := DATABASE::"Sales Line";
          UnplannedDemand."Demand Type"::Production:
            "Demand Type" := DATABASE::"Prod. Order Component";
          UnplannedDemand."Demand Type"::Service:
            "Demand Type" := DATABASE::"Service Line";
          UnplannedDemand."Demand Type"::Job:
            "Demand Type" := DATABASE::"Job Planning Line";
          UnplannedDemand."Demand Type"::Assembly:
            "Demand Type" := DATABASE::"Assembly Line";
        END;
        "Demand Subtype" := UnplannedDemand."Demand SubType";
        "Demand Order No." := UnplannedDemand."Demand Order No.";
        "Demand Line No." := UnplannedDemand."Demand Line No.";
        "Demand Ref. No." := UnplannedDemand."Demand Ref. No.";

        Status := UnplannedDemand.Status;

        Level := 1;
        "Action Message" := ReqLine."Action Message"::New;
        "User ID" := USERID;

        OnAfterTransferFromUnplannedDemand(Rec,UnplannedDemand);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        INIT;
        #3..40
        */
    //end;


    //Unsupported feature: Code Modification on "SetSupplyQty(PROCEDURE 42)".

    //procedure SetSupplyQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Qty. per Unit of Measure" = 0 Then
          "Qty. per Unit of Measure" := 1;

        "Demand Quantity" := ROUND(DemandQtyBase / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
        "Demand Quantity (Base)" := DemandQtyBase;
        "Needed Quantity" := ROUND(NeededQtyBase / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
        if "Needed Quantity" < NeededQtyBase / "Qty. per Unit of Measure" Then
          "Needed Quantity" := ROUND(NeededQtyBase / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision,'>');
        "Needed Quantity (Base)" := NeededQtyBase;
        "Demand Qty. Available" :=
          ROUND((DemandQtyBase - NeededQtyBase) / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
        VALIDATE(Quantity,"Needed Quantity");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        "Demand Quantity" := ROUND(DemandQtyBase / "Qty. per Unit of Measure",0.00001);
        "Demand Quantity (Base)" := DemandQtyBase;
        "Needed Quantity" := ROUND(NeededQtyBase / "Qty. per Unit of Measure",0.00001);
        if "Needed Quantity" < NeededQtyBase / "Qty. per Unit of Measure" Then
          "Needed Quantity" := ROUND(NeededQtyBase / "Qty. per Unit of Measure",0.00001,'>');
        "Needed Quantity (Base)" := NeededQtyBase;
        "Demand Qty. Available" :=
          ROUND((DemandQtyBase - NeededQtyBase) / "Qty. per Unit of Measure",0.00001);
        VALIDATE(Quantity,"Needed Quantity");
        */
    //end;


    //Unsupported feature: Code Modification on "SetFromBinCode(PROCEDURE 62)".

    //procedure SetFromBinCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeSetFromBinCode(Rec,IsHandled);
        if IsHandled Then
          EXIT;

        if ("Location Code" <> '') AND ("No." <> '') Then BEGIN
          GetLocation("Location Code");
          CASE "Ref. Order Type" OF
            "Ref. Order Type"::"Prod. Order":
              BEGIN
                if "Bin Code" = '' Then
                  "Bin Code" := WMSManagement.GetLastOperationFromBinCode("Routing No.","Routing Version Code","Location Code",FALSE,0);
                if "Bin Code" = '' Then
                  "Bin Code" := Location."From-Production Bin Code";
              END;
            "Ref. Order Type"::Assembly:
              if "Bin Code" = '' Then
                "Bin Code" := Location."From-Assembly Bin Code";
          END;
          ShouldGetDefaultBin := ("Bin Code" = '') AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
          OnBeforeGetDefaultBin(Rec,ShouldGetDefaultBin);
          if ShouldGetDefaultBin Then
            WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #6..19
          if ("Bin Code" = '') AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" Then
            WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code")
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "IsDropShipment(PROCEDURE 59)".


    //Unsupported feature: Property Insertion (Local) on "IsDropShipment(PROCEDURE 59)".



    //Unsupported feature: Code Modification on "GetLocationCode(PROCEDURE 75)".

    //procedure GetLocationCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if NOT IsLocationCodeAlterable OR IsDropShipmentOrSpecialOrder Then
          EXIT;

        IsHandled := FALSE;
        OnGetLocationCodeOnBeforeUpdate(Rec,CurrFieldNo,IsHandled);
        if IsHandled Then
          EXIT;

        if "Vendor No." <> '' Then BEGIN
          Vend.Get("Vendor No.");
          if Vend."Location Code" <> '' Then
            "Location Code" := Vend."Location Code";
        END else
          "Location Code" := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        if IsLocationCodeAlterable Then BEGIN
          if NOT IsDropShipmentOrSpecialOrder Then
            if "Vendor No." <> '' Then BEGIN
              Vend.Get("Vendor No.");
              if Vend."Location Code" <> '' Then
                "Location Code" := Vend."Location Code";
            END else
              "Location Code" := '';
        END;
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "UpdateOrderReceiptDate(PROCEDURE 5).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateDescription(PROCEDURE 8).IsHandled(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "SetFromBinCode(PROCEDURE 62).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "SetFromBinCode(PROCEDURE 62).ShouldGetDefaultBin(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetLocationCode(PROCEDURE 75).IsHandled(Variable 1001)".

}

