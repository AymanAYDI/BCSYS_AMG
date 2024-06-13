namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Ledger;
using System.Utilities;
using Microsoft.Foundation.Period;
using Microsoft.Purchases.History;
using Microsoft.Sales.History;
report 50204 "G/L Detail Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/GLDetailTrialBalance.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'G/L Detail Trial Balance', Comment = 'FRA="Grand livre comptes généraux"';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(COMPANYNAME; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(GLAccountTABLECAPTIONAndFilter; "G/L Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(No_GLAccount; "No.")
            {
            }
            column(Name_GLAccount; Name)
            {
            }
            column(DebitAmount_GLAccount; "G/L Account"."Debit Amount")
            {
            }
            column(CreditAmount_GLAccount; "G/L Account"."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(DebitAmount_GLAccount2; GLAccount2."Debit Amount")
            {
            }
            column(CreditAmount_GLAccount2; GLAccount2."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
            {
            }
            column(ShowBodyGLAccount; ShowBodyGLAccount)
            {
            }
            column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(G_L_Detail_Trial_BalanceCaption; G_L_Detail_Trial_BalanceCaptionLbl)
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
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
                PrintOnlyIfDetail = true;
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(Date_PeriodNo; Date."Period No.")
                {
                }
                column(PostingYear; DATE2DMY("G/L Entry"."Posting Date", 3))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = field("No."),
                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.");
                    column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(SourceCode_GLEntry; "Source Code")
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(ExternalDocumentNo_GLEntry; "External Document No.")
                    {
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(Balance; Balance)
                    {
                    }
                    column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
                    {
                    }
                    column(Date_PeriodType_PeriodName; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(TotalByInt; TotalByInt)
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(Description_Nom_Ref; GTxtDescription)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        LRecPurchaseInvoiceHeader: Record "Purch. Inv. Header";
                        LRecSalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        if ("Debit Amount" = 0) and
                           ("Credit Amount" = 0)
                        then
                            CurrReport.SKIP();
                        Balance := Balance + "Debit Amount" - "Credit Amount";
                        //DELPHI AUB 14.02.2020
                        Solde := Solde + "Debit Amount" - "Credit Amount";
                        //END DELPHI AUB 14.02.2020
                        GTxtDescription := '';
                        if "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice then
                            if LRecSalesInvoiceHeader.GET("G/L Entry"."Document No.") then
                                GTxtDescription := LRecSalesInvoiceHeader."Sell-to Customer Name" + ' Ref: ' + LRecSalesInvoiceHeader."Your Reference"
                            else
                                if LRecPurchaseInvoiceHeader.GET("G/L Entry"."Document No.") then
                                    GTxtDescription := LRecPurchaseInvoiceHeader."Buy-from Vendor Name" + ' - Ref: ' + LRecPurchaseInvoiceHeader."Vendor Invoice No.";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //DELPHI AUB 13.02.2020
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                Solde := 0;
                //END DELPHI AUB 13.02.2020
                GLAccount2.COPY("G/L Account");
                if GLAccount2."Income/Balance" = 0 then
                    GLAccount2.SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate)
                else
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                GLAccount2.Balance := GLAccount2."Debit Amount" - GLAccount2."Credit Amount";
                if "Income/Balance" = 0 then
                    SETRANGE("Date Filter", StartDate, EndDate)
                else
                    SETRANGE("Date Filter", 0D, EndDate);
                CALCFIELDS("Debit Amount", "Credit Amount");
                if ("Debit Amount" = 0) and ("Credit Amount" = 0) then
                    CurrReport.SKIP();

                //DELPHI AUB 13.02.2020
                PreviousDebitAmountLCY := GLAccount2."Debit Amount";
                PreviousCreditAmountLCY := GLAccount2."Credit Amount";
                Solde := PreviousDebitAmountLCY - PreviousCreditAmountLCY;
                //END DELPHI AUB 13.02.2020

                ShowBodyGLAccount :=
                  ((GLAccount2."Debit Amount" = "Debit Amount") and (GLAccount2."Credit Amount" = "Credit Amount")) or ("Account Type".AsInteger() <> 0);
            end;

            trigger OnPreDataItem()
            var
                AMG_Functions: Codeunit AMG_Functions;
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                Period.SETRANGE("Period Start", StartDate);
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text010, StartDate, Period.GETFILTER("Period Type"));
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                DateFilterCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                AMG_Functions.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
                CLEAR(Period);
                Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text011, EndDate, Period.GETFILTER("Period Type"));
                FiscalYearStatusText := STRSUBSTNO(Text012, AMG_Functions.CheckFiscalYearStatus(CopyStr(GETFILTER("Date Filter"), 1, 30)));

                TotalByInt := TotalBy;
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
                    field(SummarizeBy; TotalBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Summarize by', Comment = 'FRA="Totaliser par"';
                        OptionCaption = ' ,Week,Month,Quarter,Year', Comment = 'FRA=" ,Semaine,Mois,Trimestre,Année"';
                    }
                    field(SortedByDocumentNo; DocNumSort)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sorted by Document No.', Comment = 'FRA="Trié par n° document"';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month
    end;

    trigger OnPreReport()
    begin
        Filter := "G/L Account".GETFILTERS;
    end;

    var
        Period: Record Date;
        GLAccount2: Record "G/L Account";
        DateFilterCalc: codeunit "DateFilter-Calc";
        DocNumSort: Boolean;
        ShowBodyGLAccount: Boolean;
        EndDate: Date;
        PreviousEndDate: Date;
        PreviousStartDate: Date;
        StartDate: Date;
        Balance: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PreviousDebitAmountLCY: Decimal;
        Solde: Decimal;
        TotalByInt: Integer;
        BalanceCaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        CreditCaptionLbl: Label 'Credit', Comment = 'FRA="Crédit"';
        DebitCaptionLbl: Label 'Debit', Comment = 'FRA="Débit"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        Document_No_CaptionLbl: Label 'Document No.', Comment = 'FRA="N° document"';
        External_Document_No_CaptionLbl: Label 'External Document No.', Comment = 'FRA="N° doc. externe"';
        G_L_Detail_Trial_BalanceCaptionLbl: Label 'G/L Detail Trial Balance', Comment = 'FRA="Grand livre comptes généraux"';
        Grand_TotalCaptionLbl: Label 'Grand Total', Comment = 'FRA="Total général"';
        Posting_DateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        Source_CodeCaptionLbl: Label 'Source Code', Comment = 'FRA="Code journal"';
        Text001: Label 'You must fill in the %1 field.', Comment = 'FRA="Vous devez renseigner le champ %1."';
        Text002: Label 'You must specify a Starting Date.', Comment = 'FRA="Vous devez spécifier une date de début."';
        Text003: Label 'Printed by %1', Comment = 'FRA="Imprimé par %1"';
        Text004: Label 'Fiscal Year Start Date : %1', Comment = 'FRA="Début exercice comptable : %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Balance at %1 ', Comment = 'FRA="Solde au %1 "';
        Text007: Label 'Balance at %1', Comment = 'FRA="Solde au %1"';
        Text008: Label 'Total', Comment = 'FRA="Total"';
        Text010: Label 'The selected starting date %1 is not the start of a %2.', Comment = 'FRA="La date de début choisie (%1) ne correspond pas au début de %2."';
        Text011: Label 'The selected ending date %1 is not the end of a %2.', Comment = 'FRA="La date de fin choisie (%1) ne correspond pas à la fin de %2."';
        Text012: Label 'Fiscal-Year Status: %1', Comment = 'FRA="Statut de l''exercice comptable : %1"';
        Total_Date_RangeCaptionLbl: Label 'Total Date Range', Comment = 'FRA="Total plage de dates"';
        TotalBy: Option " ",Week,Month,Quarter,Year;
        "Filter": Text;
        FiscalYearStatusText: Text;
        TextDate: Text[30];
        GTxtDescription: Text[250];
}

