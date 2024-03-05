namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.History;
tableextension 50021 PurchRcptLine extends "Purch. Rcpt. Line" //121
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
    }

    //Unsupported feature: Code Modification on "InsertInvLineFromRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetRange("Document No.","Document No.");

    TempPurchLine := PurchLine;
    if PurchLine.FIND('+') Then
      NextLineNo := PurchLine."Line No." + 10000
    else
      NextLineNo := 10000;

    if PurchInvHeader."No." <> TempPurchLine."Document No." Then
      PurchInvHeader.Get(TempPurchLine."Document Type",TempPurchLine."Document No.");

    if PurchLine."Receipt No." <> "Document No." Then BEGIN
      PurchLine.INIT;
      PurchLine."Line No." := NextLineNo;
      PurchLine."Document Type" := TempPurchLine."Document Type";
      PurchLine."Document No." := TempPurchLine."Document No.";
      LanguageManagement.SetGlobalLanguageByCode(PurchInvHeader."Language Code");
      PurchLine.Description := STRSUBSTNO(Text000,"Document No.");
      LanguageManagement.RestoreGlobalLanguage;
      OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine(Rec,PurchLine,NextLineNo,Handled);
      if NOT Handled Then BEGIN
        PurchLine.INSERT;
        NextLineNo := NextLineNo + 10000;
      END;
    END;

    TransferOldExtLines.ClearLineNumbers;

    REPEAT
      ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

      if PurchOrderLine.Get(
           PurchOrderLine."Document Type"::Order,"Order No.","Order Line No.") AND
         NOT ExtTextLine
      Then BEGIN
        if (PurchOrderHeader."Document Type" <> PurchOrderLine."Document Type"::Order) OR
           (PurchOrderHeader."No." <> PurchOrderLine."Document No.")
        Then
          PurchOrderHeader.Get(PurchOrderLine."Document Type"::Order,"Order No.");

        InitCurrency("Currency Code");

        if PurchInvHeader."Prices Including VAT" Then BEGIN
          if NOT PurchOrderHeader."Prices Including VAT" Then
            PurchOrderLine."Direct Unit Cost" :=
              ROUND(
                PurchOrderLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100),
                Currency."Unit-Amount Rounding Precision");
        END else BEGIN
          if PurchOrderHeader."Prices Including VAT" Then
            PurchOrderLine."Direct Unit Cost" :=
              ROUND(
                PurchOrderLine."Direct Unit Cost" / (1 + PurchOrderLine."VAT %" / 100),
                Currency."Unit-Amount Rounding Precision");
        END;
      END else BEGIN
        if ExtTextLine Then BEGIN
          PurchOrderLine.INIT;
          PurchOrderLine."Line No." := "Order Line No.";
          PurchOrderLine.Description := Description;
          PurchOrderLine."Description 2" := "Description 2";
          OnInsertInvLineFromRcptLineOnAfterAssignDescription(Rec,PurchOrderLine);
        END else
          Error(Text001);
      END;
      PurchLine := PurchOrderLine;
      PurchLine."Line No." := NextLineNo;
      PurchLine."Document Type" := TempPurchLine."Document Type";
      PurchLine."Document No." := TempPurchLine."Document No.";
      PurchLine."Variant Code" := "Variant Code";
      PurchLine."Location Code" := "Location Code";
      PurchLine."Quantity (Base)" := 0;
      PurchLine.Quantity := 0;
      PurchLine."Outstanding Qty. (Base)" := 0;
      PurchLine."Outstanding Quantity" := 0;
      PurchLine."Quantity Received" := 0;
      PurchLine."Qty. Received (Base)" := 0;
      PurchLine."Quantity Invoiced" := 0;
      PurchLine."Qty. Invoiced (Base)" := 0;
      PurchLine.Amount := 0;
      PurchLine."Amount Including VAT" := 0;
      PurchLine."Sales Order No." := '';
      PurchLine."Sales Order Line No." := 0;
      PurchLine."Drop Shipment" := FALSE;
      PurchLine."Special Order Sales No." := '';
      PurchLine."Special Order Sales Line No." := 0;
      PurchLine."Special Order" := FALSE;
      PurchLine."Receipt No." := "Document No.";
      PurchLine."Receipt Line No." := "Line No.";
      PurchLine."Appl.-to Item Entry" := 0;
      OnAfterCopyFromPurchRcptLine(PurchLine,Rec);
      if NOT ExtTextLine Then BEGIN
        PurchLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");

        OnInsertInvLineFromRcptLineOnAfterCalcQuantities(PurchLine,PurchOrderLine);

        PurchLine.VALIDATE("Direct Unit Cost",PurchOrderLine."Direct Unit Cost");
        PurchOrderLine."Line Discount Amount" :=
          ROUND(
            PurchOrderLine."Line Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
            Currency."Amount Rounding Precision");
        if PurchInvHeader."Prices Including VAT" Then BEGIN
          if NOT PurchOrderHeader."Prices Including VAT" Then
            PurchOrderLine."Line Discount Amount" :=
              ROUND(
                PurchOrderLine."Line Discount Amount" *
                (1 + PurchOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
        END else
          if PurchOrderHeader."Prices Including VAT" Then
            PurchOrderLine."Line Discount Amount" :=
              ROUND(
                PurchOrderLine."Line Discount Amount" /
                (1 + PurchOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
        PurchLine.VALIDATE("Line Discount Amount",PurchOrderLine."Line Discount Amount");
        PurchLine."Line Discount %" := PurchOrderLine."Line Discount %";
        PurchLine.UpdatePrePaymentAmounts;
        if PurchOrderLine.Quantity = 0 Then
          PurchLine.VALIDATE("Inv. Discount Amount",0)
        else
          PurchLine.VALIDATE(
            "Inv. Discount Amount",
            ROUND(
              PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
              Currency."Amount Rounding Precision"));
      END;

      PurchLine."Attached to Line No." :=
        TransferOldExtLines.TransferExtendedText(
          "Line No.",
          NextLineNo,
          "Attached to Line No.");
      PurchLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
      PurchLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
      PurchLine."Dimension Set ID" := "Dimension Set ID";

      if "Sales Order No." = '' Then
        PurchLine."Drop Shipment" := FALSE
      else
        PurchLine."Drop Shipment" := TRUE;

      OnBeforeInsertInvLineFromRcptLine(Rec,PurchLine,PurchOrderLine);
      PurchLine.INSERT;
      OnAfterInsertInvLineFromRcptLine(PurchLine,PurchOrderLine,NextLineNo,Rec);

      ItemTrackingMgt.CopyHandledItemTrkgToInvLine2(PurchOrderLine,PurchLine);

      NextLineNo := NextLineNo + 10000;
      if "Attached to Line No." = 0 Then
        SetRange("Attached to Line No.","Line No.");
    UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..61
    #63..90
      if NOT ExtTextLine Then BEGIN
        PurchLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
    #97..142
      OnAfterInsertInvLineFromRcptLine(PurchLine,PurchOrderLine,NextLineNo);
    #144..150
    */
    //end;


    //Unsupported feature: Code Modification on "CalcQty(PROCEDURE 10)".

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

    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterInsertInvLineFromRcptLine(PROCEDURE 18).PurchRcptLine(Parameter 1003)".

}

