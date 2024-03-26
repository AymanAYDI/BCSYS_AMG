namespace Microsoft.Sales.Document;

using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Setup;
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
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Utilities;

report 50044 "StandardSalesDraftInvoice" //1303 Duplicate
{
    Caption = 'Draft Invoice';
    DefaultRenderingLayout = "StandardSalesDraftInvoice.docx";
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Invoice));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Draft Invoice';
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
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
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
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference__Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo__Lbl; FieldCaption("External Document No."))
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
            column(AlternativeAddress_Lbl; AlternativeAddressTxt)
            {
            }
            column(AlternativeAddress1; AlternativeAddress[1])
            {
            }
            column(AlternativeAddress2; AlternativeAddress[2])
            {
            }
            column(AlternativeAddress3; AlternativeAddress[3])
            {
            }
            column(AlternativeAddress4; AlternativeAddress[4])
            {
            }
            column(AlternativeAddress5; AlternativeAddress[5])
            {
            }
            column(AlternativeAddress6; AlternativeAddress[6])
            {
            }
            column(AlternativeAddress7; AlternativeAddress[7])
            {
            }
            column(AlternativeAddress8; AlternativeAddress[8])
            {
            }
            column(CustomerSirenNo; Cust.GetSIRENNoWithCaption())
            {
            }
            column(GoodsAndServices_Lbl; GetGoodsAndServicesText())
            {
            }
            column(VATPaidOnDebits_Lbl; GetVATPaidOnDebitsText())
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
            column(VATClause_Lbl; VATClause.TableCaption())
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
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
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
                column(Description2_Line; Line."Description 2")
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
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; GTxtItemNo)
                {
                }
                column(ItemNo_Line_Lbl; GTxtItemNo_Line_Lbl)
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
                column(Quantity_Line; Quantity)
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
                column(NomenclatureArticle; GTxtNomenclatureArticle)
                {
                }

                trigger OnAfterGetRecord()
                var
                    text001: Label '%1%', Comment = '%1=Line Discount %';
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
                    OnLineOnAfterGetRecordOnAfterCalcTotals(Header, Line, TotalAmount, TotalAmountVAT, TotalAmountInclVAT);

                    if "VAT Clause Code" <> '' then
                        if VATAmountLine.Get("VAT Identifier", "VAT Calculation Type", "Tax Group Code", false, "Line Amount" >= 0) then begin
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.Modify();
                        end;

                    FormatLineValues(Line);

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
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
                    MoreLines := Findlast();
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

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                    // DEB DELPHI XAV
                    if VATClause.GET(Line."VAT Clause Code") then begin
                        VATClause.TranslateDescription(Header."Language Code");
                        GTxtVATClause1 += ' ' + VATClause.Description + ' ' + VATClause."Description 2";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

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
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClauseText)
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
                column(NoOfVATClauses; Count)
                {
                }
                column(VATClause1; GTxtVATClause1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip();
                    VATClauseText := VATClause.GetDescriptionText(Header);
                end;

                trigger OnPreDataItem()
                begin
                    if Count = 0 then
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
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
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
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
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
#if not CLEAN22
                ArchiveManagement: Codeunit ArchiveManagement;
#endif
                SalesPost: Codeunit "Sales-Post";
            begin
                FirstLineHasBeenOutput := false;
                Clear(Line);
                VATAmountLine.DeleteAll();
                VATClauseLine.DeleteAll();
                Line.DeleteAll();
                Clear(SalesPost);
                SalesPost.GetSalesLines(Header, Line, 0);
                OnAfterSalesPostGetSalesLines(Header, Line);

                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);
                OnHeaderOnAfterGetRecordOnAfterUpdateVATOnLines(Header, Line, VATAmountLine);

                CurrReport.Language := CULanguage.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := CULanguage.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                FormatAddressFields(Header);
                DocumentTitleText := SalesConfirmationLbl;
                YourDocumentTitleText := StrSubstNo(YourDocLbl, SalesConfirmationLbl);
                InvoiceNoText := InvNoLbl;
                BodyContentText := BodyLbl;
                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

