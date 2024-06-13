namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
using System.Utilities;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Team;
using Microsoft.Sales.Customer;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Finance.Currency;
using Microsoft.Bank.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using Microsoft.Sales.Posting;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Inventory.Item;
using System.EMail;
report 50303 "Standard Sales - Draft Invoice"
{
    RDLCLayout = './src/report/rdl/StandardSalesDraftInvoice.rdl';
    WordLayout = './src/report/rdl/StandardSalesDraftInvoice.docx';
    Caption = 'Draft Invoice', Comment = 'FRA="Facture provisoire"';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    UsageCategory = None;
    ApplicationArea = All;
    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Invoice));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Draft Invoice', Comment = 'FRA="Facture provisoire"';
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyInfoPays; GTxtCompanyInfoPays)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; GTxtBankName)
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; GTxtBankBranchNo)
            {
            }
            column(CompanyBankBranchNo_Lbl; GTxtCompanyBankBranch)
            {
            }
            column(CompanyBankAccountNo; GTxtBankAcountNo)
            {
            }
            column(CompanyBankAccountNo_Lbl; GTxtCompanyBankNr)
            {
            }
            column(CompanyIBAN; GTxtBankIBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FIELDCAPTION(IBAN))
            {
            }
            column(CompanySWIFT; GTxtBankSwift)
            {
            }
            column(CompanySWIFT_Lbl; GTxtCompanyBankSWIFT)
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyLegalOffice; '')
            {
            }
            column(CompanyLegalOffice_Lbl; '')
            {
            }
            column(CompanyCustomGiro; '')
            {
            }
            column(CompanyCustomGiro_Lbl; '')
            {
            }
            column(CompanyLegalStatement; GetLegalStatement())
            {
            }
            column(CompanyNoEORI; CompanyInfo."No. EORI")
            {
            }
            column(CompanyNoEORI_Lbl; CompanyInfo.FIELDCAPTION("No. EORI"))
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference__Lbl; FIELDCAPTION("Your Reference"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo__Lbl; FIELDCAPTION("External Document No."))
            {
            }
            column(ShipmentMethodDescription; GTxtCondLivraisonEtendues)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FIELDCAPTION("Bill-to Customer No."))
            {
            }
            column(DocumentDate; FORMAT("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FIELDCAPTION("Document Date"))
            {
            }
            column(DueDate; FORMAT("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FIELDCAPTION("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvoiceNoText)
            {
            }
            column(InvoiceNoPosition_Lbl; NextInvoiceNo)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FIELDCAPTION("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; FORMAT("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; GTxtCompanySalespers)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; GTxtCustomerNum)
            {
            }
            column(SelltoAddress1; GTxtSelltoAddr[1])
            {
            }
            column(SelltoAddress2; GTxtSelltoAddr[2])
            {
            }
            column(SelltoAddress3; GTxtSelltoAddr[3])
            {
            }
            column(SelltoAddress4; GTxtSelltoAddr[4])
            {
            }
            column(SelltoAddress5; GTxtSelltoAddr[5])
            {
            }
            column(SelltoAddress6; GTxtSelltoAddr[6])
            {
            }
            column(SelltoAddress7; GTxtSelltoAddr[7])
            {
            }
            column(SelltoAddress8; GTxtSelltoAddr[8])
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(VATRegistrationNo_Lbl; GTxtCompanyVAT)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber())
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl())
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType())
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl())
            {
            }
            column(EMail_Lbl; GTxtCompanyHomepage)
            {
            }
            column(HomePage_Lbl; GTxtCompanyHomepage)
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(From_Lbl; FromLbl)
            {
            }
            column(BilledTo_Lbl; BilledToLbl)
            {
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(Questions_Lbl; QuestionsLbl)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText())
            {
            }
            column(DocumentTitle_Lbl; DocumentTitleText)
            {
            }
            column(YourDocumentTitle_Lbl; YourDocumentTitleText)
            {
            }
            column(Thanks_Lbl; ThanksLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TABLECAPTION)
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
            {
            }
            column(CompanyGesch; GTxtCompanyGesch)
            {
            }
            column(CompanyTrib; GTxtCompanyTrib)
            {
            }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(ShipAgent; Cust."Shipping Agent Code")
            {
            }
            column(NomTransporteur; GTxtTransporteur)
            {
            }
            column(MentionLegalFR; GTxTMentionLegaleFR)
            {
            }
            column(NumTVAClient_Lbl; GTxtNumTVAClient_Lbl)
            {
            }
            column(NumTVAClient; GTxtNumTVAClient)
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                UseTemporary = true;
                column(LineNo_Line; "Line No.")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FIELDCAPTION(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FIELDCAPTION("Amount Including VAT"))
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(Description2_Line; Line."Description 2")
                {
                }
                column(Description_Line_Lbl; FIELDCAPTION(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FIELDCAPTION("Line Amount"))
                {
                }
                column(ItemNo_Line; GTxtItemNo)
                {
                }
                column(ItemNo_Line_Lbl; GTxtItemNo_Line_Lbl)
                {
                }
                column(ShipmentDate_Line; FORMAT("Shipment Date"))
                {
                }
                column(ShipmentDate_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; Quantity)
                {
                }
                column(Quantity_Line_Lbl; GTxtQuantity_Line_Lbl)
                {
                }
                column(Type_Line; FORMAT(Type))
                {
                }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; GTxtUnitPrice_Lbl)
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; GTxtUnitOfMeasure_Lbl)
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FIELDCAPTION("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FIELDCAPTION("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(Qty_Lbl; QtyLbl)
                {
                }
                column(Price_Lbl; PriceLbl)
                {
                }
                column(PricePer_Lbl; PricePerLbl)
                {
                }
                column(NomenclatureArticle; GTxtNomenclatureArticle)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := STRSUBSTNO('%1%', -ROUND("Line Discount %", 0.1));

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if "VAT Clause Code" <> '' then
                        if VATAmountLine.GET("VAT Identifier", "VAT Calculation Type", "Tax Group Code", false, "Line Amount" >= 0) then begin
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.MODIFY();
                        end;

                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

                    if FirstLineHasBeenOutput then
                        CLEAR(CompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    // DEB DELPHI XAV
                    if GRecItem.GET(Line."No.") then
                        GTxtNomenclatureArticle := GRecItem."Tariff No."
                    else
                        GTxtNomenclatureArticle := '';

                    //DELPHI AUB 18/02/2019
                    GTxtItemNo := Line."No.";
                    if Line.Type = Line.Type::Item then
                        if Line."Item Reference No." <> '' then
                            GTxtItemNo := Line."Item Reference No.";
                    //END DELPHI AUB
                end;

                trigger OnPreDataItem()
                begin
                    MoreLines := FIND('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := NEXT(-1) <> 0;
                    if not MoreLines then
                        CurrReport.BREAK();
                    SETRANGE("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                end;
            }
            dataitem(WorkDescriptionLines; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = filter(1 .. 99999));
                column(WorkDescriptionLineNumber; Number)
                {
                }
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;

                trigger OnPostDataItem()
                begin
                    CLEAR(WorkDescriptionInstream);
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.BREAK();
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FIELDCAPTION("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FIELDCAPTION("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FIELDCAPTION("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FIELDCAPTION("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FIELDCAPTION("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FIELDCAPTION("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FIELDCAPTION("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; COUNT)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.INSERT() then;
                    end;

                    // DEB DELPHI XAV
                    if VATClause.GET(Line."VAT Clause Code") then begin
                        VATClause.TranslateDescription(Header."Language Code");
                        GTxtVATClause1 += ' ' + VATClause.Description + ' ' + VATClause."Description 2";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(VATBaseLCY);
                    CLEAR(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                UseTemporary = true;
                column(VATClausesHeader; VATClausesText)
                {
                }
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FIELDCAPTION(Code))
                {
                }
                column(Description_VATClauseLine; VATClause.Description)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; COUNT)
                {
                }
                column(VATClause1; GTxtVATClause1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.SKIP();
                    if not VATClause.GET("VAT Clause Code") then
                        CurrReport.SKIP();
                    VATClause.TranslateDescription(Header."Language Code");
                end;

                trigger OnPreDataItem()
                begin
                    if COUNT = 0 then
                        VATClausesText := ''
                    else
                        VATClausesText := VATClausesLbl;
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = sorting("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
            dataitem(PaymentReportingArgument; 1062)
            {
                DataItemTableView = sorting(Key);
                UseTemporary = true;
                column(PaymentServiceLogo; Logo)
                {
                }
                column(PaymentServiceLogo_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceLogo_Url; GetTargetURL())
                {
                }
                column(PaymentServiceText_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceText_Url; GetTargetURL())
                {
                }
            }
            dataitem(LetterText; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyContentText)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
                column(PmtDiscText; PmtDiscText)
                {
                }

                trigger OnPreDataItem()
                begin
                    PmtDiscText := '';
                    if Header."Payment Discount %" <> 0 then
                        PmtDiscText := STRSUBSTNO(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;
            }
            dataitem(Totals; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText())
                {
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalVATDisplay; GTxtDisplayTotalAmountVAT)
                {
                }
                column(TotalTTCDisplay; GTxtDisplayTotalAmountInclVAT)
                {
                }
                column(TotalVATDisplay_Lbl; GTxtTotalTVA_Lbl)
                {
                }
                column(TotalTTCDisplay_Lbl; GTxtTotalTTC_Lbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //DEB DELPHI AUB 15.10.2019
                    GTxtDisplayTotalAmountVAT := '';
                    GTxtDisplayTotalAmountInclVAT := '';
                    GTxtTotalTVA_Lbl := '';
                    GTxtTotalTTC_Lbl := '';
                    if TotalAmountVAT > 0 then begin
                        GTxtDisplayTotalAmountVAT := FORMAT(TotalAmountVAT, 0, '<Integer Thousand><Decimals,3>');
                        GTxtDisplayTotalAmountInclVAT := FORMAT(TotalAmountInclVAT, 0, '<Integer Thousand><Decimals,3>');
                        GTxtTotalTVA_Lbl := 'Total EUR TVA';
                        GTxtTotalTTC_Lbl := 'Total EUR TTC';
                    end;
                    //END DELPHI AUB 15.10.2019
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                PaymentServiceSetup: Record "Payment Service Setup";
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
            begin
                FirstLineHasBeenOutput := false;
                CLEAR(Line);
                VATAmountLine.DELETEALL();
                VATClauseLine.DELETEALL();
                Line.DELETEALL();
                CLEAR(SalesPost);
                SalesPost.GetSalesLines(Header, Line, 0);
                OnAfterSalesPostGetSalesLines(Header, Line);

                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);

                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                CALCFIELDS("Work Description");
                ShowWorkDescription := "Work Description".HASVALUE;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);
                DocumentTitleText := SalesConfirmationLbl;
                YourDocumentTitleText := STRSUBSTNO(YourDocLbl, SalesConfirmationLbl);
                InvoiceNoText := InvNoLbl;
                BodyContentText := BodyLbl;
                ChecksPayableText := STRSUBSTNO(ChecksPayableLbl, CompanyInfo.Name);

                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      ROUND(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := STRSUBSTNO(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                FormatDocumentFields(Header);

                if not IsReportInPreviewMode() and ArchiveDocument then
                    ArchiveManagement.StoreSalesDocument(Header, false);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;

                // DEB DELPHI XAV Livraison - Transport - Bank
                if ShipmentMethod.GET(Header."Shipment Method Code") then begin
                    if GrecTraductionTransport.GET(ShipmentMethod.Code, Header."Language Code") then
                        GTxtTraductionTransport := GrecTraductionTransport.Description
                    else
                        GTxtTraductionTransport := ShipmentMethod.Description;
                    if ShipmentMethod.Incoterms then
                        GTxtCondLivraisonEtendues := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison" + ' - Incoterms © 2010'
                    else
                        GTxtCondLivraisonEtendues := ShipmentMethod.Code + ' ' + GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison";
                end;
                if GrecTransporteur.GET(Header."Shipping Agent Code") then
                    GTxtTransporteur := GrecTransporteur.Name
                else
                    GTxtTransporteur := Header."Shipping Agent Code";
                GTxtBankName := CompanyInfo."Bank Name";
                GTxtBankBranchNo := CompanyInfo."Bank Branch No.";
                GTxtBankAcountNo := CompanyInfo."Bank Account No.";
                GTxtBankIBAN := CompanyInfo.IBAN;
                GTxtBankSwift := CompanyInfo."SWIFT Code";

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;

                GTxtNumTVAClient := '';
                GTxtNumTVAClient_Lbl := '';
                if GRecCust2.GET("Sell-to Customer No.") then
                    if GRecCust2."VAT Registration No." <> '' then begin
                        GTxtNumTVAClient := GRecCust2."VAT Registration No.";
                        GTxtNumTVAClient_Lbl := VATIdentifierLbl + ' :';
                    end;
                //FIN DELPHI XAV
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                    }
                }
            }
        }
        trigger OnInit()
        begin
            ArchiveDocument := SalesSetup."Archive Orders";
        end;
    }
    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.SETAUTOCALCFIELDS(Picture);
        CompanyInfo.GET();
        SalesSetup.GET();
        CompanyInfo.VerifyAndSetPaymentInfo();
        //DEB DELPHI XAV
        GTxtVATClause1 := '';
    end;

    trigger OnPreReport()
    begin
        if Header.GETFILTERS = '' then
            ERROR(NoFilterSetErr);

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        SalesConfirmationLbl: Label 'Draft Invoice', Comment = 'FRA="Facture Proforma"';
        YourDocLbl: Label 'Your %1', Comment = 'FRA="Votre %1"';
        SalespersonLbl: Label 'Sales person', Comment = 'FRA="Vendeur"';
        CompanyInfoBankAccNoLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        CompanyInfoBankNameLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CopyLbl: Label 'Copy', Comment = 'FRA="Copier"';
        EMailLbl: Label 'Email', Comment = 'FRA="E-mail"';
        HomePageLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvDiscountAmtLbl: Label 'Invoice Discount', Comment = 'FRA="Remise facture"';
        InvNoLbl: Label 'Draft Invoice No.', Comment = 'FRA="N° facture provisoire"';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LocalCurrencyLbl: Label 'Local Currency', Comment = 'FRA="Devise société"';
        PageLbl: Label 'Page', Comment = 'FRA="Page"';
        PaymentTermsDescLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PaymentMethodDescLbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        PostedShipmentDateLbl: Label 'Shipment Date', Comment = 'FRA="Date d''expédition"';
        SalesInvLineDiscLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        ShipmentLbl: Label 'Shipment', Comment = 'FRA="Expédition"';
        ShiptoAddrLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        ShptMethodDescLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        SubtotalLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        TotalLbl: Label 'Total', Comment = 'FRA="Total"';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATAmtLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)', Comment = 'FRA="Montant TVA DS"';
        VATBaseLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATBaseLCYLbl: Label 'VAT Base (LCY)', Comment = 'FRA="Base TVA (DS)"';
        VATClausesLbl: Label 'VAT Clause', Comment = 'FRA="Clause TVA"';
        VATIdentifierLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentageLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        LanguageMgt: Codeunit Language;
        VATClause: Record "VAT Clause";
        GrecTransporteur: Record "Shipping Agent";
        GRecItem: Record Item;
        GRecBank: Record "Bank Account";
        GrecTraductionTransport: Record "Shipment Method Translation";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        WorkDescriptionInstream: InStream;
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ChecksPayableText: Text;
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[50];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        ArchiveDocument: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.', Comment = 'FRA="Vous devez spécifier un ou plusieurs filtres pour éviter d''imprimer accidentellement tous les documents."';
        PmtDiscText: Text;
        PaymentInstructionsTxt: Text;
        YourDocumentTitleText: Text;
        FromLbl: Label 'From', Comment = 'FRA="De"';
        BilledToLbl: Label 'Billed to', Comment = 'FRA="Facturé à"';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = 'FRA="Les chèques peuvent être payés à %1"';
        QuestionsLbl: Label 'Questions?', Comment = 'FRA="Vous avez des questions?"';
        ThanksLbl: Label 'Thank You!', Comment = 'FRA="Merci!"';
        GreetingLbl: Label 'Hello', Comment = 'FRA="Bonjour"';
        ClosingLbl: Label 'Sincerely', Comment = 'FRA="Cordialement"';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = 'FRA="Si nous recevons le paiement avant le %1, vous pouvez bénéficier d''un escompte de %2%."';
        BodyLbl: Label 'Thank you for your business. Your draft invoice is attached to this message.', Comment = 'FRA="Merci de votre collaboration. Votre facture provisoire est jointe à ce message."';
        DocumentTitleText: Text;
        InvoiceNoText: Text;
        VATClausesText: Text;
        BodyContentText: Text;
        UnitLbl: Label 'Unit', Comment = 'FRA="Unité"';
        QtyLbl: Label 'Qty', Comment = 'FRA="Qté"';
        PriceLbl: Label 'Price', Comment = 'FRA="Prix"';
        PricePerLbl: Label 'Price per', Comment = 'FRA="Prix par"';
        NextInvoiceNo: Text;
        GTxtCondLivraisonEtendues: Text[150];
        GTxtTransporteur: Text[80];
        GTxtNomenclatureArticle: Text[20];
        GTxtBankName: Text[100];
        GTxtBankBranchNo: Text[20];
        GTxtBankAcountNo: Text[30];
        GTxtBankIBAN: Text[50];
        GTxtBankSwift: Text[20];
        GTxtVATClause1: Text[1024];
        GTxtTraductionTransport: Text[80];
        GRecCountry: Record "Country/Region";
        GTxtCompanyInfoPays: Text[50];
        GRecCust2: Record Customer;
        GTxtNumTVAClient: Text[60];
        GTxtNumTVAClient_Lbl: Text[60];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtItemNo: Text[50];
        GTxtCompanyBankBranch: Label 'Bk Code', Comment = 'FRA="Code Bq"';
        GTxtCompanyPhoneNo: Label 'Phone', Comment = 'FRA="Tél."';
        GTxtCompanyFaxNo: Label 'Fax.', Comment = 'FRA="Fax."';
        GTxtCompanyHomepage: Label 'Website', Comment = 'FRA="Site Web"';
        GTxtCompanyemail: Label 'E-Mail', Comment = 'FRA="E-Mail"';
        GTxtCompanyVAT: Label 'VAT Id. Num.', Comment = 'FRA="No. TVA"';
        GTxtCompanyGesch: Label 'Director', Comment = 'FRA="Gérant"';
        GTxtCompanySitz: Label 'H. Q.', Comment = 'FRA="Siège"';
        GTxtCompanyBankNr: Label 'Bk Num.', Comment = 'FRA="No. Cpte"';
        GTxtCompanyTrib: Label 'Trial court', Comment = 'FRA="RCS"';
        GTxtCompanyBankSWIFT: Label 'SWIFT', Comment = 'FRA="SWIFT"';
        GTxtCompanySalespers: Label 'Agent', Comment = 'FRA="Commercial"';
        GTxtCustomerNum: Label 'Customer num.', Comment = 'FRA="No. Client"';
        GTxtQuantity_Line_Lbl: Label 'Qty', Comment = 'FRA="Qté"';
        GTxtUnitOfMeasure_Lbl: Label 'Unit', Comment = 'FRA="Unité"';
        GTxtUnitPrice_Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unit."';
        GTxtItemNo_Line_Lbl: Label 'Item No.', Comment = 'FRA="N° d''article"';
        GTxtDocumentTitle: Label 'Proforma Invoice', Comment = 'FRA="Facture Proforma"';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.', Comment = 'FRA="Les retards de paiement sont soumis à un intérêt mensuel de 1,5%. Pas d’escompte pour règlement anticipé."';
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DELETEALL();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSalesPostGetSalesLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;
}

