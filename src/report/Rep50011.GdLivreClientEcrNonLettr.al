namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Customer;
using System.Utilities;
using Microsoft.Sales.Receivables;
using Microsoft.Foundation.Period;
report 50011 "Gd Livre Client Ecr.Non Lettr."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/GdLivreClientEcrNonLettr.rdl';
    Caption = 'Customer Detail Trial Balance', Comment = 'FRA="Grand livre clients écritures non lettrées"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
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
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, ''))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ''))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Customer_TABLECAPTION__________Filter; Customer.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
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
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Currency_Filter; "Currency Filter")
            {
            }
            column(Customer_Detail_Trial_BalanceCaption; Customer_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_customers_that_only_have_balances_Caption; This_report_also_includes_customers_that_only_have_balances_CaptionLbl)
            {
            }
            column(Title_Open; Title_Open)
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
                column(STRSUBSTNO_Text009_EndDate_; STRSUBSTNO(Text009, EndDate))
                {
                }
                column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
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
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = field("No."),
                                   "Posting Date" = field("Date Filter"),
                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                   "Currency Code" = field("Currency Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = sorting("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code")
                                        where("Entry Type" = filter(<> Application));
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(BalanceLCY_Open; BalanceLCY_Open)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(DatePeriodTypeInt; DatePeriodTypeInt)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Currency_Code; "Currency Code")
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

                        OriginalLedgerEntry.GET("Cust. Ledger Entry No.");

                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";

                        DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                        CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";

                        // CALCUL DU SOLDE RESTANT ET DETERMINATION SI L'ECRITURE ETAIT OUVERTE DANS LA PERIODE
                        if ShowOnlyUnappliedWritings then begin
                            GRecCustLedgEntry.RESET();
                            if GRecCustLedgEntry.GET("Cust. Ledger Entry No.") then begin
                                GRecCustLedgEntry.SETRANGE("Date Filter", StartDate, EndDate);
                                //  GRecCustLedgEntry.SETRANGE("Posting Date",StartDate,EndDate); // Pour calculer le montant ouvert à date
                                GRecCustLedgEntry.CALCFIELDS("Remaining Amount");
                                if GRecCustLedgEntry."Remaining Amount" <> 0 then GBooOpen := true else GBooOpen := false;
                                if GRecCustLedgEntry."Remaining Amount" > 0 then begin
                                    GeneralDebitAmountLCY_Open := GeneralDebitAmountLCY_Open + GRecCustLedgEntry."Remaining Amount";
                                    GDecDebit := GRecCustLedgEntry."Remaining Amount";
                                    BalanceLCY_Open := BalanceLCY_Open + GRecCustLedgEntry."Remaining Amount";
                                end else
                                    GDecDebit := 0;

                                if GRecCustLedgEntry."Remaining Amount" < 0 then begin
                                    GeneralCreditAmountLCY_Open := GeneralCreditAmountLCY_Open + (GRecCustLedgEntry."Remaining Amount" * -1);
                                    GDecCredit := GRecCustLedgEntry."Remaining Amount" * -1;
                                    BalanceLCY_Open := BalanceLCY_Open + GRecCustLedgEntry."Remaining Amount";
                                end else
                                    GDecCredit := 0;
                                //BalanceLCY_Open := BalanceLCY_Open + GRecCustLedgEntry."Remaining Amount";
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
                            SETCURRENTKEY("Customer No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    DatePeriodTypeInt := Date."Period Type";
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly or (BalanceLCY = 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;

                // DELPHI AUB Calcul total lettré et non lettré 18.06.2019
                PreviousDebitAmountLCY_Open := 0;
                PreviousCreditAmountLCY_Open := 0;

                CustLedgEntry.SETCURRENTKEY(
                  "Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                CustLedgEntry.SETRANGE("Customer No.", "No.");
                CustLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                CustLedgEntry.SETFILTER(
                  "Entry Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9..%10',
                  CustLedgEntry."Entry Type"::"Initial Entry", CustLedgEntry."Entry Type"::"Unrealized Loss",
                  CustLedgEntry."Entry Type"::"Unrealized Gain", CustLedgEntry."Entry Type"::"Realized Loss",
                  CustLedgEntry."Entry Type"::"Realized Gain", CustLedgEntry."Entry Type"::"Payment Discount",
                  CustLedgEntry."Entry Type"::"Payment Discount (VAT Excl.)", CustLedgEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                  CustLedgEntry."Entry Type"::"Payment Tolerance", CustLedgEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)");
                if CustLedgEntry.FINDSET() then
                    repeat
                        PreviousDebitAmountLCY := PreviousDebitAmountLCY + CustLedgEntry."Debit Amount (LCY)";
                        PreviousCreditAmountLCY := PreviousCreditAmountLCY + CustLedgEntry."Credit Amount (LCY)";
                    until CustLedgEntry.NEXT() = 0;

                // DELPHI AUB 18.06.2019
                // Ecritures de l'exercice précédent non lettrées à la date de fin du calcul
                GRecCustLedgEntry.RESET();
                GRecCustLedgEntry.SETRANGE("Customer No.", "No.");
                GRecCustLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                if GRecCustLedgEntry.FINDSET() then
                    repeat
                        // DEB Calcul total lettré et non lettré 20.06.2019
                        GRecCustLedgEntry.SETRANGE("Date Filter", 0D, EndDate); // Ecritures de l'exercice précédent non lettrées à la date de fin du calcul

                        GRecCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                        if GRecCustLedgEntry."Remaining Amt. (LCY)" <> 0 then
                            //OLD PreviousDebitAmountLCY_Open := PreviousDebitAmountLCY_Open + GRecCustLedgEntry."Debit Amount (LCY)";
                            //OLD PreviousCreditAmountLCY_Open := PreviousCreditAmountLCY_Open + GRecCustLedgEntry."Credit Amount (LCY)";
                            if GRecCustLedgEntry."Remaining Amt. (LCY)" >= 0 then
                                PreviousDebitAmountLCY_Open := PreviousDebitAmountLCY_Open + GRecCustLedgEntry."Remaining Amt. (LCY)"
                            else
                                PreviousCreditAmountLCY_Open := PreviousCreditAmountLCY_Open - GRecCustLedgEntry."Remaining Amt. (LCY)";
                    // FIN Calcul total lettré et non lettré 20.06.2019
                    until GRecCustLedgEntry.NEXT() = 0;
                // END DELPHI AUB

                CustLedgEntry2.COPYFILTERS(CustLedgEntry);
                CustLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                if ExcludeBalanceOnly then begin
                    if CustLedgEntry2.COUNT > 0 then begin
                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                        // DEB Calcul total lettré et non lettré 20.06.2019
                        GeneralDebitAmountLCY_Open += PreviousDebitAmountLCY_Open;
                        GeneralCreditAmountLCY_Open += PreviousCreditAmountLCY_Open;
                        // FIN Calcul total lettré et non lettré 20.06.2019
                    end;
                end else begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    // DEB Calcul total lettré et non lettré 20.06.2019
                    GeneralDebitAmountLCY_Open += PreviousDebitAmountLCY_Open;
                    GeneralCreditAmountLCY_Open += PreviousCreditAmountLCY_Open;
                    // FIN Calcul total lettré et non lettré 20.06.2019
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;
                BalanceLCY_Open := PreviousDebitAmountLCY_Open - PreviousCreditAmountLCY_Open;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                // DEB Calcul total lettré et non lettré 20.06.2019
                DebitPeriodAmount_Open := 0;
                CreditPeriodAmount_Open := 0;

                //DEB MHR Solde ouvert de la période
                GRecCustLedgEntry.RESET();
                GRecCustLedgEntry.SETRANGE("Customer No.", "No.");
                GRecCustLedgEntry.SETRANGE("Posting Date", StartDate, EndDate);
                if GRecCustLedgEntry.FINDSET() then
                    repeat
                        // DEB Calcul total lettré et non lettré 31/08/2015
                        GRecCustLedgEntry.SETRANGE("Date Filter", StartDate, EndDate);

                        GRecCustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                        if GRecCustLedgEntry."Remaining Amt. (LCY)" <> 0 then
                            //OLD DebitPeriodAmount_Open :=  DebitPeriodAmount_Open + GRecCustLedgEntry."Debit Amount (LCY)";
                            //OLD CreditPeriodAmount_Open := CreditPeriodAmount_Open + GRecCustLedgEntry."Credit Amount (LCY)";
                            if GRecCustLedgEntry."Remaining Amt. (LCY)" >= 0 then
                                DebitPeriodAmount_Open := DebitPeriodAmount_Open + GRecCustLedgEntry."Remaining Amt. (LCY)"
                            else
                                CreditPeriodAmount_Open := CreditPeriodAmount_Open - GRecCustLedgEntry."Remaining Amt. (LCY)";
                    // FIN Calcul total lettré et non lettré 31/08/2015
                    until GRecCustLedgEntry.NEXT() = 0;
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
                AMG_Functions.VerifiyDateFilter(TextDate);
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
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(DocNumSortF; DocNumSort)
                    {
                        ApplicationArea = All;
                        Caption = 'Sorted by Document No.', Comment = 'FRA="Trié par n° document"';
                    }
                    field(ExcludeBalanceOnlyF; ExcludeBalanceOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Exclude Customers That Have a Balance Only', Comment = 'FRA="Exclure seulement les clients qui ont un solde ouvert"';
                        MultiLine = true;
                        Visible = false;
                    }
                    field(ShowOnlyUnappliedWritingsF; ShowOnlyUnappliedWritings)
                    {
                        Caption = 'Show Only Unapplied Writings', Comment = 'FRA="Montrer uniquement les écritures non lettrées "';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month;
    end;

    trigger OnPreReport()
    begin
        Filter := Customer.GETFILTERS;
        //DELPHI AUB 29.07.2019
        if ShowOnlyUnappliedWritings then
            GTxtDocumentTitle := 'Grand Livre Client:  écritures non lettrées'
        else
            GTxtDocumentTitle := 'Grand Livre Client Classique';
        //END DELPHI AUB
    end;

    var
        GRecCustLedgEntry: Record "Cust. Ledger Entry";
        OriginalLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        AMG_Functions: Codeunit AMG_Functions;
        FiltreDateCalc: codeunit "DateFilter-Calc";
        DocNumSort: Boolean;
        ExcludeBalanceOnly: Boolean;
        GBooOpen: Boolean;
        ShowOnlyUnappliedWritings: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        BalanceLCY: Decimal;
        BalanceLCY_Open: Decimal;
        CreditPeriodAmount: Decimal;
        CreditPeriodAmount_Open: Decimal;
        DebitPeriodAmount: Decimal;
        DebitPeriodAmount_Open: Decimal;
        GDecCredit: Decimal;
        GDecDebit: Decimal;
        GeneralCreditAmountLCY: Decimal;
        GeneralCreditAmountLCY_Open: Decimal;
        GeneralDebitAmountLCY: Decimal;
        GeneralDebitAmountLCY_Open: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PreviousCreditAmountLCY_Open: Decimal;
        PreviousDebitAmountLCY: Decimal;
        PreviousDebitAmountLCY_Open: Decimal;
        ReportCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        DatePeriodTypeInt: Integer;
        BalanceCaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Suite"';
        CreditCaptionLbl: Label 'Credit', Comment = 'FRA="Crédit"';
        Current_pageCaptionLbl: Label 'Current page', Comment = 'FRA="Page courante"';
        Customer_Detail_Trial_BalanceCaptionLbl: Label 'Customer Detail Trial Balance', Comment = 'FRA="Grand livre clients écr. non lettrées"';
        DebitCaptionLbl: Label 'Debit', Comment = 'FRA="Débit"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        Document_No_CaptionLbl: Label 'Document No.', Comment = 'FRA="N° document"';
        External_Document_No_CaptionLbl: Label 'External Document No.', Comment = 'FRA="N° doc. externe"';
        Grand_TotalCaptionLbl: Label 'Grand Total', Comment = 'FRA="Total général"';
        Posting_DateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        Previous_pageCaptionLbl: Label 'Previous page', Comment = 'FRA="Page précédente"';
        Source_CodeCaptionLbl: Label 'Source Code', Comment = 'FRA="Code journal"';
        Text001: Label 'You must fill in the %1 field.', Comment = 'FRA="Vous devez renseigner le champ %1."';
        Text002: Label 'You must specify a Starting Date.', Comment = 'FRA="Vous devez spécifier une date de début."';
        Text003: Label 'Printed by %1', Comment = 'FRA="Imprimé par %1"';
        Text004: Label 'Fiscal Year Start Date : %1', Comment = 'FRA="Début exercice comptable : %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Balance at %1 ', Comment = 'FRA="Solde au %1 "';
        Text007: Label 'Balance at %1', Comment = 'FRA="Solde au %1"';
        Text008: Label 'Total', Comment = 'FRA="Total"';
        Text009: Label 'Solde Non-lettré au %1', Comment = 'FRA="Solde Non-lettré au %1"';
        This_report_also_includes_customers_that_only_have_balances_CaptionLbl: Label 'This report also includes customers that only have balances.', Comment = 'FRA="Cet état inclut aussi les clients ne présentant que des soldes."';
        Title_Open: Label 'Affiche les écritures Clients non lettrées', Comment = 'FRA="Affiche les écritures Clients non lettrées"';
        To_be_continuedCaptionLbl: Label 'To be continued', Comment = 'FRA="À suivre"';
        Total_Date_RangeCaptionLbl: Label 'Total Date Range', Comment = 'FRA="Total plage de dates"';
        TotalBy: Option Date,Week,Month,Quarter,Year;
        "Filter": Text;
        TextDate: Text;
        GTxtDocumentTitle: Text[80];
}