#if not CLEAN22
                if not IsReportInPreviewMode() and BoolArchiveDocument then
                    ArchiveManagement.StoreSalesDocument(Header, false);
#endif

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
                    Caption = 'Options';
                    field(LogInteractionField; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
#if not CLEAN22
                    field(ArchiveDocument; BoolArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you print it. Note: This option is going to be discontinued in future releases. Instead, for sales invoice versioning you can use the feature to attach draft invoice printout as PDF document.';
                        ObsoleteReason = 'Archiving of Sales Invoice document is not supported.';
                        ObsoleteState = Pending;
                        ObsoleteTag = '22.0';
                    }
#endif
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
#if not CLEAN22
            BoolArchiveDocument := SalesSetup."Archive Orders";
#endif
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    rendering
    {
        layout("StandardSalesDraftInvoice.rdlc")
        {
            Type = RDLC;
            LayoutFile = './Sales/Document/StandardSalesDraftInvoice.rdlc';
            Caption = 'Standard Sales Draft Invoice (RDLC)';
            Summary = 'The Standard Sales Draft Invoice (RDLC) provides a detailed layout.';
        }
        layout("StandardSalesDraftInvoice.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesDraftInvoice.docx';
            Caption = 'Standard Sales Draft Invoice (Word)';
            Summary = 'The Standard Sales Draft Invoice (Word) provides a basic layout.';
        }
        layout("StandardDraftSalesInvoiceBlue.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardDraftSalesInvoiceBlue.docx';
            Caption = 'Standard Sales Draft Invoice - Blue (Word)';
            Summary = 'The Standard Sales Draft Invoice -Blue (Word) provides a basic layout with a blue theme.';
        }
        layout("StandardDraftSalesInvoiceEmail.docx")
        {
            Type = Word;
            LayoutFile = './Sales/Document/StandardSalesDraftInvoice.docx';
            Caption = 'Standard Sales Draft Invoice Email (Word)';
            Summary = 'The Standard Sales Draft Invoice Email (Word) provides a email body layout.';
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
        //DEB DELPHI XAV
        GTxtVATClause1 := '';
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage() then
            InitLogInteraction();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then begin
            Header.SetLoadFields("No.", "Bill-to Contact No.", "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
            if Header.FindSet() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          26, Header."No.", 0, 0,
                          Database::Contact, Header."Bill-to Contact No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          26, Header."No.", 0, 0,
                          Database::Customer, Header."Bill-to Customer No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.");
                until Header.Next() = 0;
        end;
    end;

    var
        DummyCompanyInfo: Record "Company Information";
        VATClause: Record "VAT Clause";
        GrecTransporteur: Record "Shipping Agent";
        GRecItem: Record Item;
        GrecTraductionTransport: Record "Shipment Method Translation";
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        CULanguage: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        WorkDescriptionInstream: InStream;
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ChecksPayableText: Text;
        ShipToAddr: array[8] of Text[100];
        AlternativeAddress: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[50];
#if not CLEAN22
        BoolArchiveDocument: Boolean;
#endif
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        PmtDiscText: Text;
        AlternativeAddressTxt: Text;
        PaymentInstructionsTxt: Text;
        YourDocumentTitleText: Text;
        DocumentTitleText: Text;
        InvoiceNoText: Text;
        VATClausesText: Text;
        BodyContentText: Text;
        NextInvoiceNo: Text;
        SalesConfirmationLbl: Label 'Draft Invoice';
        YourDocLbl: Label 'Your %1', Comment = 'Your Draft Invoice or Your Invoice';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Draft Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 = Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your draft invoice is attached to this message.';
        UnitLbl: Label 'Unit';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        LCYTxt: label ' (LCY)';
        IncludesGoodsLbl: Label 'Sales invoice includes only goods.';
        IncludesServicesLbl: Label 'Sales invoice includes only services.';
        IncludesGoodsAndServicesLbl: Label 'Sales invoice includes goods and services.';
        VATClauseText: Text;
        CustomGiroLbl, CustomGiroTxt, LegalOfficeLbl, LegalOfficeTxt, LegalStatementLbl : Text;
        GTxtCondLivraisonEtendues: Text[150];
        GTxtTransporteur: Text[80];
        GTxtNomenclatureArticle: Text[20];
        GTxtBankName: Text;//[50];
        GTxtBankBranchNo: Text[20];
        GTxtBankAcountNo: Text[30];
        GTxtBankIBAN: Text[50];
        GTxtBankSwift: Text[20];
        GTxtVATClause1: Text[1024];
        GTxtTraductionTransport: Text;//[80];
        GTxtCompanyInfoPays: Text[50];
        GTxtNumTVAClient: Text[60];
        GTxtNumTVAClient_Lbl: Text[60];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtItemNo: Text[20];
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyHomepage: Label 'Website';
        GTxtCompanyVAT: Label 'VAT Id. Num.';
        GTxtCompanyGesch: Label 'Director';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyTrib: Label 'Trial court';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanySalespers: Label 'Agent';
        GTxtCustomerNum: Label 'Customer num.';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        GTxtItemNo_Line_Lbl: Label 'Item No.';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.';
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];

    protected var
        CompanyBankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        FirstLineHasBeenOutput: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowShippingAddr: Boolean;
        ShowWorkDescription: Boolean;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TotalSubTotal: Decimal;
        TransHeaderAmount: Decimal;
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];


    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Draft Invoice") <> '';
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels(GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure GetGoodsAndServicesText(): Text
    var
        SalesLine: Record "Sales Line";
        GotGoods: Boolean;
        GotServices: Boolean;
    begin
        SalesLine.SetRange("Document No.", Header."No.");
        SalesLine.SetRange("Document Type", Header."Document Type");
        SalesLine.SetFilter(Type, '<> %1', SalesLine.Type::Item);
        if not SalesLine.IsEmpty() then
            GotServices := true;
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetLoadFields("No.");
        if SalesLine.FindSet() then
            repeat
                if IsItemInventory(SalesLine."No.") then
                    GotGoods := true
                else
                    GotServices := true;
            until SalesLine.Next() = 0;
        if GotServices then
            if GotGoods then
                exit(IncludesGoodsAndServicesLbl)
            else
                exit(IncludesServicesLbl)
        else
            exit(IncludesGoodsLbl);
    end;

    local procedure IsItemInventory(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        Item.SetLoadFields(Type);
        if Item.Get(ItemNo) then
            exit(Item.Type = Item.Type::Inventory);
    end;

    local procedure GetVATPaidonDebitsText(): Text
    begin
        if Header."VAT Paid on Debits" then
            exit(Header.FieldCaption("VAT Paid on Debits"));
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSalesPostGetSalesLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
        if ShowShippingAddr then begin
            for i := 1 to 8 do
                AlternativeAddress[i] := ShipToAddr[i];
            AlternativeAddressTxt := ShiptoAddrLbl;
        end;
    end;

    local procedure FormatLineValues(CurrLine: Record "Sales Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFormatLineValues(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount, IsHandled);
        if not IsHandled then
            FormatDocument.SetSalesLine(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHeaderOnAfterGetRecordOnAfterUpdateVATOnLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLineOnAfterGetRecordOnAfterCalcTotals(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var VATBaseAmount: Decimal; var VATAmount: Decimal; var TotalAmountInclVAT: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFormatLineValues(SalesLine: Record "Sales Line"; var FormattedQuantity: Text; var FormattedUnitPrice: Text; var FormattedVATPercentage: Text; var FormattedLineAmount: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInitReportForGlobalVariable(var IsHandled: Boolean; var LegalOfficeTxt: Text; var LegalOfficeLbl: Text; var CustomGiroTxt: Text; var CustomGiroLbl: Text; var LegalStatementLbl: Text)
    begin
    end;
}

