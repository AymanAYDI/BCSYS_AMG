namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using System.Utilities;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Team;
using Microsoft.Sales.Customer;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Inventory.Item;
using Microsoft.Utilities;
using Microsoft.CRM.Segment;
using System.EMail;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.Finance.Currency;
using Microsoft.Sales.Posting;
report 50304 "Standard Sales - Quote"
{
    RDLCLayout = './src/report/rdl/StandardSalesQuote.rdl';
    WordLayout = './src/report/rdl/StandardSalesQuote.docx';
    Caption = 'Sales - Quote', Comment = 'FRA="Ventes : Devis"';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    UsageCategory = None;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote', Comment = 'FRA="Devis"';
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
            column(CompanyPhoneNo_Lbl; GTxtCompanyPhoneNo)
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
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
            column(CompanyRCS_Lbl; GTxtCompanyTrib)
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
            column("CompanySiège_Lbl"; GTxtCompanySitz)
            {
            }
            column(CompanyDirector_Lbl; GTxtCompanyGesch)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; GTxtCompanyVAT)
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
            column(ShipmentMethodDescription; ShipmentMethod.Description)
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
            column(DocumentCopyText; STRSUBSTNO(DocumentCaption(), CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FIELDCAPTION("Bill-to Customer No."))
            {
            }
            column(DocumentDate; GdocDate)
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
            column(QuoteValidToDate; FORMAT("Quote Valid Until Date", 0, 4))
            {
            }
            column(QuoteValidToDate_Lbl; QuoteValidToDateLbl)
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
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
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl())
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
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Lbl; GTxtCompanyemail)
            {
            }
            column(HomePage_Lbl; GTxtCompanyHomepage)
            {
            }
            column(Estimate_Lbl; EstimateLbl)
            {
            }
            column(YourEstimate_Lbl; YourEstimateLbl)
            {
            }
            column(EstimateBody_Lbl; EstimateBodyLbl)
            {
            }
            column(From_Lbl; FromLbl)
            {
            }
            column(EstimateFor_Lbl; EstimateForLbl)
            {
            }
            column(Questions_Lbl; QuestionsLbl)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText())
            {
            }
            column(Thanks_Lbl; ThanksLbl)
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
            column(DocumentTitle_Lbl; GtxtDocumentTitle_Lbl)
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
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(Terms_Lbl; GTxtTerms_Lbl)
            {
            }
            column(Delivery_Lbl; GTxtDelivery_Lbl)
            {
            }
            column(Paymentterms_Lbl; GTxtPaymentterms_Lbl)
            {
            }
            column(Warranty_Lbl; GTxtWarranty_Lbl)
            {
            }
            column(Prices_Lbl; GTxtPrices_Lbl)
            {
            }
            column(Validity_Lbl; GTxtValidity_Lbl)
            {
            }
            column(TextLbl; GTxTextLbl)
            {
            }
            column(NetWeight; Header."Net Weight")
            {
            }
            column(GrossWeight; Header."Gross Weight")
            {
            }
            column(MentionLegalFR; GTxTMentionLegaleFR)
            {
            }
            column(NumTVAClient; GTxtNumTVAClient)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ''))
            {
            }
            column("Délaidelivraison_Header"; Header."Delai de livraison")
            {
            }
            column("Duréedevalidité_Header"; Header."Duree de validite")
            {
            }
            column(DelaiLiv_Lbl; GTxtDelaiLiv_Lbl)
            {
            }
            column(DureeValid_Lbl; GTxtDureeValid_Lbl)
            {
            }
            column(DocumentNoFormat_Header; GTxtDocumentNo)
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
                column(ItemNo_Line_Lbl; GTxtLineNoLbl)
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
                column(Description2_Line; "Description 2")
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
                column(LineDiscountAmount_Line; Line."Line Discount Amount")
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
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNoOrRef_Line; GTxtItemNo)
                {
                }
                column(ShipmentDate_Line; FORMAT("Shipment Date"))
                {
                }
                column(ShipmentDate_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; FormattedQuantity)
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
                column(Reference_Externe; Line."Item Reference No.")
                {
                }
                column(NomenclatureArticle; GTxtNomenclatureArticle)
                {
                }
                column(CodeRegionOrigine; GTxtCodeRegionOrigine)
                {
                }
                column(Qty_Line; GTxtQty)
                {
                }
                column(UnitPrice_Line; GTxtPrixUnitaire)
                {
                }
                column(Amount_Line; GTxtMontantLigne)
                {
                }
                column(DiscountLbl; DiscountLbl)
                {
                }

                trigger OnAfterGetRecord()
                var
                    LRecCountry: Record "Country/Region";
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

                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

                    if FirstLineHasBeenOutput then
                        CLEAR(CompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    // DEB DELPHI XAV
                    if GRecItem.GET(Line."No.") then begin
                        //DEB DELPHI AUB 10.10.2019
                        if (GRecItem."Tariff No." <> '') and GBooAffichageOrigine then
                            GTxtNomenclatureArticle := 'TD :' + GRecItem."Tariff No."
                        else
                            GTxtNomenclatureArticle := '';
                        if (GRecItem."Country/Region of Origin Code" <> '') and GBooAffichageOrigine then begin
                            if LRecCountry.GET(GRecItem."Country/Region of Origin Code") then
                                GTxtCodeRegionOrigine := ' Origine: ' + LRecCountry.Name
                        end else
                            GTxtCodeRegionOrigine := '';
                        //END DELPHI AUB
                        GTxtBrand := GRecItem.Brand;
                        GTxTGrade := GRecItem.Grade;
                        GTxtColor := GRecItem.Color;
                    end
                    else begin
                        GTxtNomenclatureArticle := '';
                        GTxtBrand := '';
                        GTxTGrade := '';
                        GTxtColor := '';
                        GTxtCodeRegionOrigine := ''; //DELPHI AUB
                    end;

                    // FIN DELPHI XAV
                    //DELPHI AUB 18/02/2019
                    GTxtItemNo := Line."No.";
                    if Line.Type = Line.Type::Item then
                        if Line."Item Reference No." <> '' then
                            GTxtItemNo := Line."Item Reference No.";

                    if (Line.Quantity = 0) then begin
                        GTxtQty := '';
                        GTxtPrixUnitaire := '';
                        GTxtMontantLigne := '';
                    end else begin
                        GTxtQty := FORMAT(Line.Quantity);
                        GTxtMontantLigne := FORMAT(Line.Amount);
                        GTxtPrixUnitaire := FORMAT(Line."Unit Price");
                    end;
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
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(VATBaseLCY);
                    CLEAR(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
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
            dataitem(LetterText; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));
                column(GreetingText; GreetingLbl)
                {
                }
                column(BodyText; BodyLbl)
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
                column(TotalExcludingVATLbl; GTxtTotalHT_Lbl)
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
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                //DEB DELPHI XAV
                Header.CALCFIELDS("Net Weight", "Gross Weight");
                //FIN DELPHI XAV
                //DELPHI AUB 16.07.2019 edited 14.10.2019
                if GBooProforma then begin
                    GtxtDocumentTitle_Lbl := GTxtProforma;
                    GTxtDocumentNo := Header."No.";
                    GTxtDocumentNo := CONVERTSTR(GTxtDocumentNo, 'DV', 'PF');
                end else begin
                    GtxtDocumentTitle_Lbl := GTxtQuoteLbl;
                    GTxtDocumentNo := Header."No.";
                end;
                //END DELPHI
                FirstLineHasBeenOutput := false;
                CLEAR(Line);
                CLEAR(SalesPost);
                VATAmountLine.DELETEALL();
                Line.DELETEALL();
                SalesPost.GetSalesLines(Header, Line, 0);
                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);

                CALCFIELDS("Work Description");
                ShowWorkDescription := "Work Description".HASVALUE;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                FormatAddr.SalesHeaderSellTo(GTxtSelltoAddr, Header);
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);

                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      ROUND(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := STRSUBSTNO(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;



                if not IsReportInPreviewMode() and
                   (CurrReport.USEREQUESTPAGE and ArchiveDocument or
                    not CurrReport.USEREQUESTPAGE and (SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never))
                then
                    case SalesSetup."Archive Quotes" of
                        SalesSetup."Archive Quotes"::Always:
                            ArchiveManagement.ArchSalesDocumentNoConfirm(Header);
                        SalesSetup."Archive Quotes"::Question:
                            ArchiveManagement.ArchiveSalesDocument(Header);
                    end;

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;

                // DELPHI AUB 15.07.2019
                //GTxtCompanyVAT := 'No. TVA';
                GTxtCompanyVAT := GTxtTVaLbl;
                if Cust.ICE then
                    GTxtCompanyVAT := 'No. ICE';
                if Cust."VAT Registration No." = '' then
                    GTxtCompanyVAT := '';


                // DEB DELPHI XAV Livraison
                if ShipmentMethod.GET(Header."Shipment Method Code") then
                    if GrecTraductionTransport.GET(ShipmentMethod.Code, Header."Language Code") then
                        GTxtTraductionTransport := GrecTraductionTransport.Description
                    else
                        GTxtTraductionTransport := ShipmentMethod.Description;
                if ShipmentMethod.Incoterms then
                    GTxtCondLivraisonEtendues := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison" + ' - Incoterms © 2010'
                else
                    GTxtCondLivraisonEtendues := ShipmentMethod.Code + ' ' + GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison";
                GTxtBankName := CompanyInfo."Bank Name";
                GTxtBankBranchNo := CompanyInfo."Bank Branch No.";
                GTxtBankAcountNo := CompanyInfo."Bank Account No.";
                GTxtBankIBAN := CompanyInfo.IBAN;
                GTxtBankSwift := CompanyInfo."SWIFT Code";

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;

                if GRecCust2.GET("Sell-to Customer No.") then
                    GTxtNumTVAClient := GRecCust2."VAT Registration No.";

                //--> BC6 NC 13052024
                if LanguageMgt.GetUserLanguageCode() = 'ENU' then
                    GdocDate := FORMAT(Header."Document Date", 0, '<Month Text> <Closing><Day>, <Year4>')
                else
                    GdocDate := FORMAT(Header."Document Date", 0, 4);

                FormatDocumentFields(Header);
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
                    field(LogInteractionF; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(GBooProformaF; GBooProforma)
                    {
                        Caption = 'Facture Pro-forma', Comment = 'FRA="Facture Pro-forma"';
                    }
                    field(AffichageOrigineF; GBooAffichageOrigine)
                    {
                        Caption = 'Affichage Origine', Comment = 'FRA="Affichage Origine"';
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.SETAUTOCALCFIELDS(Picture);
        CompanyInfo.GET();
        SalesSetup.GET();
        CompanyInfo.VerifyAndSetPaymentInfo();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FINDSET() then
                repeat
                    Header.CALCFIELDS("No. of Archived Versions");
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", DATABASE::Contact, Header."Bill-to Contact No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", DATABASE::Customer, Header."Bill-to Customer No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.");
                until Header.NEXT() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GETFILTERS = '' then
            ERROR(NoFilterSetErr);

        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        CompanyInfo: Record "Company Information";
        GRecCountry: Record "Country/Region";
        Cust: Record Customer;
        GRecCust2: Record Customer;
        GLSetup: Record "General Ledger Setup";
        GRecItem: Record Item;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        GrecTraductionTransport: Record "Shipment Method Translation";
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        LanguageMgt: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        FirstLineHasBeenOutput: Boolean;
        GBooAffichageOrigine: Boolean;
        GBooProforma: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowShippingAddr: Boolean;
        ShowWorkDescription: Boolean;
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TotalSubTotal: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TransHeaderAmount: Decimal;
        VATAmountLCY: Decimal;
        VATBaseLCY: Decimal;
        WorkDescriptionInstream: InStream;
        CompanyLogoPosition: Integer;
        BodyLbl: Label 'Thank you for your business. Your quote is attached to this message.', Comment = 'FRA="Merci de votre collaboration. Votre devis est joint à ce message."';
        ClosingLbl: Label 'Sincerely', Comment = 'FRA="Cordialement"';
        CompanyInfoBankNameLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CopyLbl: Label 'Copy', Comment = 'FRA="Copier"';
        DiscountLbl: Label 'Discount', Comment = 'FRA="Remise"';
        EstimateBodyLbl: Label 'As promised, here''s our estimate. Please see the attached estimate for details.', Comment = 'FRA="Comme convenu, voici notre estimation. Consultez l''estimation jointe pour plus d''informations."';
        EstimateForLbl: Label 'Estimate for', Comment = 'FRA="Estimation pour"';
        EstimateLbl: Label 'Estimate', Comment = 'FRA="Estimation"';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        FromLbl: Label 'From', Comment = 'FRA="De"';
        GreetingLbl: Label 'Hello', Comment = 'FRA="Bonjour"';
        GTxtCompanyBankBranch: Label 'Bk Code', Comment = 'FRA="Code Bq"';
        GTxtCompanyBankNr: Label 'Bk Num.', Comment = 'FRA="No. Cpte"';
        GTxtCompanyBankSWIFT: Label 'SWIFT', Comment = 'FRA="SWIFT"';
        GTxtCompanyemail: Label 'E-Mail', Comment = 'FRA="E-Mail"';
        GTxtCompanyFaxNo: Label 'Fax.', Comment = 'FRA="Fax."';
        GTxtCompanyGesch: Label 'Director', Comment = 'FRA="Gérant"';
        GTxtCompanyHomepage: Label 'Website', Comment = 'FRA="Site Web"';
        GTxtCompanyPhoneNo: Label 'Phone', Comment = 'FRA="Tél."';
        GTxtCompanySalespers: Label 'Agent', Comment = 'FRA="Commercial"';
        GTxtCompanySitz: Label 'H. Q.', Comment = 'FRA="Siège"';
        GTxtCompanyTrib: Label 'Trial court', Comment = 'FRA="RCS"';
        GTxtCustomerNum: Label 'Customer num.', Comment = 'FRA="No. Client"';
        GTxtDelaiLiv_Lbl: Label 'Shipment Time', Comment = 'FRA="Délai de livraison"';
        GTxtDelivery_Lbl: Label 'Delivery', Comment = 'FRA="Livraison"';
        GTxtDureeValid_Lbl: Label 'Durée de validité', Comment = 'FRA="Durée de validité"';
        GTxTextLbl: Label 'Free text typing', Comment = 'FRA="Saisie de texte libre"';
        GTxtLineNoLbl: Label 'Item No', Comment = 'FRA="N° article"';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.', Comment = 'FRA="Les retards de paiement sont soumis à un intérêt mensuel de 1,5%. Pas d’escompte pour règlement anticipé."';
        GTxtPaymentterms_Lbl: Label 'Payment terms', Comment = 'FRA="Conditions de paiement"';
        GTxtPrices_Lbl: Label 'Prices', Comment = 'FRA="Prix"';
        GTxtProforma: Label 'Proforma Invoice No ', Comment = 'FRA="Facture Pro-forma N° "';
        GTxtQuantity_Line_Lbl: Label 'Qty', Comment = 'FRA="Qté"';
        GTxtQuoteLbl: Label 'Quote', Comment = 'FRA="Devis"';
        GTxtTerms_Lbl: Label 'Terms of delivery and payement', Comment = 'FRA="Conditions de livraison et de paiement"';
        GTxtTotalHT_Lbl: Label 'Total EUR HT', Comment = 'FRA="Total EUR HT"';
        GTxtTVaLbl: Label 'VAT No', Comment = 'FRA="N° TVA"';
        GTxtUnitOfMeasure_Lbl: Label 'Unit', Comment = 'FRA="Unité"';
        GTxtUnitPrice_Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unit."';
        GTxtValidity_Lbl: Label 'Validity', Comment = 'FRA="Validité"';
        GTxtWarranty_Lbl: Label 'Warranty', Comment = 'FRA="Garantie"';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvDiscountAmtLbl: Label 'Invoice Discount', Comment = 'FRA="Remise facture"';
        InvNoLbl: Label 'No.', Comment = 'FRA="N°"';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LocalCurrencyLbl: Label 'Local Currency', Comment = 'FRA="Devise société"';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.', Comment = 'FRA="Vous devez spécifier un ou plusieurs filtres pour éviter d''imprimer accidentellement tous les documents."';
        PageLbl: Label 'Page', Comment = 'FRA="Page"';
        PaymentMethodDescLbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        PaymentTermsDescLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = 'FRA="Si nous recevons le paiement avant le %1, vous pouvez bénéficier d''un escompte de 2%."';
        PostedShipmentDateLbl: Label 'Shipment Date', Comment = 'FRA="Date d''expédition"';
        PriceLbl: Label 'Price', Comment = 'FRA="Prix"';
        PricePerLbl: Label 'Price per', Comment = 'FRA="Prix par"';
        QtyLbl: Label 'Qty', Comment = 'FRA="Qté"';
        QuestionsLbl: Label 'Questions?', Comment = 'FRA="Vous avez des questions?"';
        QuoteValidToDateLbl: Label 'Valid to', Comment = 'FRA="Valide jusqu''au"';
        ReferenceText: Label 'Your Reference', Comment = 'FRA="Votre référence"';
        SalesConfirmationLbl: Label 'Sales Quote', Comment = 'FRA="Devis"';
        SalesInvLineDiscLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        ShipmentLbl: Label 'Shipment', Comment = 'FRA="Expédition"';
        ShiptoAddrLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        ShptMethodDescLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        SubtotalLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        ThanksLbl: Label 'Thank You!', Comment = 'FRA="Merci!"';
        TotalLbl: Label 'Total', Comment = 'FRA="Total"';
        UnitLbl: Label 'Unit', Comment = 'FRA="Unité"';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)', Comment = 'FRA="Montant TVA DS"';
        VATAmtLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATBaseLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATBaseLCYLbl: Label 'VAT Base (LCY)', Comment = 'FRA="Base TVA (DS)"';
        VATClausesLbl: Label 'VAT Clause', Comment = 'FRA="Clause TVA"';
        VATIdentifierLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentageLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        YourEstimateLbl: Label 'Your Estimate', Comment = 'FRA="Votre estimation"';
        ExchangeRateText: Text;
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        GdocDate: Text;
        GTxtCondLivraisonEtendues: Text;
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        WorkDescriptionLine: Text;
        GTxtBankBranchNo: Text[20];
        GTxtBankSwift: Text[20];
        CopyText: Text[30];
        GTxtNomenclatureArticle: Text[30];
        GTxtBankAcountNo: Text[50];
        GTxtBankIBAN: Text[50];
        GTxtBrand: Text[50];
        GTxtColor: Text[50];
        GTxtCompanyInfoPays: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDocumentNo: Text[50];
        GTxTGrade: Text[50];
        GTxtItemNo: Text[50];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
        SalesPersonText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        GTxtCodeRegionOrigine: Text[60];
        GTxtNumTVAClient: Text[60];
        GTxtCompanyVAT: Text[80];
        GtxtDocumentTitle_Lbl: Text[80];
        GTxtMontantLigne: Text[80];
        GTxtPrixUnitaire: Text[80];
        GTxtQty: Text[80];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        GTxtBankName: Text[100];
        GTxtTraductionTransport: Text[100];
        ShipToAddr: array[8] of Text[100];

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Qte.") <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean)
    begin
        LogInteraction := NewLogInteraction;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
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
}

