namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Vendor;
using System.Utilities;
using Microsoft.Purchases.Payables;
using Microsoft.Foundation.Period;
report 50012 "Gd Livre Fourn. Ecr.Non Lettr."
{
    DefaultLayout = RDLC;
    RDLCLayout = './GdLivreFournEcrNonLettr.rdlc';
    Caption = 'Vendor Detail Trial Balance';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO()))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Vendor_TABLECAPTION__________Filter; Vendor.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(ReportDebitAmountLCY; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(STRSUBSTNO_Text009_PreviousEndDate_; STRSUBSTNO(Text009, PreviousEndDate))
            {
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY; GeneralDebitAmountLCY)
            {
            }
            column(GeneralCreditAmountLCY; GeneralCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY_GeneralCreditAmountLCY; GeneralDebitAmountLCY - GeneralCreditAmountLCY)
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Vendor_Currency_Filter; "Currency Filter")
            {
            }
            column(Vendor_Detail_Trial_BalanceCaption; Vendor_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_vendors_that_only_have_balances_Caption; This_report_also_includes_vendors_that_only_have_balances_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(AffichageEcrituresOuvertes; ShowOnlyUnappliedWritings)
            {
            }
            column(PreviousDebitAmountLCY_Open; PreviousDebitAmountLCY_Open)
            {
            }
            column(PreviousCreditAmountLCY_Open; PreviousCreditAmountLCY_Open)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY_Open; PreviousDebitAmountLCY_Open - PreviousCreditAmountLCY_Open)
            {
            }
            column(GTxtDocumentTitle; GTxtDocumentTitle)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY_; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Open; (DebitPeriodAmount_Open + PreviousDebitAmountLCY_Open) - (CreditPeriodAmount_Open + PreviousCreditAmountLCY_Open))
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Open; CreditPeriodAmount_Open + PreviousCreditAmountLCY_Open)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Open; DebitPeriodAmount_Open + PreviousDebitAmountLCY_Open)
                {
                }
                column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
                {
                }
                column(Date__Period_Name_; Date."Period Name")
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(STRSUBSTNO_Text009_EndDate_; STRSUBSTNO(Text009, EndDate))
                {
                }
                column(DebitPeriodAmount; DebitPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Control1120082; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(CreditPeriodAmount; CreditPeriodAmount)
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Control1120086; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_CreditPeriodAmount; DebitPeriodAmount - CreditPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Control1120090; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor No." = field("No."),
                                   "Posting Date" = field("Date Filter"),
                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                   "Currency Code" = field("Currency Filter");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = sorting("Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code")
                                        where("Entry Type" = filter(<> Application));
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(BalanceLCY_Open; BalanceLCY_Open)
                    {
                    }
                    column(Det_Vendor_L_E___Entry_No__; "Detailed Vendor Ledg. Entry"."Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(FooterEnable; not (Date."Period Type" = Date."Period Type"::Year))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Vendor_No_; "Vendor No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Currency_Code; "Currency Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(PostingYearValue; FORMAT(DATE2DMY("Posting Date", 3)))
                    {
                    }
                    column(EcritureOuverte; GBooOpen)
                    {
                    }
                    column(GDecDebit; GDecDebit)
                    {
                    }
                    column(GDecCredit; GDecCredit)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.SKIP();
                        BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";

                        DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                        CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";

                        // CALCUL DU SOLDE RESTANT ET DETERMINATION SI L'ECRITURE ETAIT OUVERTE DANS LA PERIODE
                        if ShowOnlyUnappliedWritings then begin
                            GRecVendLedgEntry.RESET();
                            if GRecVendLedgEntry.GET("Vendor Ledger Entry No.") then begin
                                GRecVendLedgEntry.SETRANGE("Date Filter", StartDate, EndDate);
                                //  GRecCustLedgEntry.SETRANGE("Posting Date",StartDate,EndDate); // Pour calculer le montant ouvert à date
                                GRecVendLedgEntry.CALCFIELDS("Remaining Amount");
                                if GRecVendLedgEntry."Remaining Amount" <> 0 then GBooOpen := true else GBooOpen := false;
                                if GRecVendLedgEntry."Remaining Amount" > 0 then begin
                                    GeneralDebitAmountLCY_Open := GeneralDebitAmountLCY_Open + GRecVendLedgEntry."Remaining Amount";
                                    GDecDebit := GRecVendLedgEntry."Remaining Amount";
                                    BalanceLCY_Open := BalanceLCY_Open + GRecVendLedgEntry."Remaining Amount";
                                end else begin
                                    GDecDebit := 0;
                                end;

                                if GRecVendLedgEntry."Remaining Amount" < 0 then begin
                                    GeneralCreditAmountLCY_Open := GeneralCreditAmountLCY_Open + (GRecVendLedgEntry."Remaining Amount" * -1);
                                    GDecCredit := GRecVendLedgEntry."Remaining Amount" * -1;
                                    BalanceLCY_Open := BalanceLCY_Open + GRecVendLedgEntry."Remaining Amount";
                                end else begin
                                    GDecCredit := 0;
                                end;
                                //BalanceLCY_Open := BalanceLCY_Open + GRecVendLedgEntry."Remaining Amount";
                            end;
                        end;
                        // MHR
                    end;

                    trigger OnPostDataItem()
                    begin
                        ReportDebitAmountLCY := ReportDebitAmountLCY + "Debit Amount (LCY)";
                        ReportCreditAmountLCY := ReportCreditAmountLCY + "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SETCURRENTKEY("Vendor No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly or (BalanceLCY = 0);

                    CurrReport.CREATETOTALS("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)", "Detailed Vendor Ledg. Entry"."Credit Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;

                // DELPHI AUB Calcul total lettré et non lettré 25.06.2019
                PreviousDebitAmountLCY_Open := 0;
                PreviousCreditAmountLCY_Open := 0;

                VendLedgEntry.SETCURRENTKEY(
                  "Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                VendLedgEntry.SETRANGE("Vendor No.", "No.");
                VendLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                VendLedgEntry.SETFILTER(
                  "Entry Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9..%10',
                  VendLedgEntry."Entry Type"::"Initial Entry", VendLedgEntry."Entry Type"::"Unrealized Loss",
                  VendLedgEntry."Entry Type"::"Unrealized Gain", VendLedgEntry."Entry Type"::"Realized Loss",
                  VendLedgEntry."Entry Type"::"Realized Gain", VendLedgEntry."Entry Type"::"Payment Discount",
                  VendLedgEntry."Entry Type"::"Payment Discount (VAT Excl.)", VendLedgEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                  VendLedgEntry."Entry Type"::"Payment Tolerance", VendLedgEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)");
                if VendLedgEntry.FINDSET() then
                    repeat
                        PreviousDebitAmountLCY := PreviousDebitAmountLCY + VendLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY := PreviousCreditAmountLCY + VendLedgEntry."Credit Amount (LCY)";
                    until VendLedgEntry.NEXT() = 0;

                // DELPHI AUB 25.06.2019
                // Ecritures de l'exercice précédent non lettrées à la date de fin du calcul
                GRecVendLedgEntry.RESET();
                GRecVendLedgEntry.SETRANGE("Vendor No.", "No.");
                GRecVendLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                if GRecVendLedgEntry.FINDSET() then
                    repeat
                        // DEB Calcul total lettré et non lettré 20.06.2019
                        GRecVendLedgEntry.SETRANGE("Date Filter", 0D, EndDate); // Ecritures de l'exercice précédent non lettrées à la date de fin du calcul

                        GRecVendLedgEntry.CALCFIELDS("Remaining Amt. (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                        if GRecVendLedgEntry."Remaining Amt. (LCY)" <> 0 then begin
                            //OLD PreviousDebitAmountLCY_Open := PreviousDebitAmountLCY_Open + GRecCustLedgEntry."Debit Amount (LCY)";
                            //OLD PreviousCreditAmountLCY_Open := PreviousCreditAmountLCY_Open + GRecCustLedgEntry."Credit Amount (LCY)";
                            if GRecVendLedgEntry."Remaining Amt. (LCY)" >= 0 then
                                PreviousDebitAmountLCY_Open := PreviousDebitAmountLCY_Open + GRecVendLedgEntry."Remaining Amt. (LCY)"
                            else
                                PreviousCreditAmountLCY_Open := PreviousCreditAmountLCY_Open - GRecVendLedgEntry."Remaining Amt. (LCY)";

                        end;
                    // FIN Calcul total lettré et non lettré 20.06.2019
                    until GRecVendLedgEntry.NEXT() = 0;
                // END DELPHI AUB


                VendLedgEntry2.COPYFILTERS(VendLedgEntry);
                VendLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                if ExcludeBalanceOnly then begin
                    if VendLedgEntry2.COUNT > 0 then begin
                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                        // DEB Calcul total lettré et non lettré 25.06.2019
                        GeneralDebitAmountLCY_Open += PreviousDebitAmountLCY_Open;
                        GeneralCreditAmountLCY_Open += PreviousCreditAmountLCY_Open;
                        // FIN Calcul total lettré et non lettré 25.06.2019
                    end;
                end else begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    // DEB Calcul total lettré et non lettré 25.06.2019
                    GeneralDebitAmountLCY_Open += PreviousDebitAmountLCY_Open;
                    GeneralCreditAmountLCY_Open += PreviousCreditAmountLCY_Open;
                    // FIN Calcul total lettré et non lettré 25.06.2019
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;
                BalanceLCY_Open := PreviousDebitAmountLCY_Open - PreviousCreditAmountLCY_Open; //DELPHI AUB 29.07.19

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                // DEB Calcul total lettré et non lettré 25.06.2019
                DebitPeriodAmount_Open := 0;
                CreditPeriodAmount_Open := 0;

                //DEB MHR Solde ouvert de la période
                GRecVendLedgEntry.RESET();
                GRecVendLedgEntry.SETRANGE("Vendor No.", "No.");
                GRecVendLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
                if GRecVendLedgEntry.FINDSET() then
                    repeat
                        // DEB Calcul total lettré et non lettré 31/08/2015
                        GRecVendLedgEntry.SETRANGE("Date Filter", StartDate, EndDate);

                        GRecVendLedgEntry.CALCFIELDS("Remaining Amt. (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                        if GRecVendLedgEntry."Remaining Amt. (LCY)" <> 0 then begin
                            //OLD DebitPeriodAmount_Open :=  DebitPeriodAmount_Open + GRecCustLedgEntry."Debit Amount (LCY)";
                            //OLD CreditPeriodAmount_Open := CreditPeriodAmount_Open + GRecCustLedgEntry."Credit Amount (LCY)";
                            if GRecVendLedgEntry."Remaining Amt. (LCY)" >= 0 then
                                DebitPeriodAmount_Open := DebitPeriodAmount_Open + GRecVendLedgEntry."Remaining Amt. (LCY)"
                            else
                                CreditPeriodAmount_Open := CreditPeriodAmount_Open - GRecVendLedgEntry."Remaining Amt. (LCY)";

                        end;
                    // FIN Calcul total lettré et non lettré 31/08/2015
                    until GRecVendLedgEntry.NEXT() = 0;
                // FIN MHR


                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly or (BalanceLCY = 0);
            end;

            trigger OnPreDataItem()
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocNumSort; DocNumSort)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sorted by Document No.';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude Vendors That Have A Balance Only';
                        MultiLine = true;
                        Visible = false;
                    }
                    field(ShowOnlyUnappliedWritings; ShowOnlyUnappliedWritings)
                    {
                        Caption = 'Show Only Unapplied Writings';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month;
    end;

    trigger OnPreReport()
    begin
        Filter := Vendor.GETFILTERS;
        //DELPHI AUB 29.07.2019
        if ShowOnlyUnappliedWritings then
            GTxtDocumentTitle := 'Grand Livre Fourn.:  écritures non lettrées'
        else
            GTxtDocumentTitle := 'Grand Livre Fourn. Classique';
        //END DELPHI AUB
    end;

    var
        Text001: Label 'You must fill in the %1 field.';
        Text002: Label 'You must specify a Starting Date.';
        Text003: Label 'Printed by %1';
        Text004: Label 'Fiscal Year Start Date : %1';
        Text005: Label 'Page %1';
        Text006: Label 'Balance at %1 ';
        Text007: Label 'Balance at %1';
        Text008: Label 'Total';
        VendLedgEntry: Record 380;
        OriginalLedgerEntry: Record 25;
        VendLedgEntry2: Record 380;
        FiltreDateCalc: codeunit "DateFilter-Calc";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        BalanceLCY: Decimal;
        TotalBy: Option Date,Week,Month,Quarter,Year;
        DocNumSort: Boolean;
        "Filter": Text;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        GeneralCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;
        ExcludeBalanceOnly: Boolean;
        Vendor_Detail_Trial_BalanceCaptionLbl: Label 'Vendor Detail Trial Balance';
        This_report_also_includes_vendors_that_only_have_balances_CaptionLbl: Label 'This report also includes vendors that only have balances.';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Source_CodeCaptionLbl: Label 'Source Code';
        Document_No_CaptionLbl: Label 'Document No.';
        External_Document_No_CaptionLbl: Label 'External Document No.';
        DescriptionCaptionLbl: Label 'Description';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        BalanceCaptionLbl: Label 'Balance';
        ContinuedCaptionLbl: Label 'Continued';
        To_be_continuedCaptionLbl: Label 'To be continued';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Total_Date_RangeCaptionLbl: Label 'Total Date Range';
        Previous_pageCaptionLbl: Label 'Previous page';
        Current_pageCaptionLbl: Label 'Current page';
        PreviousDebitAmountLCY_Open: Decimal;
        PreviousCreditAmountLCY_Open: Decimal;
        GRecVendLedgEntry: Record 25;
        GBooOpen: Boolean;
        GeneralDebitAmountLCY_Open: Decimal;
        GeneralCreditAmountLCY_Open: Decimal;
        BalanceLCY_Open: Decimal;
        DebitPeriodAmount_Open: Decimal;
        CreditPeriodAmount_Open: Decimal;
        ShowOnlyUnappliedWritings: Boolean;
        GDecDebit: Decimal;
        GDecCredit: Decimal;
        Text009: Label 'Solde Non-lettré au %1';
        GTxtDocumentTitle: Text[80];
}
