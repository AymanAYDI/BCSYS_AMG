namespace Microsoft.Sales.Document;

using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Text;
using System.Utilities;
using Microsoft.Inventory.Item;

report 50045 "StandardSalesQuote" //1304 Duplicate
{
    Caption = 'Sales - Quote';
    DefaultRenderingLayout = "StandardSalesQuote.docx";
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
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
            column(CompanyPicture; DummyCompanyInfo.Picture)
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
            column(CompanyIBAN_Lbl; CompanyBankAccount.FieldCaption(IBAN))
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
            column(CompanySiŠge_Lbl; GTxtCompanySitz)
            {
            }
            column(CompanyDirector_Lbl; GTxtCompanyGesch)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; GTxtCompanyVAT)
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
            {
            }
            column(CompanyLegalOffice_Lbl; LegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CustomGiroTxt)
            {
            }
            column(CompanyCustomGiro_Lbl; CustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; LegalStatementLbl)
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
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference__Lbl; FieldCaption("Your Reference"))
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
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
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
            column(DocumentCopyText; StrSubstNo(DocumentCaption(), CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(QuoteValidToDate; Format("Quote Valid Until Date", 0, 4))
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
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
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
            column(VATClause_Lbl; VATClause.TableCaption())
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
            column("Délaidelivraison_Header"; Header."Delivery time")
            {
            }
            column("Duréedevalidité_Header"; Header."Validity period")
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
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
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
                column(Description_Line_Lbl; FieldCaption(Description))
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
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNoOrRef_Line; GTxtItemNo)
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
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
                column(Type_Line; Format(Type))
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
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
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

                trigger OnAfterGetRecord()
                var
                    LRecCountry: Record "Country/Region";
                    text001: Label '%1%', Comment = '%1 = Line Discount %';
                begin
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo(text001, -Round("Line Discount %", 0.1));

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
                        Clear(DummyCompanyInfo.Picture);
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
                    MoreLines := FindLast();
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 99999));
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
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();

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
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
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
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
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
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
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
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

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
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
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
                        PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(Enum::"Auto Format"::AmountFormat, Header."Currency Code")))
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
                column(CurrencyCode; CurrCode)
                {
                }
                column(CurrencySymbol; CurrSymbol)
                {
                }
                trigger OnAfterGetRecord()
                var
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
                Currency: Record Currency;
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                GeneralLedgerSetup: Record "General Ledger Setup";
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
            begin
                //DEB DELPHI XAV
                Header.CALCFIELDS("Net Weight", "Gross Weight");
                //FIN DELPHI XAV
                //DELPHI AUB 16.07.2019 edited 14.10.2019
                if BooProforma then begin
                    GtxtDocumentTitle_Lbl := 'Facture Pro-forma Nø ';
                    GTxtDocumentNo := Header."No.";
                    GTxtDocumentNo := CONVERTSTR(GTxtDocumentNo, 'DV', 'PF');
                end else begin
                    GtxtDocumentTitle_Lbl := 'Devis';
                    GTxtDocumentNo := Header."No.";
                end;
                //END DELPHI
                FirstLineHasBeenOutput := false;
                Clear(Line);
                Clear(SalesPost);
                VATAmountLine.DeleteAll();
                Line.DeleteAll();
                SalesPost.GetSalesLines(Header, Line, 0);
                OnBeforeCalcVATAmountLines(Header, Line);
                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);
                OnLineOnAfterGetRecordOnAfterUpdateVATOnLines(Header, Line);

                OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(IsReportInPreviewMode(), Header);

                SetFormatRegion("Format Region");
                SetLanguage("Language Code");
                FormatAddr.SetLanguageCode("Language Code");

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                FormatAddr.SalesHeaderSellTo(GTxtSelltoAddr, Header);
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                    CurrCode := "Currency Code";
                    if Currency.Get("Currency Code") then
                        CurrSymbol := Currency.GetCurrencySymbol();
                end else
                    if GeneralLedgerSetup.Get() then begin
                        CurrCode := GeneralLedgerSetup."LCY Code";
                        CurrSymbol := GeneralLedgerSetup.GetCurrencySymbol();
                    end;

                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not IsReportInPreviewMode() and
                   (CurrReport.UseRequestPage and BoolArchiveDocument or
                    not CurrReport.UseRequestPage and (SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never))
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
                GTxtCompanyVAT := 'No. TVA';
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
                    Caption = 'Options';
                    field(LogInteraction; BoolLogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(ArchiveDocument; BoolArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not BoolArchiveDocument then
                                BoolLogInteraction := false;
                        end;
                    }
                    field(GBooProforma; BooProforma)
                    {
                        Caption = 'Facture Pro-forma';
                    }
                    field(AffichageOrigine; GBooAffichageOrigine)
                    {
                        Caption = 'Affichage Origine';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            BoolArchiveDocument := SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := BoolLogInteraction;
        end;
    }

    rendering
    {
        layout("StandardSalesQuote.rdlc")
        {
            Type = RDLC;
            LayoutFile = './Sales/Document/StandardSalesQuote.rdlc';
            Caption = 'Standard Sales Quote (RDLC)';
            Summary = 'The Standard Sales Quote (RDLC) provides a detailed layout.';
        }
        layout("StandardSalesQuote.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesQuote.docx';
            Caption = 'Standard Sales Quote (Word)';
            Summary = 'The Standard Sales Quote (Word) provides a basic layout.';
        }
        layout("StandardSalesQuoteBlue.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesQuoteBlue.docx';
            Caption = 'Standard Sales Quote - Blue (Word)';
            Summary = 'The Standard Sales Quote - Blue (Word) provides a basic layout with a blue theme.';
        }
        layout("StandardSalesQuoteEmail.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesQuoteEmail.docx';
            Caption = 'Standard Sales Quote Email (Word)';
            Summary = 'The Standard Sales Quote Email (Word) provides an email body layout.';
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        SalesHeader: Record "Sales Header";
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();

        if SalesHeader.GetLegalStatement() <> '' then
            LegalStatementLbl := SalesHeader.GetLegalStatement();

        IsHandled := false;
        OnInitReportForGlobalVariable(IsHandled, LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl);
#if not CLEAN23
        if not IsHandled then begin
            LegalOfficeTxt := CompanyInfo.GetLegalOffice();
            LegalOfficeLbl := CompanyInfo.GetLegalOfficeLbl();
            CustomGiroTxt := CompanyInfo.GetCustomGiro();
            CustomGiroLbl := CompanyInfo.GetCustomGiroLbl();
        end;
#endif
    end;

    trigger OnPostReport()
    begin
        if BoolLogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    Header.CalcFields("No. of Archived Versions");
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", Database::Contact, Header."Bill-to Contact No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          1, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", Database::Customer, Header."Bill-to Customer No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.");
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        GRecCust2: Record 18;
        CompanyBankAccount: Record "Bank Account";
        DummyCompanyInfo: Record "Company Information";
        GRecCountry: Record "Country/Region";
        Cust: Record Customer;
        GRecItem: Record Item;
        GrecTraductionTransport: Record "Shipment Method Translation";
        AutoFormat: Codeunit "Auto Format";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        CULanguage: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        GBooAffichageOrigine: Boolean;
        BooProforma: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowShippingAddr: Boolean;
        ShowWorkDescription: Boolean;
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        WorkDescriptionInstream: InStream;
        CompanyLogoPosition: Integer;
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BodyLbl: Label 'Thank you for your business. Your quote is attached to this message.';
        ClosingLbl: Label 'Sincerely';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CopyLbl: Label 'Copy';
        EstimateBodyLbl: Label 'As promised, here''s our estimate. Please see the attached estimate for details.';
        EstimateForLbl: Label 'Estimate for';
        EstimateLbl: Label 'Estimate';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        FromLbl: Label 'From';
        GreetingLbl: Label 'Hello';
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanyemail: Label 'E-Mail';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyGesch: Label 'Director';
        GTxtCompanyHomepage: Label 'Website';
        GTxtCompanyPhoneNo: Label 'Phone';
        GTxtCompanySalespers: Label 'Agent';
        GTxtCompanySitz: Label 'H. Q.';
        GTxtCompanyTrib: Label 'Trial court';
        GTxtCustomerNum: Label 'Customer num.';
        GTxtDelaiLiv_Lbl: Label 'delivery time';
        GTxtDelivery_Lbl: Label 'Delivery';
        GTxtDureeValid_Lbl: Label 'Period of validity';
        GTxTextLbl: Label 'Free text typing';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.';
        GTxtPaymentterms_Lbl: Label 'Payment terms';
        GTxtPrices_Lbl: Label 'Prices';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtTerms_Lbl: Label 'Terms of delivery and payement';
        GTxtTotalHT_Lbl: Label 'Total EUR excluding tax';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        GTxtValidity_Lbl: Label 'Validity';
        GTxtWarranty_Lbl: Label 'Warranty';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'No.';
        LCYTxt: label ' (LCY)';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        PageLbl: Label 'Page';
        PaymentMethodDescLbl: Label 'Payment Method';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 = Discount Due Date %2 = value of Payment Discount % ';
        PostedShipmentDateLbl: Label 'Shipment Date';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        QuestionsLbl: Label 'Questions?';
        QuoteValidToDateLbl: Label 'Valid to';
        ReferenceText: Label 'Your reference';
        SalesConfirmationLbl: Label 'Sales Quote';
        SalesInvLineDiscLbl: Label 'Discount %';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        SubtotalLbl: Label 'Subtotal';
        Text005: Label 'Page %1';
        ThanksLbl: Label 'Thank You!';
        TotalLbl: Label 'Total';
        UnitLbl: Label 'Unit';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATAmtLbl: Label 'VAT Amount';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        YourEstimateLbl: Label 'Your Estimate';
        CustomGiroLbl, CustomGiroTxt, LegalOfficeLbl, LegalOfficeTxt, LegalStatementLbl : Text;
        ExchangeRateText: Text;
        PmtDiscText: Text;
        WorkDescriptionLine: Text;
        GTxtBankBranchNo: Text[20];
        GTxtBankSwift: Text[20];
        GTxtItemNo: Text;//[20];
        GTxtNomenclatureArticle: Text;//[20];
        CopyText: Text[30];
        GTxtBankAcountNo: Text[50];
        GTxtBankIBAN: Text[50];
        GTxtBankName: Text;//[50];
        GTxtBrand: Text[50];
        GTxtCodeRegionOrigine: Text;//[50];
        GTxtColor: Text[50];
        GTxtCompanyInfoPays: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDocumentNo: Text[50];
        GTxTGrade: Text[50];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
        GTxtNumTVAClient: Text[60];
        GTxtCompanyVAT: Text[80];
        GtxtDocumentTitle_Lbl: Text[80];
        GTxtMontantLigne: Text[80];
        GTxtPrixUnitaire: Text[80];
        GTxtQty: Text[80];
        GTxtTraductionTransport: Text;//[80]
        GTxtCondLivraisonEtendues: Text[120];

    protected var
        CompanyInfo: Record "Company Information";
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        VATClause: Record "VAT Clause";
        BoolArchiveDocument: Boolean;
        FirstLineHasBeenOutput: Boolean;
        BoolLogInteraction: Boolean;
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
        PaymentTermsDescLbl: Label 'Payment Terms';
        ShptMethodDescLbl: Label 'Shipment Method';
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        SalesPersonText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];

    local procedure InitLogInteraction()
    begin
        BoolLogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Qte.") <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean)
    begin
        BoolLogInteraction := NewLogInteraction;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels(GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            OnAfterFormatDocumentFields(SalesHeader);
        end;
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false, Header."Currency Code");
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false, Header."Currency Code");
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false, Header."Currency Code");
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false, Header."Currency Code");
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    local procedure SetFormatRegion(FormatRegion: Text[80])
    begin
        CurrReport.FormatRegion := CULanguage.GetFormatRegionOrDefault(FormatRegion);
        OnAfterSetFormatRegion();
    end;

    local procedure SetLanguage(LanguageCode: Code[10])
    begin
        CurrReport.Language := CULanguage.GetLanguageIdOrDefault(LanguageCode);

        OnAfterSetLanguage();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFormatDocumentFields(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetLanguage()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetFormatRegion()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcVATAmountLines(var Header: Record "Sales Header"; var Line: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLineOnAfterGetRecordOnAfterUpdateVATOnLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text; var CustomGiroTxt: Text; var CustomGiroLbl: Text; var LegalStatementLbl: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(ReportInPreviewMode: Boolean; var SalesHeader: Record "Sales Header")
    begin
    end;
}

