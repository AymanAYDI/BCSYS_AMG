namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
tableextension 50015 GenJournalLine extends "Gen. Journal Line" //81
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold';
        }

        //Unsupported feature: Code Modification on ""Account Type"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner","Account Type"::Employee]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
                                    "Bal. Account Type"::"IC Partner","Bal. Account Type"::Employee])
        Then
          Error(
            Text000,
            FieldCaption("Account Type"),FieldCaption("Bal. Account Type"));

        if ("Account Type" = "Account Type"::Employee) AND ("Currency Code" <> '') Then
          Error(OnlyLocalCurrencyForEmployeeErr);

        VALIDATE("Account No.",'');
        VALIDATE(Description,'');
        VALIDATE("IC Partner G/L Acc. No.",'');
        if "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account","Account Type"::Employee] Then BEGIN
          VALIDATE("Gen. Posting Type","Gen. Posting Type"::" ");
          VALIDATE("Gen. Bus. Posting Group",'');
          VALIDATE("Gen. Prod. Posting Group",'');
        END else
          if "Bal. Account Type" IN [
                                     "Bal. Account Type"::"G/L Account","Account Type"::"Bank Account","Bal. Account Type"::"Fixed Asset"]
          Then
            VALIDATE("Payment Terms Code",'');
        UpdateSource;

        if ("Account Type" <> "Account Type"::"Fixed Asset") AND
           ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset")
        Then BEGIN
          "Depreciation Book Code" := '';
          VALIDATE("FA Posting Type","FA Posting Type"::" ");
        END;
        if xRec."Account Type" IN
           [xRec."Account Type"::Customer,xRec."Account Type"::Vendor]
        Then BEGIN
          "Bill-to/Pay-to No." := '';
          "Ship-to/Order Address Code" := '';
          "Sell-to/Buy-from No." := '';
          "VAT Registration No." := '';
        END;

        if "Journal Template Name" <> '' Then
          if "Account Type" = "Account Type"::"IC Partner" Then BEGIN
            GetTemplate;
            if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany Then
              FIELDERROR("Account Type");
          END;

        VALIDATE("Deferral Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13


        // DELPHI MHR RAPPRO BANK 13/03/2023
        // Evite que la description ne s'efface si le type de compte est changé
        if SourceCodeSetup.Get Then;
        if "Source Code"=SourceCodeSetup."Trans. Bank Rec. to Gen. Jnl." Then
        BEGIN
          if Description='' Then VALIDATE(Description,'');
        END
        else VALIDATE(Description,'');

        //STANDARD VALIDATE(Description,'');
        // DELPHI MHR RAPPRO BANK 13/03/2023




        #15..49
        */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Account No." <> xRec."Account No." Then BEGIN
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
        END;

        if xRec."Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] Then
          "IC Partner Code" := '';

        if "Account No." = '' Then BEGIN
          CleanLine;
          GetDerogatorySetup;
          EXIT;
        END;

        OnValidateAccountNoOnBeforeAssignValue(Rec,xRec);

        CASE "Account Type" OF
          "Account Type"::"G/L Account":
            GetGLAccount;
          "Account Type"::Customer:
            GetCustomerAccount;
          "Account Type"::Vendor:
            GetVendorAccount;
          "Account Type"::Employee:
            GetEmployeeAccount;
          "Account Type"::"Bank Account":
            GetBankAccount;
          "Account Type"::"Fixed Asset":
            GetFAAccount;
          "Account Type"::"IC Partner":
            GetICPartnerAccount;
        END;

        OnValidateAccountNoOnAfterAssignValue(Rec,xRec);

        VALIDATE("Currency Code");
        VALIDATE("VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);

        CASE "Account Type" OF
          "Account Type"::"G/L Account":
            UpdateAccountID;
          "Account Type"::Customer:
            UpdateCustomerID;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..14
        #17..33
        #36..55
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT %"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Amount" :=
                ROUND(Amount * "VAT %" / (100 + "VAT %"),Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
              "VAT Base Amount" :=
                ROUND(Amount - "VAT Amount",Currency."Amount Rounding Precision");
            END;
          "VAT Calculation Type"::"Full VAT":
            "VAT Amount" := Amount;
          "VAT Calculation Type"::"Sales Tax":
            if ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
               "Use Tax"
            Then BEGIN
              "VAT Amount" := 0;
              "VAT %" := 0;
            END else BEGIN
              "VAT Amount" :=
                Amount -
                SalesTaxCalculate.ReverseCalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",
                  "Posting Date",Amount,Quantity,"Currency Factor");
              OnAfterSalesTaxCalculateReverseCalculateTax(Rec,CurrFieldNo);
              if Amount - "VAT Amount" <> 0 Then
                "VAT %" := ROUND(100 * "VAT Amount" / (Amount - "VAT Amount"),0.00001)
              else
                "VAT %" := 0;
              "VAT Amount" :=
                ROUND("VAT Amount",Currency."Amount Rounding Precision");
            END;
        END;
        "VAT Base Amount" := Amount - "VAT Amount";
        "VAT Difference" := 0;

        if "Currency Code" = '' Then
          "VAT Amount (LCY)" := "VAT Amount"
        else
          "VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                "VAT Amount","Currency Factor"));
        "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

        OnValidateVATPctOnBeforeUpdateSalesPurchLCY(Rec,Currency);
        UpdateSalesPurchLCY;

        if "Deferral Code" <> '' Then
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
        #26..46
        #48..51
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 11).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Job No.",'');

        if xRec."Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
                                        "Bal. Account Type"::"IC Partner"]
        Then
          "IC Partner Code" := '';

        if "Bal. Account No." = '' Then BEGIN
          UpdateLineBalance;
          UpdateSource;
          CreateDim(
            DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
            DimMgt.TypeToTableID1("Account Type"),"Account No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
            DATABASE::Campaign,"Campaign No.");
          if NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) Then
            "Recipient Bank Account" := '';
          if xRec."Bal. Account No." <> '' Then BEGIN
            ClearBalancePostingGroups;
            "Bal. Tax Area Code" := '';
            "Bal. Tax Liable" := FALSE;
            "Bal. Tax Group Code" := '';
            ClearCurrencyCode;
          END;
          EXIT;
        END;

        OnValidateBalAccountNoOnBeforeAssignValue(Rec,xRec);

        CASE "Bal. Account Type" OF
          "Bal. Account Type"::"G/L Account":
            GetGLBalAccount;
          "Bal. Account Type"::Customer:
            GetCustomerBalAccount;
          "Bal. Account Type"::Vendor:
            GetVendorBalAccount;
          "Bal. Account Type"::Employee:
            GetEmployeeBalAccount;
          "Bal. Account Type"::"Bank Account":
            GetBankBalAccount;
          "Bal. Account Type"::"Fixed Asset":
            GetFABalAccount;
          "Bal. Account Type"::"IC Partner":
            GetICPartnerBalAccount;
        END;

        OnValidateBalAccountNoOnAfterAssignValue(Rec,xRec);

        VALIDATE("Currency Code");
        VALIDATE("Bal. VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
        #31..47
        #50..62
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 36).OnValidate".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if SuppressCommit Then
          PaymentToleranceMgt.SetSuppressCommit(TRUE);

        if "Applies-to Doc. No." <> xRec."Applies-to Doc. No." Then
          ClearCustVendApplnEntry;

        if ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') Then BEGIN
          PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");

          TempGenJnlLine := Rec;
          if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor) OR
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Employee)
          Then
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

          CASE TempGenJnlLine."Account Type" OF
            TempGenJnlLine."Account Type"::Customer:
              BEGIN
                CustLedgEntry.SETCURRENTKEY("Document No.");
                CustLedgEntry.SetRange("Document No.",xRec."Applies-to Doc. No.");
                if NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") Then
                  CustLedgEntry.SetRange("Document Type",xRec."Applies-to Doc. Type");
                CustLedgEntry.SetRange("Customer No.",TempGenJnlLine."Account No.");
                CustLedgEntry.SetRange(Open,TRUE);
                if CustLedgEntry.FINDFIRST Then BEGIN
                  if CustLedgEntry."Amount to Apply" <> 0 Then  BEGIN
                    CustLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
                  END;
                  "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                  "Applies-to Ext. Doc. No." := '';
                END;
              END;
            TempGenJnlLine."Account Type"::Vendor:
              BEGIN
                VendLedgEntry.SETCURRENTKEY("Document No.");
                VendLedgEntry.SetRange("Document No.",xRec."Applies-to Doc. No.");
                if NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") Then
                  VendLedgEntry.SetRange("Document Type",xRec."Applies-to Doc. Type");
                VendLedgEntry.SetRange("Vendor No.",TempGenJnlLine."Account No.");
                VendLedgEntry.SetRange(Open,TRUE);
                if VendLedgEntry.FINDFIRST Then BEGIN
                  if VendLedgEntry."Amount to Apply" <> 0 Then  BEGIN
                    VendLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                  END;
                  "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                END;
                "Applies-to Ext. Doc. No." := '';
              END;
            TempGenJnlLine."Account Type"::Employee:
              BEGIN
                EmplLedgEntry.SETCURRENTKEY("Document No.");
                EmplLedgEntry.SetRange("Document No.",xRec."Applies-to Doc. No.");
                if NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") Then
                  EmplLedgEntry.SetRange("Document Type",xRec."Applies-to Doc. Type");
                EmplLedgEntry.SetRange("Employee No.",TempGenJnlLine."Account No.");
                EmplLedgEntry.SetRange(Open,TRUE);
                if EmplLedgEntry.FINDFIRST Then BEGIN
                  if EmplLedgEntry."Amount to Apply" <> 0 Then BEGIN
                    EmplLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Empl. Entry-Edit",EmplLedgEntry);
                  END;
                  "Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
                END;
              END;
          END;
        END;

        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Amount <> 0) Then BEGIN
          if xRec."Applies-to Doc. No." <> '' Then
            PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");
          SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
          xRec.ClearAppliedGenJnlLine;
        END;

        CASE "Account Type" OF
          "Account Type"::Customer:
            GetCustLedgerEntry;
          "Account Type"::Vendor:
            GetVendLedgerEntry;
          "Account Type"::Employee:
            GetEmplLedgerEntry;
        END;

        ValidateApplyRequirements(Rec);
        SetJournalLineFieldsFromApplication;

        if "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice Then
          UpdateAppliesToInvoiceID;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #4..92
        */
        //end;


        //Unsupported feature: Code Modification on ""Payment Terms Code"(Field 47).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Due Date" := 0D;
        "Pmt. Discount Date" := 0D;
        "Payment Discount %" := 0;
        if ("Account Type" <> "Account Type"::"G/L Account") OR
           ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account")
        Then
          CASE "Document Type" OF
            "Document Type"::Invoice:
              if ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) Then BEGIN
                PaymentTerms.Get("Payment Terms Code");
                IsHandled := FALSE;
                OnValidatePaymentTermsCodeOnBeforeCalculateDueDate(Rec,PaymentTerms,IsHandled);
                if NOT IsHandled Then
                  "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                IsHandled := FALSE;
                OnValidatePaymentTermsCodeOnBeforeCalculatePmtDiscountDate(Rec,PaymentTerms,IsHandled);
                if NOT IsHandled Then
                  "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
                "Payment Discount %" := PaymentTerms."Discount %";
              END else
                "Due Date" := "Document Date";
            "Document Type"::"Credit Memo":
              if ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) Then BEGIN
                PaymentTerms.Get("Payment Terms Code");
                if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" Then BEGIN
                  "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                  "Pmt. Discount Date" :=
                    CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
                  "Payment Discount %" := PaymentTerms."Discount %";
                END else
                  "Due Date" := "Document Date";
              END else
                "Due Date" := "Document Date";
            else
              "Due Date" := "Document Date";
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
        #19..36
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT %"(Field 68).OnValidate".

        //trigger  VAT %"(Field 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "Bal. VAT Calculation Type" OF
          "Bal. VAT Calculation Type"::"Normal VAT",
          "Bal. VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "Bal. VAT Amount" :=
                ROUND(-Amount * "Bal. VAT %" / (100 + "Bal. VAT %"),Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
              "Bal. VAT Base Amount" :=
                ROUND(-Amount - "Bal. VAT Amount",Currency."Amount Rounding Precision");
            END;
          "Bal. VAT Calculation Type"::"Full VAT":
            "Bal. VAT Amount" := -Amount;
          "Bal. VAT Calculation Type"::"Sales Tax":
            if ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) AND
               "Bal. Use Tax"
            Then BEGIN
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
            END else BEGIN
              "Bal. VAT Amount" :=
                -(Amount -
                  SalesTaxCalculate.ReverseCalculateTax(
                    "Bal. Tax Area Code","Bal. Tax Group Code","Bal. Tax Liable",
                    "Posting Date",Amount,Quantity,"Currency Factor"));
              OnAfterSalesTaxCalculateReverseCalculateTax(Rec,CurrFieldNo);
              if Amount + "Bal. VAT Amount" <> 0 Then
                "Bal. VAT %" := ROUND(100 * -"Bal. VAT Amount" / (Amount + "Bal. VAT Amount"),0.00001)
              else
                "Bal. VAT %" := 0;
              "Bal. VAT Amount" :=
                ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision");
            END;
        END;
        "Bal. VAT Base Amount" := -(Amount + "Bal. VAT Amount");
        "Bal. VAT Difference" := 0;

        if "Currency Code" = '' Then
          "Bal. VAT Amount (LCY)" := "Bal. VAT Amount"
        else
          "Bal. VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Bal. VAT Amount","Currency Factor"));
        OnValidateBalVATPctOnAfterAssignBalVATAmountLCY("Bal. VAT Amount (LCY)");
        "Bal. VAT Base Amount (LCY)" := -("Amount (LCY)" + "Bal. VAT Amount (LCY)");

        OnValidateVATPctOnBeforeUpdateSalesPurchLCY(Rec,Currency);
        UpdateSalesPurchLCY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
        #26..45
        UpdateSalesPurchLCY;
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Base Amount"(Field 71).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "VAT Base Amount" := ROUND("VAT Base Amount",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            Amount :=
              ROUND(
                "VAT Base Amount" * (1 + "VAT %" / 100),
                Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
          "VAT Calculation Type"::"Full VAT":
            if "VAT Base Amount" <> 0 Then
              FIELDERROR(
                "VAT Base Amount",
                STRSUBSTNO(
                  Text008,FieldCaption("VAT Calculation Type"),
                  "VAT Calculation Type"));
          "VAT Calculation Type"::"Sales Tax":
            if ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) AND
               "Use Tax"
            Then BEGIN
              "VAT Amount" := 0;
              "VAT %" := 0;
              Amount := "VAT Base Amount" + "VAT Amount";
            END else BEGIN
              "VAT Amount" :=
                SalesTaxCalculate.CalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable","Posting Date",
                  "VAT Base Amount",Quantity,"Currency Factor");
              OnAfterSalesTaxCalculateCalculateTax(Rec,CurrFieldNo);
              if "VAT Base Amount" <> 0 Then
                "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base Amount",0.00001)
              else
                "VAT %" := 0;
              "VAT Amount" :=
                ROUND("VAT Amount",Currency."Amount Rounding Precision");
              Amount := "VAT Base Amount" + "VAT Amount";
            END;
        END;
        OnValidateVATBaseAmountOnBeforeValidateAmount(Rec,Currency);
        VALIDATE(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
        #30..38
        VALIDATE(Amount);
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT Base Amount"(Field 72).OnValidate".

        //trigger  VAT Base Amount"(Field 72)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        "Bal. VAT Base Amount" := ROUND("Bal. VAT Base Amount",Currency."Amount Rounding Precision");
        CASE "Bal. VAT Calculation Type" OF
          "Bal. VAT Calculation Type"::"Normal VAT",
          "Bal. VAT Calculation Type"::"Reverse Charge VAT":
            Amount :=
              ROUND(
                -"Bal. VAT Base Amount" * (1 + "Bal. VAT %" / 100),
                Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
          "Bal. VAT Calculation Type"::"Full VAT":
            if "Bal. VAT Base Amount" <> 0 Then
              FIELDERROR(
                "Bal. VAT Base Amount",
                STRSUBSTNO(
                  Text008,FieldCaption("Bal. VAT Calculation Type"),
                  "Bal. VAT Calculation Type"));
          "Bal. VAT Calculation Type"::"Sales Tax":
            if ("Bal. Gen. Posting Type" = "Bal. Gen. Posting Type"::Purchase) AND
               "Bal. Use Tax"
            Then BEGIN
              "Bal. VAT Amount" := 0;
              "Bal. VAT %" := 0;
              Amount := -"Bal. VAT Base Amount" - "Bal. VAT Amount";
            END else BEGIN
              "Bal. VAT Amount" :=
                SalesTaxCalculate.CalculateTax(
                  "Bal. Tax Area Code","Bal. Tax Group Code","Bal. Tax Liable",
                  "Posting Date","Bal. VAT Base Amount",Quantity,"Currency Factor");
              OnAfterSalesTaxCalculateCalculateTax(Rec,CurrFieldNo);
              if "Bal. VAT Base Amount" <> 0 Then
                "Bal. VAT %" := ROUND(100 * "Bal. VAT Amount" / "Bal. VAT Base Amount",0.00001)
              else
                "Bal. VAT %" := 0;
              "Bal. VAT Amount" :=
                ROUND("Bal. VAT Amount",Currency."Amount Rounding Precision");
              Amount := -"Bal. VAT Base Amount" - "Bal. VAT Amount";
            END;
        END;
        VALIDATE(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..28
        #30..39
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 91).OnValidate".

        //trigger  Posting Group"(Field 91)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] Then
          TESTFIELD("VAT Prod. Posting Group",'');

        CheckVATInAlloc;

        "VAT %" := 0;
        "VAT Calculation Type" := "VAT Calculation Type"::"Normal VAT";
        IsHandled := FALSE;
        OnValidateVATProdPostingGroupOnBeforeVATCalculationCheck(Rec,VATPostingSetup,IsHandled);
        if NOT IsHandled Then
          if "Gen. Posting Type" <> 0 Then BEGIN
            GetVATPostingSetup("VAT Bus. Posting Group","VAT Prod. Posting Group");
            "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
            CASE "VAT Calculation Type" OF
              "VAT Calculation Type"::"Normal VAT":
                "VAT %" := VATPostingSetup."VAT %";
              "VAT Calculation Type"::"Full VAT":
                CASE "Gen. Posting Type" OF
                  "Gen. Posting Type"::Sale:
                    TESTFIELD("Account No.",VATPostingSetup.GetSalesAccount(FALSE));
                  "Gen. Posting Type"::Purchase:
                    TESTFIELD("Account No.",VATPostingSetup.GetPurchAccount(FALSE));
                END;
            END;
          END;
        VALIDATE("VAT %");

        if JobTaskIsSet Then BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        if "Gen. Posting Type" <> 0 Then BEGIN
          if NOT VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group") Then
            VATPostingSetup.INIT;
          "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          CASE "VAT Calculation Type" OF
            "VAT Calculation Type"::"Normal VAT":
              "VAT %" := VATPostingSetup."VAT %";
            "VAT Calculation Type"::"Full VAT":
              CASE "Gen. Posting Type" OF
                "Gen. Posting Type"::Sale:
                  TESTFIELD("Account No.",VATPostingSetup.GetSalesAccount(FALSE));
                "Gen. Posting Type"::Purchase:
                  TESTFIELD("Account No.",VATPostingSetup.GetPurchAccount(FALSE));
              END;
          END;
        END;
        #26..31
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT Prod. Posting Group"(Field 93).OnValidate".

        //trigger  VAT Prod()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        Then
          TESTFIELD("Bal. VAT Prod. Posting Group",'');

        "Bal. VAT %" := 0;
        "Bal. VAT Calculation Type" := "Bal. VAT Calculation Type"::"Normal VAT";
        if "Bal. Gen. Posting Type" <> 0 Then BEGIN
          GetVATPostingSetup("Bal. VAT Bus. Posting Group","Bal. VAT Prod. Posting Group");
          "Bal. VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
          CASE "Bal. VAT Calculation Type" OF
            "Bal. VAT Calculation Type"::"Normal VAT":
              "Bal. VAT %" := VATPostingSetup."VAT %";
            "Bal. VAT Calculation Type"::"Full VAT":
              CASE "Bal. Gen. Posting Type" OF
                "Bal. Gen. Posting Type"::Sale:
                  TESTFIELD("Bal. Account No.",VATPostingSetup.GetSalesAccount(FALSE));
                "Bal. Gen. Posting Type"::Purchase:
                  TESTFIELD("Bal. Account No.",VATPostingSetup.GetPurchAccount(FALSE));
              END;
          END;
        END;
        VALIDATE("Bal. VAT %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
          if NOT VATPostingSetup.Get("Bal. VAT Bus. Posting Group","Bal. VAT Prod. Posting Group") Then
            VATPostingSetup.INIT;
        #10..23
        */
        //end;


        //Unsupported feature: Code Modification on ""Recipient Bank Account"(Field 288).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Account Type" = "Account Type"::Customer Then
          if CustBankAcc.Get("Account No.","Recipient Bank Account") Then
            "Bank Account Name" := CustBankAcc.Name
          else
            "Bank Account Name" := '';
        if "Account Type" = "Account Type"::Vendor Then
          if VendBankAcc.Get("Account No.","Recipient Bank Account") Then
            "Bank Account Name" := VendBankAcc.Name
          else
            "Bank Account Name" := '';

        if "Recipient Bank Account" = '' Then
          EXIT;
        if ("Document Type" IN ["Document Type"::Invoice,"Document Type"::" ","Document Type"::"Credit Memo"]) AND
           (("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) OR
            ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]))
        Then
          "Recipient Bank Account" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        if ("Document Type" = "Document Type"::Invoice) AND
        #15..18
        */
        //end;
    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Journal Template Name,Journal Batch Name,Line No."(Key)".


        //Unsupported feature: Property Insertion (MaintainSIFTIndex) on ""Journal Template Name,Journal Batch Name,Line No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Journal Batch Name,Journal Template Name"(Key)".

    }


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetLastModifiedDateTime;

    IsHandled := FALSE;
    OnModifyOnBeforeTestCheckPrinted(Rec,IsHandled);
    if NOT IsHandled Then
      TESTFIELD("Check Printed",FALSE);

    if ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') Then
      ClearCustVendApplnEntry;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetLastModifiedDateTime;

    TESTFIELD("Check Printed",FALSE);
    if ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') Then
      ClearCustVendApplnEntry;
    */
    //end;


    //Unsupported feature: Code Modification on "EmptyLine(PROCEDURE 5)".

    //procedure EmptyLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeEmptyLine(Rec,Result,IsHandled);
    if IsHandled Then
      EXIT(Result);
    EXIT(
      ("Account No." = '') AND (Amount = 0) AND
      (("Bal. Account No." = '') OR NOT "System-Created Entry"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #4..6
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateLineBalance(PROCEDURE 2)".

    //procedure UpdateLineBalance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Debit Amount" := 0;
    "Credit Amount" := 0;

    if ((Amount > 0) AND (NOT Correction)) OR
       ((Amount < 0) AND Correction)
    Then
      "Debit Amount" := Amount
    else
      if Amount <> 0 Then
        "Credit Amount" := -Amount;

    if "Currency Code" = '' Then
      "Amount (LCY)" := Amount;
    CASE TRUE OF
      ("Account No." <> '') AND ("Bal. Account No." <> ''):
        "Balance (LCY)" := 0;
      "Bal. Account No." <> '':
        "Balance (LCY)" := -"Amount (LCY)";
      else
        "Balance (LCY)" := "Amount (LCY)";
    END;

    OnUpdateLineBalanceOnAfterAssignBalanceLCY("Balance (LCY)");

    CLEAR(GenJnlAlloc);
    GenJnlAlloc.UpdateAllocations(Rec);

    UpdateSalesPurchLCY;

    if ("Deferral Code" <> '') AND (Amount <> xRec.Amount) AND ((Amount <> 0) AND (xRec.Amount <> 0)) Then
      VALIDATE("Deferral Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ((Amount > 0) AND (NOT Correction)) OR
       ((Amount < 0) AND Correction)
    Then BEGIN
      "Debit Amount" := Amount;
      "Credit Amount" := 0
    END else
      if Amount <> 0 Then BEGIN
        "Debit Amount" := 0;
        "Credit Amount" := -Amount;
      END;
    #12..31
    */
    //end;


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlTemplate.Get("Journal Template Name");
    GenJnlBatch.Get("Journal Template Name","Journal Batch Name");
    GenJnlLine.SetRange("Journal Template Name","Journal Template Name");
    GenJnlLine.SetRange("Journal Batch Name","Journal Batch Name");
    if GenJnlLine.FINDFIRST Then BEGIN
      "Posting Date" := LastGenJnlLine."Posting Date";
      "Document Date" := LastGenJnlLine."Posting Date";
      "Document No." := LastGenJnlLine."Document No.";
      OnSetUpNewLineOnBeforeIncrDocNo(GenJnlLine,LastGenJnlLine);
      if BottomLine AND
         (Balance - LastGenJnlLine."Balance (LCY)" = 0) AND
         NOT LastGenJnlLine.EmptyLine
      Then
        IncrementDocumentNo(GenJnlBatch,"Document No.");
    END else BEGIN
      "Posting Date" := WORKDATE;
      "Document Date" := WORKDATE;
      if GenJnlBatch."No. Series" <> '' Then BEGIN
        CLEAR(NoSeriesMgt);
        "Document No." := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series","Posting Date");
      END;
    END;
    if GenJnlTemplate.Recurring Then
      "Recurring Method" := LastGenJnlLine."Recurring Method";
    CASE GenJnlTemplate.Type OF
      GenJnlTemplate.Type::Payments:
        BEGIN
          "Account Type" := "Account Type"::Vendor;
          "Document Type" := "Document Type"::Payment;
        END;
      else BEGIN
        "Account Type" := LastGenJnlLine."Account Type";
        "Document Type" := LastGenJnlLine."Document Type";
      END;
    END;
    "Source Code" := GenJnlTemplate."Source Code";
    "Reason Code" := GenJnlBatch."Reason Code";
    "Posting No. Series" := GenJnlBatch."Posting No. Series";
    "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
    if ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset"]) AND
       ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset"])
    Then
      "Account Type" := "Account Type"::"G/L Account";
    VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
    Description := '';
    if GenJnlBatch."Suggest Balancing Amount" Then
      SuggestBalancingAmount(LastGenJnlLine,BottomLine);

    UpdateJournalBatchID;

    OnAfterSetupNewLine(Rec,GenJnlTemplate,GenJnlBatch,LastGenJnlLine,Balance,BottomLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    #10..51
    */
    //end;


    //Unsupported feature: Code Modification on "InitNewLine(PROCEDURE 94)".

    //procedure InitNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    "Posting Date" := PostingDate;
    "Document Date" := DocumentDate;
    Description := PostingDescription;
    "Shortcut Dimension 1 Code" := ShortcutDim1Code;
    "Shortcut Dimension 2 Code" := ShortcutDim2Code;
    "Dimension Set ID" := DimSetID;
    "Reason Code" := ReasonCode;
    OnAfterInitNewLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    */
    //end;


    //Unsupported feature: Code Modification on "CheckDocNoBasedOnNoSeries(PROCEDURE 74)".

    //procedure CheckDocNoBasedOnNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeCheckDocNoBasedOnNoSeries(Rec,LastDocNo,NoSeriesCode,NoSeriesMgtInstance,IsHandled);
    if IsHandled Then
      EXIT;

    if NoSeriesCode = '' Then
      EXIT;

    if (LastDocNo = '') OR ("Document No." <> LastDocNo) Then
      if "Document No." <> NoSeriesMgtInstance.GetNextNo(NoSeriesCode,"Posting Date",FALSE) Then
        NoSeriesMgtInstance.TestManualWithDocumentNo(NoSeriesCode,"Document No.");  // allow use of manual document numbers.
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..11
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 14)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeValidateShortcutDimCode(Rec,FieldNumber,ShortcutDimCode);

    TESTFIELD("Check Printed",FALSE);
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");

    OnAfterValidateShortcutDimCode(Rec,FieldNumber,ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Check Printed",FALSE);
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateApplyRequirements(PROCEDURE 21)".

    //procedure ValidateApplyRequirements();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
       (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor) OR
       (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Employee)
    Then
      CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

    OnBeforeValidateApplyRequirements(TempGenJnlLine,IsHandled);
    if IsHandled Then
      EXIT;

    CASE TempGenJnlLine."Account Type" OF
      TempGenJnlLine."Account Type"::Customer:
        if TempGenJnlLine."Applies-to ID" <> '' Then BEGIN
          CustLedgEntry.SETCURRENTKEY("Customer No.","Applies-to ID",Open);
          CustLedgEntry.SetRange("Customer No.",TempGenJnlLine."Account No.");
          CustLedgEntry.SetRange("Applies-to ID",TempGenJnlLine."Applies-to ID");
          CustLedgEntry.SetRange(Open,TRUE);
          if CustLedgEntry.FINDSET Then
            REPEAT
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,CustLedgEntry."Posting Date",CustLedgEntry."Document Type",CustLedgEntry."Document No.");
            UNTIL CustLedgEntry.NEXT = 0;
        END else
          if TempGenJnlLine."Applies-to Doc. No." <> '' Then BEGIN
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SetRange("Document No.",TempGenJnlLine."Applies-to Doc. No.");
            if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."Applies-to Doc. Type"::" " Then
              CustLedgEntry.SetRange("Document Type",TempGenJnlLine."Applies-to Doc. Type");
            CustLedgEntry.SetRange("Customer No.",TempGenJnlLine."Account No.");
            CustLedgEntry.SetRange(Open,TRUE);
            if CustLedgEntry.FINDFIRST Then
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,CustLedgEntry."Posting Date",CustLedgEntry."Document Type",CustLedgEntry."Document No.");
          END;
      TempGenJnlLine."Account Type"::Vendor:
        if TempGenJnlLine."Applies-to ID" <> '' Then BEGIN
          VendLedgEntry.SETCURRENTKEY("Vendor No.","Applies-to ID",Open);
          VendLedgEntry.SetRange("Vendor No.",TempGenJnlLine."Account No.");
          VendLedgEntry.SetRange("Applies-to ID",TempGenJnlLine."Applies-to ID");
          VendLedgEntry.SetRange(Open,TRUE);
          if VendLedgEntry.FINDSET Then
            REPEAT
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,VendLedgEntry."Posting Date",VendLedgEntry."Document Type",VendLedgEntry."Document No.");
            UNTIL VendLedgEntry.NEXT = 0;
        END else
          if TempGenJnlLine."Applies-to Doc. No." <> '' Then BEGIN
            VendLedgEntry.SETCURRENTKEY("Document No.");
            VendLedgEntry.SetRange("Document No.",TempGenJnlLine."Applies-to Doc. No.");
            if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."Applies-to Doc. Type"::" " Then
              VendLedgEntry.SetRange("Document Type",TempGenJnlLine."Applies-to Doc. Type");
            VendLedgEntry.SetRange("Vendor No.",TempGenJnlLine."Account No.");
            VendLedgEntry.SetRange(Open,TRUE);
            if VendLedgEntry.FINDFIRST Then
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,VendLedgEntry."Posting Date",VendLedgEntry."Document Type",VendLedgEntry."Document No.");
          END;
      TempGenJnlLine."Account Type"::Employee:
        if TempGenJnlLine."Applies-to ID" <> '' Then BEGIN
          EmplLedgEntry.SETCURRENTKEY("Employee No.","Applies-to ID",Open);
          EmplLedgEntry.SetRange("Employee No.",TempGenJnlLine."Account No.");
          EmplLedgEntry.SetRange("Applies-to ID",TempGenJnlLine."Applies-to ID");
          EmplLedgEntry.SetRange(Open,TRUE);
          if EmplLedgEntry.FINDSET Then
            REPEAT
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,EmplLedgEntry."Posting Date",EmplLedgEntry."Document Type",EmplLedgEntry."Document No.");
            UNTIL EmplLedgEntry.NEXT = 0;
        END else
          if TempGenJnlLine."Applies-to Doc. No." <> '' Then BEGIN
            EmplLedgEntry.SETCURRENTKEY("Document No.");
            EmplLedgEntry.SetRange("Document No.",TempGenJnlLine."Applies-to Doc. No.");
            if TempGenJnlLine."Applies-to Doc. Type" <> EmplLedgEntry."Applies-to Doc. Type"::" " Then
              EmplLedgEntry.SetRange("Document Type",TempGenJnlLine."Applies-to Doc. Type");
            EmplLedgEntry.SetRange("Employee No.",TempGenJnlLine."Account No.");
            EmplLedgEntry.SetRange(Open,TRUE);
            if EmplLedgEntry.FINDFIRST Then
              CheckIfPostingDateIsEarlier(
                TempGenJnlLine,EmplLedgEntry."Posting Date",EmplLedgEntry."Document Type",EmplLedgEntry."Document No.");
          END;
    END;

    OnAfterValidateApplyRequirements(TempGenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
       (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor)
    #4..6
    #11..19
              if TempGenJnlLine."Posting Date" < CustLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  CustLedgEntry."Document Type",CustLedgEntry."Document No.");
    #22..31
              if TempGenJnlLine."Posting Date" < CustLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  CustLedgEntry."Document Type",CustLedgEntry."Document No.");
    #34..42
              if TempGenJnlLine."Posting Date" < VendLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  VendLedgEntry."Document Type",VendLedgEntry."Document No.");
    #45..54
              if TempGenJnlLine."Posting Date" < VendLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  VendLedgEntry."Document Type",VendLedgEntry."Document No.");
    #57..65
              if TempGenJnlLine."Posting Date" < EmplLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  EmplLedgEntry."Document Type",EmplLedgEntry."Document No.");
    #68..77
              if TempGenJnlLine."Posting Date" < EmplLedgEntry."Posting Date" Then
                Error(
                  Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                  EmplLedgEntry."Document Type",EmplLedgEntry."Document No.");
    #80..83
    */
    //end;


    //Unsupported feature: Code Modification on "GetEmplLedgerEntry(PROCEDURE 183)".

    //procedure GetEmplLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Account Type" = "Account Type"::Employee) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '') AND (Amount = 0)
    Then BEGIN
      EmplLedgEntry.Reset;
      EmplLedgEntry.SetRange("Document No.","Applies-to Doc. No.");
      EmplLedgEntry.SetRange(Open,TRUE);
      if NOT EmplLedgEntry.FINDFIRST Then
        Error(NotExistErr,"Applies-to Doc. No.");

      VALIDATE("Account No.",EmplLedgEntry."Employee No.");
      EmplLedgEntry.CALCFIELDS("Remaining Amount");

      Amount := -EmplLedgEntry."Remaining Amount";

      SetAppliesToFields(EmplLedgEntry."Document Type",EmplLedgEntry."Document No.",'');

      GenJnlBatch.Get("Journal Template Name","Journal Batch Name");
      if GenJnlBatch."Bal. Account No." <> '' Then BEGIN
        "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
      END else
        VALIDATE(Amount);

      OnAfterGetEmplLedgerEntry(Rec,EmplLedgEntry);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
    END;

    OnAfterGetEmplLedgerEntry(Rec,EmplLedgEntry);
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "SetJournalLineFieldsFromApplication(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "SetJournalLineFieldsFromApplication(PROCEDURE 51)".

    //procedure SetJournalLineFieldsFromApplication();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Exported to Payment File" := FALSE;
    GetAccTypeAndNo(Rec,AccType,AccNo);
    CASE AccType OF
      AccType::Customer:
        if "Applies-to ID" <> '' Then BEGIN
          if FindFirstCustLedgEntryWithAppliesToID(AccNo,"Applies-to ID") Then BEGIN
            CustLedgEntry.SetRange("Exported to Payment File",TRUE);
            "Exported to Payment File" := CustLedgEntry.FINDFIRST;
          END
        END else
          if "Applies-to Doc. No." <> '' Then
            if FindFirstCustLedgEntryWithAppliesToDocNo(AccNo,"Applies-to Doc. No.") Then BEGIN
              "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
              "Applies-to Ext. Doc. No." := CustLedgEntry."External Document No.";
            END;
      AccType::Vendor:
        if "Applies-to ID" <> '' Then BEGIN
          if FindFirstVendLedgEntryWithAppliesToID(AccNo,"Applies-to ID") Then BEGIN
            VendLedgEntry.SetRange("Exported to Payment File",TRUE);
            "Exported to Payment File" := VendLedgEntry.FINDFIRST;
          END
        END else
          if "Applies-to Doc. No." <> '' Then
            if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo,"Applies-to Doc. No.") Then BEGIN
              "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
              "Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
            END;
      AccType::Employee:
        if "Applies-to ID" <> '' Then BEGIN
          if FindFirstEmplLedgEntryWithAppliesToID(AccNo,"Applies-to ID") Then BEGIN
            EmplLedgEntry.SetRange("Exported to Payment File",TRUE);
            "Exported to Payment File" := EmplLedgEntry.FINDFIRST;
          END
        END else
          if "Applies-to Doc. No." <> '' Then
            if FindFirstEmplLedgEntryWithAppliesToDocNo(AccNo,"Applies-to Doc. No.") Then
              "Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
    END;

    OnAfterSetJournalLineFieldsFromApplication(Rec,AccType,AccNo,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
    OnAfterSetJournalLineFieldsFromApplication(Rec,AccType,AccNo);
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromSalesHeader(PROCEDURE 103)".

    //procedure CopyFromSalesHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Source Currency Code" := SalesHeader."Currency Code";
    "Currency Factor" := SalesHeader."Currency Factor";
    "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
    Correction := SalesHeader.Correction;
    "EU 3-Party Trade" := SalesHeader."EU 3-Party Trade";
    "Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
    "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
    "Country/Region Code" := SalesHeader."VAT Country/Region Code";
    "VAT Registration No." := SalesHeader."VAT Registration No.";
    "Source Type" := "Source Type"::Customer;
    "Source No." := SalesHeader."Bill-to Customer No.";
    "Posting No. Series" := SalesHeader."Posting No. Series";
    "Ship-to/Order Address Code" := SalesHeader."Ship-to Code";
    "IC Partner Code" := SalesHeader."Bill-to IC Partner Code";
    "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
    "On Hold" := SalesHeader."On Hold";
    if "Account Type" = "Account Type"::Customer Then
      "Posting Group" := SalesHeader."Customer Posting Group";

    OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    #15..20
    */
    //end;


    //Unsupported feature: Code Modification on "GetDeferralAmount(PROCEDURE 88)".

    //procedure GetDeferralAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "VAT Base Amount" <> 0 Then
      DeferralAmount := "VAT Base Amount"
    else
      DeferralAmount := Amount;
    OnAfterGetDeferralAmount(Rec,DeferralAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DateFilterCalc) (VariableCollection) on "SetLastModifiedDateTime(PROCEDURE 1165)".



    //Unsupported feature: Code Modification on "SetLastModifiedDateTime(PROCEDURE 1165)".

    //procedure SetLastModifiedDateTime();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Modified DateTime" := DotNet_DateTimeOffset.ConvertToUtcDateTime(CURRENTDATETIME);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Modified DateTime" := DateFilterCalc.ConvertToUtcDateTime(CURRENTDATETIME);
    */
    //end;

    //Unsupported feature: Property Deletion (Name) on "EmptyLine(PROCEDURE 5).Result(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "EmptyLine(PROCEDURE 5).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckDocNoBasedOnNoSeries(PROCEDURE 74).IsHandled(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "ValidateApplyRequirements(PROCEDURE 21).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetJournalLineFieldsFromApplication(PROCEDURE 231).xGenJournalLine(Parameter 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "SetLastModifiedDateTime(PROCEDURE 1165)."DotNet_DateTimeOffset"(Variable 1000)".

}

