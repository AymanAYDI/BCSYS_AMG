namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50018 SalesShipmentLine extends "Sales Shipment Line" //111
{
    fields
    {
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".

        field(50000; "Outstanding Qty"; Decimal)
        {
            CalcFormula = lookup("Sales Line"."Outstanding Quantity" where(Document Type=CONST(Order),
                                                                            Type=CONST(Item),
                                                                            Document No.=field(Order No.),
                                                                            Line No.=FIELD(Order Line No.)));
            Caption = 'Outstanding Qty';
            Description = 'MHR EURIS';
            FieldClass = FlowField;
        }
        field(50001;"Outstandin Qty report";Decimal)
        {
            Caption = 'Outstanding Qty';
            Description = 'AUB AMG';
        }
        field(50010;"N° Colis";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'AMG.COLIS';
            TableRelation = Colis.N° WHERE (N° expédition=FIELD(Document No.));

            trigger OnValidate()
            var
                LRecColisage: Record "50010";
                LRecColis: Record "50009";
            begin
            end;
        }
        field(50020;"Code ONU";Code[10])
        {
            CalcFormula = Lookup(Item."Code ONU" WHERE (No.=FIELD(No.)));
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "InsertInvLineFromShptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromShptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeCodeInsertInvLineFromShptLine(Rec,SalesLine,IsHandled);
        if IsHandled Then
          EXIT;

        SetRange("Document No.","Document No.");

        TempSalesLine := SalesLine;
        if SalesLine.FIND('+') Then
          NextLineNo := SalesLine."Line No." + 10000
        else
          NextLineNo := 10000;

        if SalesInvHeader."No." <> TempSalesLine."Document No." Then
          SalesInvHeader.Get(TempSalesLine."Document Type",TempSalesLine."Document No.");

        if SalesLine."Shipment No." <> "Document No." Then BEGIN
          SalesLine.INIT;
          SalesLine."Line No." := NextLineNo;
          SalesLine."Document Type" := TempSalesLine."Document Type";
          SalesLine."Document No." := TempSalesLine."Document No.";
          LanguageManagement.SetGlobalLanguageByCode(SalesInvHeader."Language Code");
          SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
          LanguageManagement.RestoreGlobalLanguage;
          IsHandled := FALSE;
          OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(Rec,SalesLine,NextLineNo,IsHandled);
          if NOT IsHandled Then BEGIN
            SalesLine.INSERT;
            OnAfterDescriptionSalesLineInsert(SalesLine,Rec,NextLineNo);
            NextLineNo := NextLineNo + 10000;
          END;
        END;

        TransferOldExtLines.ClearLineNumbers;

        REPEAT
          ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

          if (Type <> Type::" ") AND SalesOrderLine.Get(SalesOrderLine."Document Type"::Order,"Order No.","Order Line No.")
          Then BEGIN
            if (SalesOrderHeader."Document Type" <> SalesOrderLine."Document Type"::Order) OR
               (SalesOrderHeader."No." <> SalesOrderLine."Document No.")
            Then
              SalesOrderHeader.Get(SalesOrderLine."Document Type"::Order,"Order No.");

            InitCurrency("Currency Code");

            if SalesInvHeader."Prices Including VAT" Then BEGIN
              if NOT SalesOrderHeader."Prices Including VAT" Then
                SalesOrderLine."Unit Price" :=
                  ROUND(
                    SalesOrderLine."Unit Price" * (1 + SalesOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END else BEGIN
              if SalesOrderHeader."Prices Including VAT" Then
                SalesOrderLine."Unit Price" :=
                  ROUND(
                    SalesOrderLine."Unit Price" / (1 + SalesOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END;
          END else BEGIN
            SalesOrderHeader.INIT;
            if ExtTextLine OR (Type = Type::" ") Then BEGIN
              SalesOrderLine.INIT;
              SalesOrderLine."Line No." := "Order Line No.";
              SalesOrderLine.Description := Description;
              SalesOrderLine."Description 2" := "Description 2";
              OnInsertInvLineFromShptLineOnAfterAssignDescription(Rec,SalesOrderLine);
            END else
              Error(Text001);
          END;

          SalesLine := SalesOrderLine;
          SalesLine."Line No." := NextLineNo;
          SalesLine."Document Type" := TempSalesLine."Document Type";
          SalesLine."Document No." := TempSalesLine."Document No.";
          SalesLine."Variant Code" := "Variant Code";
          SalesLine."Location Code" := "Location Code";
          SalesLine."Drop Shipment" := "Drop Shipment";
          SalesLine."Shipment No." := "Document No.";
          SalesLine."Shipment Line No." := "Line No.";
          ClearSalesLineValues(SalesLine);
          if NOT ExtTextLine AND (SalesLine.Type <> 0) Then BEGIN
            IsHandled := FALSE;
            OnInsertInvLineFromShptLineOnBeforeValidateQuantity(Rec,SalesLine,IsHandled);
            if NOT IsHandled Then
              SalesLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            CalcBaseQuantities(SalesLine,"Quantity (Base)" / Quantity);

            OnInsertInvLineFromShptLineOnAfterCalcQuantities(SalesLine,SalesOrderLine);

            SalesLine.VALIDATE("Unit Price",SalesOrderLine."Unit Price");
            SalesLine."Allow Line Disc." := SalesOrderLine."Allow Line Disc.";
            SalesLine."Allow Invoice Disc." := SalesOrderLine."Allow Invoice Disc.";
            SalesOrderLine."Line Discount Amount" :=
              ROUND(
                SalesOrderLine."Line Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                Currency."Amount Rounding Precision");
            if SalesInvHeader."Prices Including VAT" Then BEGIN
              if NOT SalesOrderHeader."Prices Including VAT" Then
                SalesOrderLine."Line Discount Amount" :=
                  ROUND(
                    SalesOrderLine."Line Discount Amount" *
                    (1 + SalesOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            END else BEGIN
              if SalesOrderHeader."Prices Including VAT" Then
                SalesOrderLine."Line Discount Amount" :=
                  ROUND(
                    SalesOrderLine."Line Discount Amount" /
                    (1 + SalesOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            END;
            SalesLine.VALIDATE("Line Discount Amount",SalesOrderLine."Line Discount Amount");
            SalesLine."Line Discount %" := SalesOrderLine."Line Discount %";
            SalesLine.UpdatePrePaymentAmounts;
            OnInsertInvLineFromShptLineOnAfterUpdatePrepaymentsAmounts(SalesLine,SalesOrderLine,Rec);

            if SalesOrderLine.Quantity = 0 Then
              SalesLine.VALIDATE("Inv. Discount Amount",0)
            else
              SalesLine.VALIDATE(
                "Inv. Discount Amount",
                ROUND(
                  SalesOrderLine."Inv. Discount Amount" * SalesLine.Quantity / SalesOrderLine.Quantity,
                  Currency."Amount Rounding Precision"));
          END;

          SalesLine."Attached to Line No." :=
            TransferOldExtLines.TransferExtendedText(
              SalesOrderLine."Line No.",
              NextLineNo,
              "Attached to Line No.");
          SalesLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
          SalesLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
          SalesLine."Dimension Set ID" := "Dimension Set ID";
          OnBeforeInsertInvLineFromShptLine(Rec,SalesLine,SalesOrderLine);
          SalesLine.INSERT;
          OnAfterInsertInvLineFromShptLine(SalesLine,SalesOrderLine,NextLineNo,Rec);

          ItemTrackingMgt.CopyHandledItemTrkgToInvLine(SalesOrderLine,SalesLine);

          NextLineNo := NextLineNo + 10000;
          if "Attached to Line No." = 0 Then
            SetRange("Attached to Line No.","Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);

        if SalesOrderHeader.Get(SalesOrderHeader."Document Type"::Order,"Order No.") Then BEGIN
          SalesOrderHeader."Get Shipment Used" := TRUE;
          SalesOrderHeader.MODIFY;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..28
        #30..67
        #69..83
            SalesLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            CalcBaseQuantities(SalesLine,"Quantity (Base)" / Quantity);
        #92..136
          OnAfterInsertInvLineFromShptLine(SalesLine,SalesOrderLine,NextLineNo);
        #138..149
        */
    //end;


    //Unsupported feature: Code Modification on "CalcQty(PROCEDURE 9)".

    //procedure CalcQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        if "Qty. per Unit of Measure" = 0 Then
          EXIT(QtyBase);
        EXIT(ROUND(QtyBase / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        if "Qty. per Unit of Measure" = 0 Then
          EXIT(QtyBase);
        EXIT(ROUND(QtyBase / "Qty. per Unit of Measure",0.00001));
        */
    //end;


    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 12)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        INIT;
        TRANSFERFIELDS(SalesLine);
        if ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) Then
          Type := Type::" ";
        "Posting Date" := SalesShptHeader."Posting Date";
        "Document No." := SalesShptHeader."No.";
        Quantity := SalesLine."Qty. to Ship";
        "Quantity (Base)" := SalesLine."Qty. to Ship (Base)";
        if ABS(SalesLine."Qty. to Invoice") > ABS(SalesLine."Qty. to Ship") Then BEGIN
          "Quantity Invoiced" := SalesLine."Qty. to Ship";
          "Qty. Invoiced (Base)" := SalesLine."Qty. to Ship (Base)";
        END else BEGIN
          "Quantity Invoiced" := SalesLine."Qty. to Invoice";
          "Qty. Invoiced (Base)" := SalesLine."Qty. to Invoice (Base)";
        END;
        "Qty. Shipped Not Invoiced" := Quantity - "Quantity Invoiced";
        if SalesLine."Document Type" = SalesLine."Document Type"::Order Then BEGIN
          "Order No." := SalesLine."Document No.";
          "Order Line No." := SalesLine."Line No.";
        END;

        OnAfterInitFromSalesLine(SalesShptHeader,SalesLine,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20
        //"Outstanding Qty" := SalesLine."Outstanding Quantity";//DELPHI AUB 31.07.2020
        OnAfterInitFromSalesLine(SalesShptHeader,SalesLine,Rec);
        */
    //end;


    //Unsupported feature: Code Modification on "CalcBaseQuantities(PROCEDURE 13)".

    //procedure CalcBaseQuantities();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesLine."Quantity (Base)" :=
          ROUND(SalesLine.Quantity * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. to Asm. to Order (Base)" :=
          ROUND(SalesLine."Qty. to Assemble to Order" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Outstanding Qty. (Base)" :=
          ROUND(SalesLine."Outstanding Quantity" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. to Ship (Base)" :=
          ROUND(SalesLine."Qty. to Ship" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. Shipped (Base)" :=
          ROUND(SalesLine."Quantity Shipped" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. Shipped Not Invd. (Base)" :=
          ROUND(SalesLine."Qty. Shipped Not Invoiced" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. to Invoice (Base)" :=
          ROUND(SalesLine."Qty. to Invoice" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Qty. Invoiced (Base)" :=
          ROUND(SalesLine."Quantity Invoiced" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Return Qty. to Receive (Base)" :=
          ROUND(SalesLine."Return Qty. to Receive" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Return Qty. Received (Base)" :=
          ROUND(SalesLine."Return Qty. Received" * QtyFactor,UOMMgt.QtyRndPrecision);
        SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" :=
          ROUND(SalesLine."Return Qty. Rcd. Not Invd." * QtyFactor,UOMMgt.QtyRndPrecision);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesLine."Quantity (Base)" := ROUND(SalesLine.Quantity * QtyFactor,0.00001);
        SalesLine."Qty. to Asm. to Order (Base)" := ROUND(SalesLine."Qty. to Assemble to Order" * QtyFactor,0.00001);
        SalesLine."Outstanding Qty. (Base)" := ROUND(SalesLine."Outstanding Quantity" * QtyFactor,0.00001);
        SalesLine."Qty. to Ship (Base)" := ROUND(SalesLine."Qty. to Ship" * QtyFactor,0.00001);
        SalesLine."Qty. Shipped (Base)" := ROUND(SalesLine."Quantity Shipped" * QtyFactor,0.00001);
        SalesLine."Qty. Shipped Not Invd. (Base)" := ROUND(SalesLine."Qty. Shipped Not Invoiced" * QtyFactor,0.00001);
        SalesLine."Qty. to Invoice (Base)" := ROUND(SalesLine."Qty. to Invoice" * QtyFactor,0.00001);
        SalesLine."Qty. Invoiced (Base)" := ROUND(SalesLine."Quantity Invoiced" * QtyFactor,0.00001);
        SalesLine."Return Qty. to Receive (Base)" := ROUND(SalesLine."Return Qty. to Receive" * QtyFactor,0.00001);
        SalesLine."Return Qty. Received (Base)" := ROUND(SalesLine."Return Qty. Received" * QtyFactor,0.00001);
        SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := ROUND(SalesLine."Return Qty. Rcd. Not Invd." * QtyFactor,0.00001);
        */
    //end;

    procedure ZeroIsBlanckInteger("Integer": Integer) Return: Text[50]
    begin
        if Integer <> 0 Then
          Return := FORMAT(Integer)
        else
          Return := '';
    end;

    procedure ZeroIsBlanckDecimal(Decimale: Decimal) Return: Text[50]
    begin
        if Decimale <>0 Then
          Return := FORMAT(Decimale,10,'<Standard Format,0>')
        else
          Return := '';
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterInsertInvLineFromShptLine(PROCEDURE 18).SalesShipmentLine(Parameter 1003)".


    var
        ItemNoFieldCaptionTxt: Label 'Item No.';
}

