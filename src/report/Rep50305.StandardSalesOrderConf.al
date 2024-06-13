namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Reporting;
using Microsoft.Finance.VAT.Calculation;
using System.Utilities;
using Microsoft.Assembly.Document;
using Microsoft.CRM.Contact;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Interaction;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Team;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Finance.Currency;
using Microsoft.Utilities;
using Microsoft.Sales.Posting;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.CRM.Segment;
using Microsoft.Inventory.Item;
using System.EMail;
using Microsoft.Foundation.UOM;
report 50305 "Standard Sales - Order Conf."
{
    RDLCLayout = './src/report/rdl/StandardSalesOrderConf.rdl';
    WordLayout = './src/report/rdl/StandardSalesOrderConf.docx';
    Caption = 'Sales - Confirmation', Comment = 'FRA="Ventes - Confirmation"';
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
                                where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order', Comment = 'FRA="Commande vente"';
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
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
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
            column(CompanyTrib_Lbl; GTxtCompanyTrib)
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
            column(CompanyNoEORI; CompanyInfo."No. EORI")
            {
            }
            column(CompanyNoEORI_Lbl; CompanyInfo.FIELDCAPTION("No. EORI"))
            {
            }
            column(CompanyLegalStatement; GetLegalStatement())
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
            column(YourReference; Header."Your Reference")
            {
            }
            column(YourReference_Lbl; GTxtYourReferenceLbl)
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
            column(ShipmentDate; FORMAT("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FIELDCAPTION("Shipment Date"))
            {
            }
            column(RequestDeliveryDate; FORMAT("Requested Delivery Date", 0, 4))
            {
            }
            column(RequestDeliveryDate_Lbl; FIELDCAPTION(Header."Requested Delivery Date"))
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
            column(DocumentDate; GDocDate)
            {
            }
            column(BilltoName_Header; Header."Bill-to Name")
            {
            }
            column(BilltoName2_Header; Header."Bill-to Name 2")
            {
            }
            column(BilltoAddress_Header; Header."Bill-to Address")
            {
            }
            column(BilltoAddress2_Header; Header."Bill-to Address 2")
            {
            }
            column(BilltoCity_Header; Header."Bill-to City")
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
            column(QuoteNo; "Quote No.")
            {
            }
            column(QuoteNo_Lbl; FIELDCAPTION("Quote No."))
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
            column(SalesPersonText_Lbl; SalesPersonText)
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
            column(SellToFaxNo; GetSellToCustomerFaxNo())
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
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
            column(Invoice_Lbl; SalesConfirmationLbl)
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
            column(ExtDocNo_SalesHeader; "External Document No.")
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(ShipAgent_Lbl; Header.FIELDCAPTION("Shipping Agent Code"))
            {
            }
            column(ShipAgent; Header."Shipping Agent Code")
            {
            }
            column(Prepayement; Header."Prepayment %")
            {
            }
            column(PrepaymentLbl; GTxPrepaymentLbl)
            {
            }
            column(RequestedDeliveryDate_Lbl; GTxtRequestedDeliveryDate_Lbl)
            {
            }
            column(RequestedDeliveryDate; FORMAT(Header."Requested Delivery Date", 0, 4))
            {
            }
            column(TransportMethod; Header."Transport Method")
            {
            }
            column(NomTransporteur; GTxtTransporteur)
            {
            }
            column(Pieces_Lbl; GTtxPieces)
            {
            }
            column(Dime_Lbl; GTtxDime)
            {
            }
            column(Weight_Lbl; GTtxWeight)
            {
            }
            column(NetWeight; FFormatPoid(ROUND(GDecNetWeight, 1, '<')))
            {
            }
            column(GrossWeight; ROUND(GDecGrossWeight, 1, '<'))
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
            column(DocumentTitle_Lbl; GtxtDocumentTitle_Lbl)
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
                    AutoFormatExpression = "Currency Code";
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
                column(ItemNo_Line; "GTxtNo.")
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
                column(CrossReferenceNo; "Item Reference No.")
                {
                }
                column(CrossReferenceNo_Lbl; FIELDCAPTION("Item Reference No."))
                {
                }
                column(NomenclatureArticle; GTxtNomenclatureArticle)
                {
                }
                column(CodeRegionOrigine; GTxtCodeRegionOrigine)
                {
                }
                column(NomenclatureArticle_Lbl; GTtxTaricCode)
                {
                }
                column(DiscountLbl; DiscountLbl)
                {
                }
                dataitem(AssemblyLine; "Assembly Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.");
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
                    begin
                        if not DisplayAssemblyInformation then
                            CurrReport.BREAK();
                        if not AsmInfoExistsForLine then
                            CurrReport.BREAK();
                        SETRANGE("Document Type", AsmHeader."Document Type");
                        SETRANGE("Document No.", AsmHeader."No.");
                    end;
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

                    if DisplayAssemblyInformation then
                        AsmInfoExistsForLine := AsmToOrderExists(AsmHeader);

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    //TotalAmount += Amount; MIG AMG
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    //TotalAmountInclVAT += "Amount Including VAT";  MIG AMG
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

                    if FirstLineHasBeenOutput then
                        CLEAR(CompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;


                    // DEB DELPHI XAVC 11/26/2018
                    "GTxtNo." := Line."No.";
                    GTxtNomenclatureArticle := '';
                    GTxtCodeRegionOrigine := '';
                    if Line.Type = Line.Type::Item then begin
                        if Line."Item Reference No." <> '' then
                            "GTxtNo." := Line."Item Reference No.";
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
                    //FIN DELPHI XAVC
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
                column(VATClause1; GTxtVATClause1)
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
                    //FIN DELPHI XAV
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(VATBaseLCY);
                    CLEAR(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;

                    VATClauseLine.DELETEALL();
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                UseTemporary = true;
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

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.SKIP();
                    if not VATClause.GET("VAT Clause Code") then
                        CurrReport.SKIP();
                    VATClause.TranslateDescription(Header."Language Code");
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
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                //DEB DELPHI XAV
                Header.CALCFIELDS("Net Weight", "Gross Weight");
                //FIN DELPHI XAV
                //DEB DELPHI AUB
                Header.CALCFIELDS(Amount, "Amount Including VAT");
                TotalAmount := Header.Amount;
                TotalAmountInclVAT := Header."Amount Including VAT";
                if Header."Your Reference" = ''
                  then
                    GTxtYourReferenceLbl := ''
                else
                    GTxtYourReferenceLbl := GTxtReference;
                //FIN DELPHI AUB
                //DELPHI AUB 21.10.2019
                if GBooProforma then begin
                    GtxtDocumentTitle_Lbl := GTxtProforma;
                    GTxtDocumentNo := Header."No.";
                    GTxtDocumentNo := CONVERTSTR(GTxtDocumentNo, 'CV', 'PF');
                end else begin
                    GtxtDocumentTitle_Lbl := GTxtOrder;
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

                if not IsReportInPreviewMode() then
                    CODEUNIT.RUN(CODEUNIT::"Sales-Printed", Header);


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
                    not CurrReport.USEREQUESTPAGE and SalesSetup."Archive Orders")
                then
                    ArchiveManagement.StoreSalesDocument(Header, LogInteraction);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                //TotalAmount := 0; MIG AMG
                TotalAmountVAT := 0;
                //TotalAmountInclVAT := 0; MIG AMG
                TotalPaymentDiscOnVAT := 0;

                // DEB DELPHI XAV Livraison
                if ShipmentMethod.GET(Header."Shipment Method Code") then begin
                    if GrecTraductionTransport.GET(ShipmentMethod.Code, Header."Language Code") then
                        GTxtTraductionTransport := GrecTraductionTransport.Description
                    else
                        GTxtTraductionTransport := ShipmentMethod.Description;
                    if ShipmentMethod.Incoterms then
                        GTxtCondLivraisonEtendues := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison" + ' - Incoterms © 2010'
                    else
                        GTxtCondLivraisonEtendues := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison";
                end
                else
                    GTxtCondLivraisonEtendues := Header."Shipment Method Code" + ' ' + Header."Compl. cond. livraison";

                if GrecTransporteur.GET(Header."Shipping Agent Code") then
                    GTxtTransporteur := GrecTransporteur.Name
                else
                    GTxtTransporteur := Header."Shipping Agent Code";
                if GrecTransporteur.GET(Header."Shipping Agent Code") then
                    GTxtTransporteur := GrecTransporteur.Name
                else
                    GTxtTransporteur := Header."Shipping Agent Code";

                GTxtBankName := CompanyInfo."Bank Name";
                GTxtBankBranchNo := CompanyInfo."Bank Branch No.";
                GTxtBankAcountNo := CompanyInfo."Bank Account No.";
                GTxtBankIBAN := CompanyInfo.IBAN;
                GTxtBankSwift := CompanyInfo."SWIFT Code";

                GRecSalesLine.RESET();
                GRecSalesLine.SETRANGE("Document No.", Header."No.");
                GRecSalesLine.SETRANGE("Document Type", Header."Document Type");
                GRecSalesLine.SETRANGE(Type, GRecSalesLine.Type::Item);
                if GRecSalesLine.FINDFIRST() then
                    repeat
                        GDecGrossWeight += ROUND(GRecSalesLine.Quantity * GRecSalesLine."Gross Weight", 0.001);
                        GDecNetWeight += ROUND(GRecSalesLine.Quantity * GRecSalesLine."Net Weight", 0.001);
                    until GRecSalesLine.NEXT() = 0;

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;

                GTxtNumTVAClient := '';
                GTxtNumTVAClient_Lbl := '';
                // DELPHI AUB 11.06.2019
                GTxtCompanyVAT_ICE := 'No. TVA';
                GTxtOrigineCE := '';

                if GRecCust2.GET("Sell-to Customer No.") then begin
                    // DELPHI AUB 11.06.2019
                    if GRecCust2.ICE then begin
                        GTxtCompanyVAT_ICE := 'No. ICE';
                        GTxtOrigineCE := 'L''exportateur des produits couverts par le présent document déclare que sauf indication claire du contraire ces produits ont l''origine préférentielle CE.';
                    end;
                    // END DELPHI AUB 11.06.2019
                    if GRecCust2."VAT Registration No." <> '' then begin
                        GTxtNumTVAClient := GRecCust2."VAT Registration No.";
                        GTxtNumTVAClient_Lbl := VATIdentifierLbl + ' :';
                    end else
                        GTxtCompanyVAT_ICE := '';
                end;

                //FIN DELPHI XAV

                //--> BC6 NC 13052024
                if LanguageMgt.GetUserLanguageCode() = 'ENU' then
                    GDocDate := FORMAT(Header."Document Date", 0, '<Month Text> <Closing><Day>, <Year4>')
                else
                    GDocDate := FORMAT(Header."Document Date", 0, 4);

                FormatDocumentFields(Header);
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
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(AffichageOrigineF; GBooAffichageOrigine)
                    {
                        Caption = 'Affichage Origine';
                        ApplicationArea = All;
                    }
                    field(GBooProformaF; GBooProforma)
                    {
                        Caption = 'Facture Pro-forma';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := SalesSetup."Archive Orders";
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

        //DEB DELPHI XAV
        GTxtVATClause1 := '';
        //FIN DELPHI XAV
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FINDSET() then
                repeat
                    Header.CALCFIELDS("No. of Archived Versions");
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          3, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", DATABASE::Contact, Header."Bill-to Contact No."
                          , Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          3, Header."No.", Header."Doc. No. Occurrence",
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
        SalesConfirmationLbl: Label 'Order Confirmation', Comment = 'FRA="Confirmation de commande"';
        CompanyInfoBankNameLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CopyLbl: Label 'Copy', Comment = 'FRA="Copier"';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvDiscountAmtLbl: Label 'Invoice Discount', Comment = 'FRA="Remise facture"';
        InvNoLbl: Label 'Order No.', Comment = 'FRA="N° commande"';
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
        WorkDescriptionInstream: InStream;
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        LanguageMgt: Codeunit Language;
        VATClause: Record "VAT Clause";
        AsmHeader: Record "Assembly Header";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        GRecItem: Record Item;
        GrecTransporteur: Record "Shipping Agent";
        GrecTraductionTransport: Record "Shipment Method Translation";
        GRecSalesLine: Record "Sales Line";
        GRecCust2: Record Customer;
        CustAddr: array[8] of Text[100];
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
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
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
        GreetingLbl: Label 'Hello', Comment = 'FRA="Bonjour"';
        ClosingLbl: Label 'Sincerely', Comment = 'FRA="Cordialement"';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = 'FRA="Si nous recevons le paiement avant le %1, vous pouvez bénéficier d''un escompte de 2%."';
        BodyLbl: Label 'Thank you for your business. Your order confirmation is attached to this message.', Comment = 'FRA="Merci de votre collaboration. Votre confirmation de commande est jointe à ce message."';
        PmtDiscText: Text;
        ShowWorkDescription: Boolean;
        WorkDescriptionLine: Text;
        GTxtNomenclatureArticle: Text[30];
        GTxtCondLivraisonEtendues: Text[250];
        GTxtTransporteur: Text[80];
        GTxtBankName: Text[100];
        GTxtBankBranchNo: Text[20];
        GTxtBankAcountNo: Text[30];
        GTxtBankIBAN: Text[50];
        GTxtBankSwift: Text[20];
        GTxtTraductionTransport: Text[100];
        GTxtVATClause1: Text[1024];
        GDecNetWeight: Decimal;
        GDecGrossWeight: Decimal;
        GRecCountry: Record "Country/Region";
        GTxtCompanyInfoPays: Text[50];
        GTxtNumTVAClient: Text[60];
        GTxtNumTVAClient_Lbl: Text[60];
        "GTxtNo.": Text[70];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtCompanyVAT_ICE: Text[80];
        GTxtOrigineCE: Text[250];
        GTxtCompanyBankBranch: Label 'Bk Code', Comment = 'FRA="Code Bq"';
        GTxtCompanyPhoneNo: Label 'Phone', Comment = 'FRA="Tél."';
        GTxtCompanyFaxNo: Label 'Fax.', Comment = 'FRA="Fax."';
        GTxtCompanyHomepage: Label 'Website', Comment = 'FRA="Site Web"';
        GTxtCompanyemail: Label 'E-Mail', Comment = 'FRA="E-Mail"';
        GTxtCompanyVAT: Label 'VAT Id. Num.', Comment = 'FRA="No. TVA"';
        GTxtCompanyBankNr: Label 'Bk Num.', Comment = 'FRA="No. Cpte"';
        GTxtCompanyTrib: Label 'Trial court', Comment = 'FRA="RCS"';
        GTxtCompanyBankSWIFT: Label 'SWIFT', Comment = 'FRA="SWIFT"';
        GTxtCompanySalespers: Label 'Agent', Comment = 'FRA="Commercial"';
        GTxtCustomerNum: Label 'Customer num.', Comment = 'FRA="No. Client"';
        GTxtQuantity_Line_Lbl: Label 'Qty', Comment = 'FRA="Qté"';
        GTxtUnitOfMeasure_Lbl: Label 'Unit', Comment = 'FRA="Unité"';
        GTxtUnitPrice_Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unit."';
        GTxPrepaymentLbl: Label 'Deposit with the order', Comment = 'FRA="Acompte à la commande"';
        GTxtItemNo_Line_Lbl: Label 'Item No.', Comment = 'FRA="N° d''article"';
        GTxtRequestedDeliveryDate_Lbl: Label 'Expected delivery date', Comment = 'FRA="Date de livraison prévue"';
        GTtxPieces: Label 'Pieces', Comment = 'FRA="Pièces"';
        GTtxDime: Label 'Dimensions', Comment = 'FRA="Dimensions"';
        GTtxWeight: Label 'Weight (Gross / Net) in Kg', Comment = 'FRA="Poids (Brut / Net) en Kg"';
        GTtxTaricCode: Label 'Taric Code', Comment = 'FRA="Code Taric"';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.', Comment = 'FRA="Les retards de paiement sont soumis à un intérêt mensuel de 1,5%. Pas d’escompte pour règlement anticipé."';
        GTxtYourReferenceLbl: Text[80];
        GTxtCodeRegionOrigine: Text[80];
        GBooAffichageOrigine: Boolean;
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
        GBooProforma: Boolean;
        GtxtDocumentTitle_Lbl: Text[80];
        GTxtDocumentNo: Text[50];
        GTxtReference: Label 'Your Reference', Comment = 'FRA="Votre Référence :"';
        GTxtProforma: Label 'Proforma Invoice No ', Comment = 'FRA="Facture Pro-forma N° "';
        GTxtOrder: Label 'Order Confirmation ', Comment = 'FRA="Confirmation de commande "';
        DiscountLbl: Label 'Discount', Comment = 'FRA="Remise"';
        GDocDate: Text;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
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

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
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
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
    end;

    local procedure FFormatPoid(LDecParam: Decimal) Return: Text[10]
    begin
        Return := FORMAT(LDecParam, 10, '<Precision,1><Standard Format,0>');
    end;
}

