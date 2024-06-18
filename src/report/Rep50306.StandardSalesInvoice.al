namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.History;
using Microsoft.Finance.VAT.Calculation;
using System.Utilities;
using Microsoft.Assembly.History;
using Microsoft.Foundation.Reporting;
using Microsoft.Bank.Setup;
using Microsoft.Utilities;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Team;
using Microsoft.Sales.Customer;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Reminder;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Inventory.Item;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Contact;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Receivables;
using Microsoft.Foundation.UOM;
using System.EMail;
using Microsoft.CRM.Interaction;
report 50306 "Standard Sales - Invoice"
{
    RDLCLayout = './src/report/rdl/StandardSalesInvoice.rdl';
    WordLayout = './src/report/rdl/StandardSalesInvoice.docx';
    Caption = 'Sales - Invoice', Comment = 'FRA="Ventes : Facture"';
    DefaultLayout = Word;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice', Comment = 'FRA="Facture vente enregistrée"';
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
            column(CompanyVATRegistrationNo_Lbl; GTxtCompanyVAT)
            {
            }
            column(CompanyVAT_ICE_Lbl; GTxtCompanyVAT_ICE)
            {
            }
            column(TxtOrigineCE_ICE; GTxtOrigineCE)
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
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
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
            column(YourReference_Lbl; FIELDCAPTION("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShipmentDate; FORMAT("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FIELDCAPTION("Shipment Date"))
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
            column(DocumentCopyText; GTxtDocumentCopyText)
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
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderNo_Lbl; FIELDCAPTION("Order No."))
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
            column(SelltoCustomerNo_Lbl; FIELDCAPTION("Sell-to Customer No."))
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
            column(VATClause_Lbl; VATClause.TABLECAPTION)
            {
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FIELDCAPTION("Package Tracking No."))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FIELDCAPTION("Shipping Agent Code"))
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
            column(FactorTextDebut; FactorTextPrécédent)
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
                column(AmountExcludingVAT_Line_Lbl; FIELDCAPTION(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FIELDCAPTION("Amount Including VAT"))
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
                    AutoFormatExpression = GetCurrencyCode();
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
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
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
                    column(PostingDate_ShipmentLine_Lbl; FIELDCAPTION("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FIELDCAPTION(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SETRANGE("Line No.", Line."Line No.");
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
                        CLEAR(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.BREAK();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    LRecCountry: Record "Country/Region";
                begin
                    //DEB DELPHI XAV 11/26/2018
                    //DELPHI AUB 22.10.2019 1ère ligne commentée pour ne pas faire afficher les textes étendus
                    //IF (Line.Type = Line.Type::Item) OR (Line.Type = Line.Type::"G/L Account") THEN
                    if Line.Quantity = 0 then
                        CurrReport.SKIP();
                    //FIN DELPHI XAV 11/26/2018
                    InitializeShipmentLine();
                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := STRSUBSTNO('%1%', -ROUND("Line Discount %", 0.1));

                    VATAmountLine.INIT();
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    if ("VAT %" <> 0) or ("VAT Clause Code" <> '') or (Amount <> "Amount Including VAT") then
                        VATAmountLine.InsertLine();

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        CLEAR(CompanyInfo.Picture);
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

                    FormatDocument.SetSalesInvoiceLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

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
                    VATAmountLine.DELETEALL();
                    VATClauseLine.DELETEALL();
                    ShipmentLine.RESET();
                    ShipmentLine.DELETEALL();
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
                    AutoFormatExpression = Line.GetCurrencyCode();
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
                    // DEB DELPHI XAV
                    GTxtVATClause1 += ' ' + VATClause.Description + ' ' + VATClause."Description 2";
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
            dataitem(LineFee; Integer)
            {
                DataItemTableView = sorting(Number)
                                    order(ascending)
                                    where(Number = filter(1 ..));
                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not DisplayAdditionalFeeNote then
                        CurrReport.BREAK();

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FINDSET() then
                            CurrReport.BREAK()
                    end else
                        if TempLineFeeNoteOnReportHist.NEXT() = 0 then
                            CurrReport.BREAK();
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
                column(TotalAmountExclInclVAT; TotalAmountExclInclVATValue)
                {
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
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
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                PaymentServiceSetup: Record "Payment Service Setup";
            begin
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                FillLeftHeader();
                FillRightHeader();

                if not IsReportInPreviewMode() then
                    CODEUNIT.RUN(CODEUNIT::"Sales Inv.-Printed", Header);

                CALCFIELDS("Work Description");
                ShowWorkDescription := "Work Description".HASVALUE;

                ChecksPayableText := STRSUBSTNO(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
                FormatDocumentFields(Header);

                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      ROUND(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := STRSUBSTNO(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                GetLineFeeNoteOnReportHist("No.");

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                CALCFIELDS("Amount Including VAT");
                RemainingAmount := GetRemainingAmount();
                if RemainingAmount = 0 then
                    RemainingAmountTxt := AlreadyPaidLbl
                else
                    if RemainingAmount <> "Amount Including VAT" then
                        RemainingAmountTxt := STRSUBSTNO(PartiallyPaidLbl, FORMAT(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
                    else
                        RemainingAmountTxt := '';

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;

                // DELPHI AUB 11.06.2019
                GTxtCompanyVAT_ICE := 'No. TVA';
                GTxtOrigineCE := '';
                if Cust.ICE then begin
                    GTxtCompanyVAT_ICE := 'No. ICE';
                    GTxtOrigineCE := 'L''exportateur des produits couverts par le présent document déclare que sauf indication claire du contraire ces produits ont l''origine préférentielle CE.';
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
                    "GTxtN°Commande" := TLblNoCommande + ' ' + Header."Order No.";

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
                    field(LogInteractionF; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInformationF; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components', Comment = 'FRA="Afficher composants d''assemblage"';
                    }
                    field(DisplayShipmentInformationF; DisplayShipmentInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Shipments', Comment = 'FRA="Afficher expéditions"';
                    }
                    field(DisplayAdditionalFeeNoteF; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Additional Fee Note', Comment = 'FRA="Afficher la note de frais supplémentaires"';
                    }
                }
                group(Optionen)
                {
                    Caption = 'Options', Comment = 'FRA="Options AMG"';
                    field("Facture FR Factor"; GBooFactureFranceAvecFactor)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction', Comment = 'FRA="Facture France avec Factor"';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if GBooFactureFranceAvecFactor then
                                GBooFactureExportAvecFactor := false;
                        end;
                    }
                    field("Facture Export"; GBooFactureExport)
                    {
                        Caption = 'Facture Export', Comment = 'FRA="Facture Export"';
                        ApplicationArea = All;
                    }
                    field("Facture Export Factor"; GBooFactureExportAvecFactor)
                    {
                        Caption = 'Facture Export avec Factor', Comment = 'FRA="Facture Export avec Factor"';
                        ApplicationArea = All;

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
                        Caption = 'Affichage Origine', Comment = 'FRA="Affichage Origine"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
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
        FactorTextPrécédent := '';
        FactorTexteFin := '';
        //DELPHI AUB 16.05.2019 changement textes
        FactorTexteMilieu := '';
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FINDSET() then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.NEXT() = 0;
    end;

    trigger OnPreReport()
    begin
        if Header.GETFILTERS = '' then
            ERROR(NoFilterSetErr);

        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";

        // DEB DELPHI XAV
        if GBooFactureExportAvecFactor then begin //Export avec Factor
            FactorNom := 'Ancienne Maison GALLOIS domiciliée chez ' + CompanyInfo."Nom Factor";
            FactorBanque := '';
            FactorAdresse := CompanyInfo."Adresse Factor";
            FactorEMail := 'E-mail : ' + CompanyInfo."EMail Factor";
            FactorTel := 'Tel : ' + CompanyInfo."Telephone Factor";
            FactorBIC := ' ' + CompanyInfo."BIC Factor Exp";
            FactorIBAN := 'IBAN : ' + CompanyInfo."IBAN Factor Exp";
            FactorRIB := '';
            FactorTexteFin := TxtFinFactor;
            FactorTextPrécédent := TxtDebutFactor;
            FactorTexteMilieu := TxtMilieuFactor;
        end;

        if GBooFactureFranceAvecFactor then begin // France avec Factor
            FactorNom := CompanyInfo."Nom Factor";
            FactorBanque := '';
            FactorAdresse := CompanyInfo."Adresse Factor";
            FactorEMail := 'E-mail : ' + CompanyInfo."EMail Factor";
            FactorTel := 'Tel : ' + CompanyInfo."Telephone Factor";
            FactorBIC := 'BIC ' + CompanyInfo."BIC Factor";
            FactorIBAN := 'IBAN' + CompanyInfo."IBAN Factor";
            FactorRIB := '';
            FactorTexteFin := TxtFinFactor;
            FactorTextPrécédent := TxtDebutFactor;
            FactorTexteMilieu := TxtMilieuFactor;
        end;
    end;

    var
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        GRecItem: Record Item;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        GrecTraductionTransport: Record "Shipment Method Translation";
        GrecTransporteur: Record "Shipping Agent";
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        LanguageMgt: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        DisplayAdditionalFeeNote: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        FirstLineHasBeenOutput: Boolean;
        GBooAffichageOrigine: Boolean;
        GBooFactureExport: Boolean;
        GBooFactureExportAvecFactor: Boolean;
        GBooFactureFranceAvecFactor: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowShippingAddr: Boolean;
        ShowWorkDescription: Boolean;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        CalculatedExchRate: Decimal;
        PrevLineAmount: Decimal;
        RemainingAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
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
        AlreadyPaidLbl: Label 'The invoice has been paid.', Comment = 'FRA="La facture a été payée."';
        BilledToLbl: Label 'Billed to', Comment = 'FRA="Facturé à"';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.', Comment = 'FRA="Merci de votre collaboration. Votre facture est jointe à ce message."';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = 'FRA="Les chèques peuvent être payés à %1"';
        ClosingLbl: Label 'Sincerely', Comment = 'FRA="Cordialement"';
        CompanyInfoBankNameLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CopyLbl: Label 'Copy', Comment = 'FRA="Copie"';
        EMailLbl: Label 'Email', Comment = 'FRA="Adresse e-mail"';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        FromLbl: Label 'From', Comment = 'FRA="De"';
        GreetingLbl: Label 'Hello', Comment = 'FRA="Bonjour"';
        GTxtCompanyBankBranch: Label 'Bk Code', Comment = 'FRA="Code Bq"';
        GTxtCompanyBankNr: Label 'Bk Num.', Comment = 'FRA="No. Cpte"';
        GTxtCompanyBankSWIFT: Label 'SWIFT', Comment = 'FRA="SWIFT"';
        GTxtCompanyFaxNo: Label 'Fax.', Comment = 'FRA="Fax."';
        GTxtCompanyPhoneNo: Label 'Phone', Comment = 'FRA="Tél."';
        GTxtCompanyVAT: Label 'VAT Id. Num.', Comment = 'FRA="No. TVA"';
        GTxtDocumentCopyText: Label 'Invoice', Comment = 'FRA="Facture N°"';
        GTxtItemNo_Line_Lbl: Label 'Item No.', Comment = 'FRA="N° d''article"';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.', Comment = 'FRA="Les retards de paiement sont soumis à un intérêt mensuel de 1,5%. Pas d’escompte pour règlement anticipé."';
        GTxtQuantity_Line_Lbl: Label 'Qty', Comment = 'FRA="Qté"';
        GTxtUnitOfMeasure_Lbl: Label 'Unit', Comment = 'FRA="Unité"';
        GTxtUnitPrice_Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unit."';
        HomePageLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvDiscountAmtLbl: Label 'Invoice Discount', Comment = 'FRA="Remise facture"';
        InvNoLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        JobNoLbl2: Label 'Job No.', Comment = 'FRA="N° projet"';
        JobTaskDescLbl: Label 'Job Task Description', Comment = 'FRA="Description tâche projet"';
        JobTaskNoLbl2: Label 'Job Task No.', Comment = 'FRA="N° tâche projet"';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LocalCurrencyLbl: Label 'Local Currency', Comment = 'FRA="Devise société"';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.', Comment = 'FRA="Vous devez spécifier un ou plusieurs filtres pour éviter d''imprimer accidentellement tous les documents."';
        PageLbl: Label 'Page', Comment = 'FRA="Page"';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = 'FRA="La facture a été payée partiellement. Le montant restant est de %1"';
        PaymentMethodDescLbl: Label 'Payment Method', Comment = 'FRA="Mode de règlement"';
        PaymentTermsDescLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = 'FRA="Si nous recevons le paiement avant le %1, vous pouvez bénéficier d''un escompte de 2%."';
        PostedShipmentDateLbl: Label 'Shipment Date', Comment = 'FRA="Date d''expédition"';
        PriceLbl: Label 'Price', Comment = 'FRA="Prix"';
        PricePerLbl: Label 'Price per', Comment = 'FRA="Code Bq"';
        QtyLbl: Label 'Qty', Comment = 'FRA="Qté"';
        QuestionsLbl: Label 'Questions?', Comment = 'FRA="Vous avez des questions?"';
        SalesInvLineDiscLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        SalesInvoiceLbl: Label 'Invoice', Comment = 'FRA="Facture"';
        SalespersonLbl: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        ShipmentLbl: Label 'Shipment', Comment = 'FRA="Expédition"';
        ShiptoAddrLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        ShptMethodDescLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        SubtotalLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        TarifDouanier: Label 'TD :', Comment = 'FRA="TD :"';
        ThanksLbl: Label 'Thank You!', Comment = 'FRA="Merci!"';
        TLblNoCommande: Label 'Order N°', Comment = 'FRA="N° Commande"';
        TotalLbl: Label 'Total', Comment = 'FRA="Total"';
        TxtDebutFactor: Label 'Pour être libératoire, votre règlement doit être effectué directement à l''ordre de :', Comment = 'FRA="Pour être libératoire, votre règlement doit être effectué directement à l''ordre de :"';
        TxtFinFactor: Label 'Toutes réclamations et demandes de renseignements doivent être adressées à :', Comment = 'FRA="Toutes réclamations et demandes de renseignements doivent être adressées à :"';
        TxtMilieuFactor: Label 'qui le recoit par subrogation dans le cadre d''un contrat d''affacturage. Paiement par virement :', Comment = 'FRA="qui le recoit par subrogation dans le cadre d''un contrat d''affacturage. Paiement par virement :"';
        UnitLbl: Label 'Unit', Comment = 'FRA="Unité"';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)', Comment = 'FRA="Montant TVA DS"';
        VATAmtLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATBaseLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATBaseLCYLbl: Label 'VAT Base (LCY)', Comment = 'FRA="Base TVA (DS)"';
        VATClausesLbl: Label 'VAT Clause', Comment = 'FRA="Clause TVA"';
        VATIdentifierLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATPercentageLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        YourSalesInvoiceLbl: Label 'Your Invoice', Comment = 'FRA="Votre facture"';
        ChecksPayableText: Text;
        ExchangeRateText: Text;
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        LineDiscountPctText: Text;
        PaymentInstructionsTxt: Text;
        PmtDiscText: Text;
        RemainingAmountTxt: Text;
        TotalAmountExclInclVATTextValue: Text;
        VATClausesText: Text;
        WorkDescriptionLine: Text;
        GTxtBankBranchNo: Text[20];
        GTxtBankSwift: Text[20];
        FactorTel: Text[30];
        GTxtBankAcountNo: Text[30];
        FactorBIC: Text[40];
        GTxtBankIBAN: Text[50];
        GTxtCompanyInfoPays: Text[50];
        GTxtItemNo: Text[50];
        SalesPersonText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        GTxtNumTVAClient: Text[60];
        "GTxtN°Commande": Text[65];
        GTxtCodeRegionOrigine: Text[80];
        GTxtCompanyVAT_ICE: Text[80];
        GTxtTransporteur: Text[80];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        FactorAdresse: Text[100];
        FactorBanque: Text[100];
        FactorEMail: Text[120];
        FactorIBAN: Text[100];
        FactorRIB: Text[100];
        GTxtBankName: Text[100];
        GTxtNomenclatureArticle: Text[100];
        GTxtTraductionTransport: Text[100];
        JobTaskDescription: Text[100];
        ShipToAddr: array[8] of Text[100];
        GTxtCondLivraisonEtendues: Text[120];
        FactorNom: Text[200];
        FactorTexteFin: Text[250];
        FactorTexteMilieu: Text[250];
        "FactorTextPrécédent": Text[250];
        GTxtDesignationComplete: Text[250];
        GTxtOrigineCE: Text[250];
        GTxtVATClause1: Text[1024];

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    local procedure InitializeShipmentLine(): Date
    var
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.GET(Line."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if Line.Type = Line.Type::" " then
            exit(0D);

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.RESET();
        ShipmentLine.SETRANGE("Line No.", Line."Line No.");
        if ShipmentLine.FIND('-') then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.NEXT() = 0 then begin
                    ShipmentLine.GET(
                      SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.DELETE();
                    exit(SalesShipmentBuffer2."Posting Date");
                end;
            ShipmentLine.CALCSUMS(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DELETEALL();
                exit(Header."Posting Date");
            end;
        end;
        exit(Header."Posting Date");
    end;

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: Text;
    begin
        if DocCaption <> '' then
            exit(DocCaption);
        exit(SalesInvoiceLbl);
    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DELETEALL();
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                if Header."Prices Including VAT" then
                    ReportTotalsLine.Add(TotalInclVATText, TotalAmountInclVAT, true, false, false)
                else
                    ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
    begin
        TempLineFeeNoteOnReportHist.DELETEALL();
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FINDFIRST() then
            exit;

        if not Customer.GET(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FINDSET() then
            repeat
                TempLineFeeNoteOnReportHist.INIT();
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT();
            until LineFeeNoteOnReportHist.NEXT() = 0
        else begin
            LineFeeNoteOnReportHist.SETRANGE("Language Code", LanguageMgt.GetUserLanguageCode());
            if LineFeeNoteOnReportHist.FINDSET() then
                repeat
                    TempLineFeeNoteOnReportHist.INIT();
                    TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.INSERT();
                until LineFeeNoteOnReportHist.NEXT() = 0;
        end;
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DELETEALL();

        FillNameValueTable(LeftHeader, Header.FIELDCAPTION("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FIELDCAPTION("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl(), Header.GetCustomerVATRegistrationNumber());
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl(), Header.GetCustomerGlobalLocationNumber());
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        FillNameValueTable(LeftHeader, Header.FIELDCAPTION("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FIELDCAPTION("Document Date"), FORMAT(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FIELDCAPTION("Due Date"), FORMAT(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl(), Cust.GetLegalEntityType());
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DELETEALL();

        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl(), CompanyInfo.GetRegistrationNumber());
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyInfo."Bank Name");
        FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
        FillNameValueTable(RightHeader, CompanyInfo.FIELDCAPTION(IBAN), CompanyInfo.IBAN);
        FillNameValueTable(RightHeader, CompanyInfo.FIELDCAPTION("SWIFT Code"), CompanyInfo."SWIFT Code");
        FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl(), Header.GetPaymentReference());
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            CLEAR(NameValueBuffer);
            if NameValueBuffer.FINDLAST() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.INIT();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := COPYSTR(Name, 1, MAXSTRLEN(NameValueBuffer.Name));
            NameValueBuffer.Value := COPYSTR(Value, 1, MAXSTRLEN(NameValueBuffer.Value));
            NameValueBuffer.INSERT();
        end;
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatDocument.SetTotalLabels(SalesInvoiceHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesInvoiceHeader."Payment Method Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
    end;

    local procedure GetJobTaskDescription(_JobNo: Code[20]; _JobTaskNo: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SETRANGE("Job No.", _JobNo);
        JobTask.SETRANGE("Job Task No.", _JobTaskNo);
        if JobTask.FINDFIRST() then
            exit(JobTask.Description);

        exit('');
    end;
}

