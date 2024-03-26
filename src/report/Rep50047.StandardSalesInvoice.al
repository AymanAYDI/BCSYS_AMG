namespace Microsoft.Sales.History;

using Microsoft.Assembly.History;
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
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Reflection;
using System.Text;
using System.Utilities;

report 50047 "Standard Sales-Invoice" //1306 Duplicate
{
    Caption = 'Sales - Invoice';
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    DefaultRenderingLayout = "StandardSalesInvoice.rdlc";

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
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
            column(CompanyVATRegistrationNo_Lbl; GTxtCompanyVAT)
            {
            }
            column(CompanyVAT_ICE_Lbl; GTxtCompanyVAT_ICE)
            {
            }
            column(TxtOrigineCE_ICE; GTxtOrigineCE)
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
            column(DisplayAdditionalFeeNote; BoolDisplayAdditionalFeeNote)
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
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
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
            column(DocumentCopyText; GTxtDocumentCopyText)
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
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderNo_Lbl; FieldCaption("Order No."))
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
            column(SalesPerson_Lbl; SalespersonLbl)
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
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
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
            column(SellToFaxNo; GetSellToCustomerFaxNo())
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(PaymentReference; GetPaymentReference())
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
            column(PaymentReference_Lbl; GetPaymentReferenceLbl())
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
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(HomePage_Header_Lbl; HomePageLbl)
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
            column(DocumentTitle_Lbl; DocumentCaption())
            {
            }
            column(YourDocumentTitle_Lbl; YourSalesInvoiceLbl)
            {
            }
            column(Thanks_Lbl; ThanksLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }
            column(RemainingAmountText; RemainingAmountTxt)
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
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
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
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(ShipAgent; Header."Shipping Agent Code")
            {
            }
            column(NomTransporteur; GTxtTransporteur)
            {
            }
            column(MentionLegalFR; GTxTMentionLegaleFR)
            {
            }
            column(NumTVAClient; GTxtNumTVAClient)
            {
            }
            column(FactorNom; FactorNom)
            {
            }
            column(FactorTel; FactorTel)
            {
            }
            column(FactorEmail; FactorEMail)
            {
            }
            column(FactorAdresse; FactorAdresse)
            {
            }
            column(FactorBanque; FactorBanque)
            {
            }
            column(FactorRIB; FactorRIB)
            {
            }
            column(FactorIBAN; FactorIBAN)
            {
            }
            column(FacteurBIC; FactorBIC)
            {
            }
            column(FactorTextDebut; FactorTextPrecedent)
            {
            }
            column(FactorTexteFin; FactorTexteFin)
            {
            }
            column(FactorTexteMilieu; FactorTexteMilieu)
            {
            }
            column(NumCommande; TLblNoCommande)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No."))
            {
            }
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
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
                    AutoFormatExpression = GetCurrencyCode();
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
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
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
                    AutoFormatExpression = GetCurrencyCode();
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
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobNo; JobNo)
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
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = sorting("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    LRecCountry: Record 9;
                    Text001: Label '%1%', Comment = '%1 = Line Discount %';
                begin
                    //DEB DELPHI XAV 11/26/2018
                    //DELPHI AUB 22.10.2019 1Šre ligne comment‚e pour ne pas faire afficher les textes ‚tendus
                    //IF (Line.Type = Line.Type::Item) OR (Line.Type = Line.Type::"G/L Account") THEN
                    if Line.Quantity = 0 then
                        CurrReport.SKIP();
                    //FIN DELPHI XAV 11/26/2018

                    InitializeShipmentLine();
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo(Text001, -Round("Line Discount %", 0.1));

                    InsertVATAmountLine(VATAmountLine, Line);

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    JobNo := "Job No.";
                    JobTaskNo := "Job Task No.";

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    FormatLineValues(Line);
                    // DEB DELPHI XAV
                    GTxtNomenclatureArticle := '';
                    GTxtCodeRegionOrigine := '';
                    if Line.Type = Line.Type::Item then begin
                        if GBooFactureExport then
                            if GRecItem.GET(Line."No.") then
                                if GRecItem."Tariff No." <> '' then
                                    GTxtNomenclatureArticle := TarifDouanier + ' ' + GRecItem."Tariff No.";
                        //DELPHI AUB 01.10.2019
                        GRecItem.RESET();

                        if GRecItem.GET(Line."No.") then begin
                            if (GRecItem."Tariff No." <> '') and GBooAffichageOrigine then
                                GTxtNomenclatureArticle := 'TD :' + GRecItem."Tariff No."
                            else
                                GTxtNomenclatureArticle := '';
                            if (GRecItem."Country/Region of Origin Code" <> '') and GBooAffichageOrigine then begin
                                if LRecCountry.GET(GRecItem."Country/Region of Origin Code") then
                                    GTxtCodeRegionOrigine := ' Origine: ' + LRecCountry.Name
                            end else
                                GTxtCodeRegionOrigine := '';
                        end;
                        //END DELPHI AUB
                    end;

                    GTxtDesignationComplete := Line.Description + ' ' + Line."Description 2";
                    // FIN DELPHI XAV
                    //DELPHI AUB 15/02/2019
                    GTxtItemNo := Line."No.";
                    if Line.Type = Line.Type::Item then
                        if Line."Item Reference No." <> '' then
                            GTxtItemNo := Line."Item Reference No.";
                    //END DELPHI AUB
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
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

                    OnAfterLineOnPreDataItem(Header, Line);
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
                var
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator());
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
                    AutoFormatExpression = Line.GetCurrencyCode();
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
                    TotalVATBaseOnVATAmtLine += "VAT Base";
                    TotalVATAmountOnVATAmtLine += "VAT Amount";

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                    TotalVATBaseOnVATAmtLine := 0;
                    TotalVATAmountOnVATAmtLine := 0;
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
                    // DEB DELPHI XAV
                    GTxtVATClause1 += ' ' + VATClause.Description + ' ' + VATClause."Description 2";
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
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
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
            dataitem(LineFee; "Integer")
            {
                DataItemTableView = sorting(Number) order(ascending) where(Number = filter(1 ..));
                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not BoolDisplayAdditionalFeeNote then
                        CurrReport.Break();

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FindSet() then
                            CurrReport.Break()
                    end else
                        if TempLineFeeNoteOnReportHist.Next() = 0 then
                            CurrReport.Break();
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
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
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
                column(TotalNetAmount; Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }
                column(TotalAmountIncludingVAT; Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmount; Format(TotalAmountVAT, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalInvoiceDiscountAmount; Format(TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
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
                column(TotalSubTotal; Format(TotalSubTotal, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalSubTotalMinusInvoiceDiscount; Format(TotalSubTotal + TotalInvDiscAmount, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalAmountExclInclVAT; Format(TotalAmountExclInclVATValue, 0, AutoFormat.ResolveAutoFormat("Auto Format"::AmountFormat, Header."Currency Code")))
                {
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
                {
                }
                column(TotalVATBaseOnVATAmtLine; TotalVATBaseOnVATAmtLine)
                {
                }
                column(TotalVATAmountOnVATAmtLine; TotalVATAmountOnVATAmtLine)
                {
                }
                column(CurrencyCode; CurrCode)
                {
                }
                column(CurrencySymbol; CurrSymbol)
                {
                }

                trigger OnPreDataItem()
                begin
                    if Header."Prices Including VAT" then begin
                        TotalAmountExclInclVATTextValue := TotalExclVATText;
                        TotalAmountExclInclVATValue := TotalAmount;
                    end else begin
                        TotalAmountExclInclVATTextValue := TotalInclVATText;
                        TotalAmountExclInclVATValue := TotalAmountInclVAT;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Currency: Record Currency;
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                GeneralLedgerSetup: Record "General Ledger Setup";
                PaymentServiceSetup: Record "Payment Service Setup";
            begin
                CurrReport.Language := CULanguage.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := CULanguage.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                FillLeftHeader();
                FillRightHeader();

                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", Header);
                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

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

                GetLineFeeNoteOnReportHist("No.");

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                CalcFields("Amount Including VAT");
                RemainingAmount := GetRemainingAmount();
                if RemainingAmount = 0 then
                    RemainingAmountTxt := AlreadyPaidLbl
                else
                    if RemainingAmount <> "Amount Including VAT" then
                        RemainingAmountTxt := StrSubstNo(PartiallyPaidLbl, Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
                    else
                        RemainingAmountTxt := '';

                OnAfterGetSalesHeader(Header);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;
                if ("Order No." = '') and "Prepayment Invoice" then
                    "Order No." := "Prepayment Order No.";
                // DELPHI AUB 11.06.2019
                GTxtCompanyVAT_ICE := 'No. TVA';
                GTxtOrigineCE := '';
                if Cust.ICE then begin
                    GTxtCompanyVAT_ICE := 'No. ICE';
                    GTxtOrigineCE := 'L''exportateur des produits couverts par le pr‚sent document d‚clare que sauf indication claire du contraire ces produits ont l''origine pr‚f‚rentielle CE.';
                end;
                if Cust."VAT Registration No." = '' then
                    GTxtCompanyVAT_ICE := '';

                // DEB DELPHI XAV
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

                if GRecCust2.GET("Bill-to Customer No.") then
                    GTxtNumTVAClient := GRecCust2."VAT Registration No.";

                if Header."Order No." <> '' then
                    "GTxtNøCommande" := TLblNoCommande + ' ' + Header."Order No.";

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
                    field(LogInteraction; BoolLogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                    field(DisplayShipmentInformation; BoolDisplayShipmentInformation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Shipments';
                        ToolTip = 'Specifies that shipments are shown on the document.';
                    }
                    field(DisplayAdditionalFeeNote; BoolDisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
                    }
                }
                group("Options AMG")
                {
                    Caption = 'Options AMG';
                    field("Facture FR Factor"; GBooFactureFranceAvecFactor)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                        trigger OnValidate()
                        begin
                            if GBooFactureFranceAvecFactor then
                                GBooFactureExportAvecFactor := false;
                        end;
                    }
                    field("Facture Export"; GBooFactureExport)
                    {
                        Caption = 'Facture Export';
                    }
                    field("Facture Export Factor"; GBooFactureExportAvecFactor)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Export invoice with Factor';
                        trigger OnValidate()
                        begin
                            if GBooFactureExportAvecFactor then begin
                                GBooFactureExport := true;
                                GBooFactureFranceAvecFactor := false;
                            end;
                        end;
                    }
                    field(AffichageOrigine; GBooAffichageOrigine)
                    {
                        Caption = 'Origin Display';
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
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := BoolLogInteraction;
        end;
    }

    rendering
    {
        layout("StandardSalesInvoice.rdlc")
        {
            Type = RDLC;
            LayoutFile = './Sales/History/StandardSalesInvoice.rdlc';
            Caption = 'Standard Sales Invoice (RDLC)';
            Summary = 'The Standard Sales Invoice (RDLC) is the most detailed layout and provides most flexible layout options.';
        }
        layout("StandardSalesInvoice.docx")
        {
            Type = Word;
            LayoutFile = './Sales/History/StandardSalesInvoice.docx';
            Caption = 'Standard Sales Invoice (Word)';
            Summary = 'The Standard Sales Invoice (Word) provides a simple layout that is also relatively easy for an end-user to modify.';
        }
        layout("StandardSalesInvoiceBlueSimple.docx")
        {
            Type = Word;
            LayoutFile = './Sales/History/StandardSalesInvoiceBlueSimple.docx';
            Caption = 'Standard Sales Invoice - Blue (Word)';
            Summary = 'The Standard Sales Invoice - Blue (Word) provides a simple layout with a blue theme.';
        }
        layout("StandardSalesInvoiceVatSpec.docx")
        {
            Type = Word;
            LayoutFile = './Sales/History/StandardSalesInvoiceVatSpec.docx';
            Caption = 'Standard Sales Invoice - VAT Spec (Word)';
            Summary = 'The Standard Sales Invoice - VAT Spec (Word) provides a layout with VAT Specification.';
        }
        layout("StandardSalesInvoiceDefEmail.docx")
        {
            Type = Word;
            LayoutFile = './Sales/History/StandardSalesInvoiceDefEmail.docx';
            Caption = 'Standard Sales Invoice Email (Word)';
            Summary = 'The Standard Sales Invoice Email (Word) provides the default email body layout.';
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();

        if SalesInvoiceHeader.GetLegalStatement() <> '' then
            LegalStatementLbl := SalesInvoiceHeader.GetLegalStatement();

        IsHandled := false;
#if not CLEAN23
        if not IsHandled then begin
            LegalOfficeTxt := CompanyInfo.GetLegalOffice();
            LegalOfficeLbl := CompanyInfo.GetLegalOfficeLbl();
            CustomGiroTxt := CompanyInfo.GetCustomGiro();
            CustomGiroLbl := CompanyInfo.GetCustomGiroLbl();
            // DEB DELPHI XAV
            GTxtVATClause1 := '';
            FactorNom := '';
            FactorBanque := '';
            FactorAdresse := '';
            FactorEMail := '';
            FactorTel := '';
            FactorBIC := '';
            FactorIBAN := '';
            FactorRIB := '';
            FactorTextPrecedent := '';
            FactorTexteFin := '';
            //DELPHI AUB 16.05.2019 changement textes
            FactorTexteMilieu := '';
        end;
#endif
    end;

    trigger OnPostReport()
    begin
        if BoolLogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
        // DEB DELPHI XAV
        if GBooFactureExportAvecFactor then begin //Export avec Factor 
            FactorNom := 'Old WELSH House domiciled at ' + CompanyInfo."Name Factor";
            FactorBanque := '';
            FactorAdresse := CompanyInfo."Adress Factor";
            FactorEMail := 'E-mail : ' + CompanyInfo."EMail Factor";
            FactorTel := 'Tel : ' + CompanyInfo."phone Factor";
            FactorBIC := ' ' + CompanyInfo."BIC Factor Exp";
            FactorIBAN := 'IBAN : ' + CompanyInfo."IBAN Factor Exp";
            FactorRIB := '';
            FactorTexteFin := TxtFinFactor;
            FactorTextPrecedent := TxtDebutFactor;
            FactorTexteMilieu := TxtMilieuFactor;
        end;

        if GBooFactureFranceAvecFactor then begin // France avec Factor
            FactorNom := CompanyInfo."Name Factor";
            FactorBanque := '';
            FactorAdresse := CompanyInfo."Adress Factor";
            FactorEMail := 'E-mail : ' + CompanyInfo."EMail Factor";
            FactorTel := 'Tel : ' + CompanyInfo."phone Factor";
            FactorBIC := 'BIC ' + CompanyInfo."BIC Factor";
            FactorIBAN := 'IBAN' + CompanyInfo."IBAN Factor";
            FactorRIB := '';
            FactorTexteFin := TxtFinFactor;
            FactorTextPrecedent := TxtDebutFactor;
            FactorTexteMilieu := TxtMilieuFactor;
        end;
    end;

    var
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        DummyCompanyInfo: Record "Company Information";
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        GRecItem: Record Item;
        RespCenter: Record "Responsibility Center";
        GrecTraductionTransport: Record "Shipment Method Translation";
        GrecTransporteur: Record "Shipping Agent";
        VATClause: Record "VAT Clause";
        AutoFormat: Codeunit "Auto Format";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        CULanguage: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        GBooAffichageOrigine: Boolean;
        GBooFactureExport: Boolean;
        GBooFactureExportAvecFactor: Boolean;
        GBooFactureFranceAvecFactor: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        TransHeaderAmount: Decimal;
        WorkDescriptionInstream: InStream;
        CompanyLogoPosition: Integer;
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        BilledToLbl: Label 'Billed to';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        ClosingLbl: Label 'Sincerely';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        FromLbl: Label 'From';
        GreetingLbl: Label 'Hello';
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyPhoneNo: Label 'Phone';
        GTxtCompanyVAT: Label 'VAT Id. Num.';
        GTxtDocumentCopyText: Label 'Invoice';
        GTxtItemNo_Line_Lbl: Label 'Item No.';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        HomePageLbl: Label 'Home Page';
        IncludesGoodsAndServicesLbl: Label 'Sales invoice includes goods and services.';
        IncludesGoodsLbl: Label 'Sales invoice includes only goods.';
        IncludesServicesLbl: Label 'Sales invoice includes only services.';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        JobNoLbl2: Label 'Job No.';
        JobTaskDescLbl: Label 'Job Task Description';
        JobTaskNoLbl2: Label 'Job Task No.';
        LCYTxt: label ' (LCY)';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        PageLbl: Label 'Page';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        PaymentMethodDescLbl: Label 'Payment Method';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        PostedShipmentDateLbl: Label 'Shipment Date';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        QuestionsLbl: Label 'Questions?';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        SalespersonLbl: Label 'Salesperson';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        ShipmentLbl: Label 'Shipment';
        SubtotalLbl: Label 'Subtotal';
        TarifDouanier: Label 'TD :';
        ThanksLbl: Label 'Thank You!';
        TLblNoCommande: Label 'Order No.';
        TotalLbl: Label 'Total';
        TxtDebutFactor: Label 'To be discharged, your payment must be made directly to the order of:';
        TxtFinFactor: Label 'All complaints and requests for information must be addressed to:';
        TxtMilieuFactor: Label 'who receives it by subrogation under a factoring contract. Payment by bank transfer :';
        UnitLbl: Label 'Unit';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATAmtLbl: Label 'VAT Amount';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        YourSalesInvoiceLbl: Label 'Your Invoice';
        ChecksPayableText: Text;
        CustomGiroLbl, CustomGiroTxt, LegalOfficeLbl, LegalOfficeTxt, LegalStatementLbl : Text;
        ExchangeRateText: Text;
        FactorEMail: Text;//[100];
        GTxtBankName: Text;//[50];
        GTxtCodeRegionOrigine: Text;//[50];
        GTxtTraductionTransport: Text;//[80];
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        PaymentInstructionsTxt: Text;
        RemainingAmountTxt: Text;
        TotalAmountExclInclVATTextValue: Text;
        VATClausesText: Text;
        VATClauseText: Text;
        WorkDescriptionLine: Text;
        GTxtBankBranchNo: Text[20];
        GTxtBankSwift: Text[20];
        GTxtItemNo: Text[50];
        FactorTel: Text[30];
        GTxtBankAcountNo: Text[30];
        FactorBIC: Text[40];
        GTxtBankIBAN: Text[50];
        GTxtCompanyInfoPays: Text[50];
        SalesPersonText: Text[50];
        GTxtNumTVAClient: Text[60];
        "GTxtNøCommande": Text[65];
        GTxtCompanyVAT_ICE: Text[80];
        GTxtTransporteur: Text[80];
        FactorAdresse: Text[100];
        FactorBanque: Text[100];
        FactorIBAN: Text[100];
        FactorRIB: Text[100];
        GTxtNomenclatureArticle: Text[100];
        JobTaskDescription: Text[100];
        GTxtCondLivraisonEtendues: Text[120];
        FactorNom: Text[200];
        FactorTexteFin: Text[250];
        FactorTexteMilieu: Text[250];
        FactorTextPrecedent: Text[250]; //FactorTextPrevious
        GTxtDesignationComplete: Text[250];
        GTxtOrigineCE: Text[250];
        GTxtVATClause1: Text[1024];

    protected var
        CompanyBankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        BoolDisplayAdditionalFeeNote: Boolean;
        BoolDisplayShipmentInformation: Boolean;
        BoolLogInteraction: Boolean;
        DisplayAssemblyInformation: Boolean;
        FirstLineHasBeenOutput: Boolean;
        ShowShippingAddr: Boolean;
        RemainingAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TotalSubTotal: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATAmountOnVATAmtLine: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATBaseOnVATAmtLine: Decimal;
        VATAmountLCY: Decimal;
        VATBaseLCY: Decimal;
        PaymentTermsDescLbl: Label 'Payment Terms';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        AlternativeAddressTxt: Text;
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        AlternativeAddress: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];


    local procedure InitLogInteraction()
    begin
        BoolLogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    local procedure InitializeShipmentLine(): Date
    var
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if Line.Type = Line.Type::" " then
            exit;

        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if Line.Type = Line.Type::" " then
            exit(0D);

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.FindFirst() then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not BoolDisplayShipmentInformation then
                if ShipmentLine.Next() = 0 then begin
                    ShipmentLine.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete();
                    exit(SalesShipmentBuffer2."Posting Date");
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit(Header."Posting Date");
            end;
        end;
        exit(Header."Posting Date");
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text[250];
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(SalesInvoiceLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        BoolLogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure GetGoodsAndServicesText(): Text
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        GotGoods: Boolean;
        GotServices: Boolean;
    begin
        SalesInvoiceLine.SetRange("Document No.", Header."No.");
        SalesInvoiceLine.SetFilter(Type, '<> %1', SalesInvoiceLine.Type::Item);
        if not SalesInvoiceLine.IsEmpty() then
            GotServices := true;
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SetLoadFields("No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                if IsItemInventory(SalesInvoiceLine."No.") then
                    GotGoods := true
                else
                    GotServices := true;
            until SalesInvoiceLine.Next() = 0;
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

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
        UOMDescription: Text[50];
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);

        UOMDescription := UnitOfMeasure.Description;
        exit(UOMDescription);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false, Header."Currency Code");
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false, Header."Currency Code");
            if TotalAmountVAT <> 0 then
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false, Header."Currency Code")
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false, Header."Currency Code");
        end;
        if TotalAmountVAT <> 0 then begin
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false, Header."Currency Code");
            if TotalVATAmountLCY <> TotalAmountVAT then
                ReportTotalsLine.Add(VATAmountLine.VATAmountText() + LCYTxt, TotalVATAmountLCY, false, true, false);
        end;
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet() then
            repeat
                TempLineFeeNoteOnReportHist.Init();
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0
        else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", CULanguage.GetUserLanguageCode());
            if LineFeeNoteOnReportHist.FindSet() then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll();

        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl(), Header.GetCustomerVATRegistrationNumber());
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl(), Header.GetCustomerGlobalLocationNumber());
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl(), Cust.GetLegalEntityType());
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);

        OnAfterFillLeftHeader(LeftHeader, Header);
    end;

    local procedure FillRightHeader()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then begin
            RightHeader.DeleteAll();

            FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
            FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
            FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
            FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl(), CompanyInfo.GetRegistrationNumber());
            FillNameValueTable(RightHeader, CompanyInfo.GetVATRegistrationNumberLbl(), CompanyInfo.GetVATRegistrationNumber());
            FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyBankAccount.Name);
            FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
            FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption(IBAN), CompanyBankAccount.IBAN);
            FillNameValueTable(RightHeader, CompanyBankAccount.FieldCaption("SWIFT Code"), CompanyBankAccount."SWIFT Code");
            FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl(), Header.GetPaymentReference());

            OnAfterFillRightHeader(RightHeader, Header);
        end;
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
        if ShowShippingAddr then begin
            for i := 1 to 8 do
                AlternativeAddress[i] := ShipToAddr[i];
            AlternativeAddressTxt := ShiptoAddrLbl;
        end;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        with SalesInvoiceHeader do begin
            FormatDocument.SetTotalLabels(GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure GetJobTaskDescription(_JobNo: Code[20]; _JobTaskNo: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", _JobNo);
        JobTask.SetRange("Job Task No.", _JobTaskNo);
        if JobTask.FindFirst() then
            exit(JobTask.Description);

        exit('');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillLeftHeader(var LeftHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillRightHeader(var RightHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceLine: Record "Sales Invoice Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text[250])
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterGetSalesHeader(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    local procedure InsertVATAmountLine(var VATAmountLine2: Record "VAT Amount Line"; SalesInvoiceLine: Record "Sales Invoice Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        VATAmountLine2.Init();
        VATAmountLine2."VAT Identifier" := SalesInvoiceLine."VAT Identifier";
        VATAmountLine2."VAT Calculation Type" := SalesInvoiceLine."VAT Calculation Type";
        VATAmountLine2."Tax Group Code" := SalesInvoiceLine."Tax Group Code";
        VATAmountLine2."VAT %" := SalesInvoiceLine."VAT %";
        VATAmountLine2."VAT Base" := SalesInvoiceLine.Amount;
        VATAmountLine2."Amount Including VAT" := SalesInvoiceLine."Amount Including VAT";
        VATAmountLine2."Line Amount" := SalesInvoiceLine."Line Amount";
        if SalesInvoiceLine."Allow Invoice Disc." then
            VATAmountLine2."Inv. Disc. Base Amount" := SalesInvoiceLine."Line Amount";
        VATAmountLine2."Invoice Discount Amount" := SalesInvoiceLine."Inv. Discount Amount";
        VATAmountLine2."VAT Clause Code" := SalesInvoiceLine."VAT Clause Code";
        if (SalesInvoiceLine."VAT %" <> 0) or (SalesInvoiceLine."VAT Clause Code" <> '') or (SalesInvoiceLine.Amount <> SalesInvoiceLine."Amount Including VAT") then
            VATAmountLine2.InsertLine();
    end;

    local procedure FormatLineValues(CurrLine: Record "Sales Invoice Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            FormatDocument.SetSalesInvoiceLine(CurrLine, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
    end;
}

