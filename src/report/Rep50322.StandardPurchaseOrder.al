namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Purchases.Document;
using System.Utilities;
using Microsoft.Purchases.Vendor;
using Microsoft.CRM.Interaction;
using Microsoft.Foundation.Company;
using Microsoft.CRM.Team;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Finance.Currency;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.Address;
using Microsoft.Utilities;
using Microsoft.Purchases.Posting;
using Microsoft.CRM.Segment;
using System.EMail;
report 50322 "Standard Purchase - Order"
{
    RDLCLayout = './src/report/rdl/StandardPurchaseOrder.rdl';
    WordLayout = './src/report/rdl/StandardPurchaseOrder.docx';
    Caption = 'Purchase - Order', Comment = 'FRA="Commande Achat"';
    DefaultLayout = Word;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";
    UsageCategory = None;
    ApplicationArea = All;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Standard Purchase - Order', Comment = 'FRA="Codes achat standard - commande"';
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
            column(CompanyHomePage_Lbl; GTxtCompanyHomepage)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail_Lbl; GTxtCompanyemail)
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
            column(CompanyGiroNo_Lbl; GTxtCompanyBankNr)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameCaptionLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; GTxtCompanyBankBranch)
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoCaptionLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FIELDCAPTION(IBAN))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
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
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(DocumentTitle_Lbl; DocumentTitleLbl)
            {
            }
            column(Amount_Lbl; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmt_Lbl; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(Subtotal_Lbl; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVAT_Lbl; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmt_Lbl; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpec_Lbl; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmt_Lbl; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmt_Lbl; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCY_Lbl; VALVATBaseLCYCaptionLbl)
            {
            }
            column(Total_Lbl; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDesc_Lbl; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDesc_Lbl; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDesc_Lbl; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePage_Lbl; HomePageCaptionLbl)
            {
            }
            column(EmailID_Lbl; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDisc_Lbl; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(CurrRepPageNo; STRSUBSTNO(PageLbl, ''))
            {
            }
            column(DocumentDate; FORMAT("Document Date", 0, 4))
            {
            }
            column(DueDate; FORMAT("Due Date", 0, 4))
            {
            }
            column(ExptRecptDt_PurchaseHeader; FORMAT("Expected Receipt Date", 0, 4))
            {
            }
            column(OrderDate_PurchaseHeader; FORMAT("Order Date", 0, 4))
            {
            }
            column(VATNoText; VATNoText)
            {
            }
            column(VATRegNo_PurchHeader; "VAT Registration No.")
            {
            }
            column(PurchaserText; PurchaserText)
            {
            }
            column(SalesPurchPersonName; SalespersonPurchaser.Name)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(YourRef_PurchHeader; "Your Reference")
            {
            }
            column(BuyFrmVendNo_PurchHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {
            }
            column(BuyFromAddr6; BuyFromAddr[6])
            {
            }
            column(BuyFromAddr7; BuyFromAddr[7])
            {
            }
            column(BuyFromAddr8; BuyFromAddr[8])
            {
            }
            column(PricesIncludingVAT_Lbl; PricesIncludingVATCaptionLbl)
            {
            }
            column(PricesInclVAT_PurchHeader; "Prices Including VAT")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(VATBaseDisc_PurchHeader; "VAT Base Discount %")
            {
            }
            column(PricesInclVATtxt; PricesInclVATtxtLbl)
            {
            }
            column(PaymentTermsDesc; PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
            {
            }
            column(DimText; DimText)
            {
            }
            column(OrderNo_Lbl; OrderNoCaptionLbl)
            {
            }
            column(Page_Lbl; PageCaptionLbl)
            {
            }
            column(DocumentDate_Lbl; DocumentDateCaptionLbl)
            {
            }
            column(BuyFrmVendNo_PurchHeader_Lbl; FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(PricesInclVAT_PurchHeader_Lbl; FIELDCAPTION("Prices Including VAT"))
            {
            }
            column(Receiveby_Lbl; ReceivebyCaptionLbl)
            {
            }
            column(Buyer_Lbl; GTxtCompanySalespers)
            {
            }
            column(PayToVendNo_PurchHeader; "Pay-to Vendor No.")
            {
            }
            column(VendAddr8; VendAddr[8])
            {
            }
            column(VendAddr7; VendAddr[7])
            {
            }
            column(VendAddr6; VendAddr[6])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(PaymentDetails_Lbl; PaymentDetailsCaptionLbl)
            {
            }
            column(VendNo_Lbl; VendNoCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader; "Sell-to Customer No.")
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(ShiptoAddress_Lbl; ShiptoAddressCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader_Lbl; FIELDCAPTION("Sell-to Customer No."))
            {
            }
            column(ItemNumber_Lbl; ItemNumberCaptionLbl)
            {
            }
            column(ItemDescription_Lbl; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemQuantity_Lbl; ItemQuantityCaptionLbl)
            {
            }
            column(ItemUnit_Lbl; ItemUnitCaptionLbl)
            {
            }
            column(ItemUnitPrice_Lbl; ItemUnitPriceCaptionLbl)
            {
            }
            column(ItemLineAmount_Lbl; ItemLineAmountCaptionLbl)
            {
            }
            column(ToCaption_Lbl; ToCaptionLbl)
            {
            }
            column(VendorIDCaption_Lbl; VendorIDCaptionLbl)
            {
            }
            column(ConfirmToCaption_Lbl; ConfirmToCaptionLbl)
            {
            }
            column(PurchOrderCaption_Lbl; PurchOrderCaptionLbl)
            {
            }
            column(PurchOrderNumCaption_Lbl; PurchOrderNumCaptionLbl)
            {
            }
            column(PurchOrderDateCaption_Lbl; PurchOrderDateCaptionLbl)
            {
            }
            column(TaxIdentTypeCaption_Lbl; TaxIdentTypeCaptionLbl)
            {
            }
            column(OrderDate_Lbl; OrderDateLbl)
            {
            }
            column(VendorInvoiceNo_Lbl; VendorInvoiceNoLbl)
            {
            }
            column(VendorInvoiceNo; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_Lbl; VendorOrderNoLbl)
            {
            }
            column(VendorOrderNo; "Vendor Order No.")
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
            {
            }
            column(CompanyGesch_Lbl; GTxtCompanyGesch)
            {
            }
            column(CompanySitz_Lbl; GTxtCompanySitz)
            {
            }
            column(CompanyTrib_Lbl; GTxtCompanyTrib)
            {
            }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(BillAdresse_Lbl; GTxtBillAdresse_Lbl)
            {
            }
            column(NumTVAClient; GTxtNumTVAClient)
            {
            }
            column(NumDevis; GTxtNumDevis)
            {
            }
            column(NumDevis_Lbl; GTxTDevisLbl)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                column(LineNo_PurchLine; "Line No.")
                {
                }
                column(AllowInvDisctxt; AllowInvDisctxt)
                {
                }
                column(Type_PurchLine; FORMAT(Type, 0, 2))
                {
                }
                column(No_PurchLine; "No.")
                {
                }
                column(CrossReferenceNo_PurchLine; "Purchase Line"."Item Reference No.")
                {
                }
                column(ItemNo_PurchLine; "GTxtNo.")
                {
                }
                column(Desc_PurchLine; Description)
                {
                }
                column(Qty_PurchLine; FormattedQuanitity)
                {
                }
                column(UOM_PurchLine; "Unit of Measure")
                {
                }
                column(DirUnitCost_PurchLine; FormattedDirectUnitCost)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(LineDisc_PurchLine; "Line Discount %")
                {
                }
                column(LineAmt_PurchLine; "Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(AllowInvDisc_PurchLine; "Allow Invoice Disc.")
                {
                }
                column(VATIdentifier_PurchLine; "VAT Identifier")
                {
                }
                column(InvDiscAmt_PurchLine; -"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVAT; "Line Amount" - "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(DirectUniCost_Lbl; GTxtUnitPrice_Lbl)
                {
                }
                column(PurchLineLineDisc_Lbl; PurchLineLineDiscCaptionLbl)
                {
                }
                column(VATDiscountAmount_Lbl; VATDiscountAmountCaptionLbl)
                {
                }
                column(No_PurchLine_Lbl; GTxtItemNo_Line_Lbl)
                {
                }
                column(Desc_PurchLine_Lbl; FIELDCAPTION(Description))
                {
                }
                column(Qty_PurchLine_Lbl; GTxtQuantity_Line_Lbl)
                {
                }
                column(UOM_PurchLine_Lbl; GTxtUnitOfMeasure_Lbl)
                {
                }
                column(VATIdentifier_PurchLine_Lbl; FIELDCAPTION("VAT Identifier"))
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                }
                column(TotalPriceCaption_Lbl; GTxtTotalPrice_Lbl)
                {
                }
                column(InvDiscCaption_Lbl; InvDiscCaptionLbl)
                {
                }
                column(UnitPrice_PurchLine; "Unit Price (LCY)")
                {
                }
                column(UnitPrice_PurchLine_Lbl; UnitPriceLbl)
                {
                }
                column(JobNo_PurchLine; "Job No.")
                {
                }
                column(JobNo_PurchLine_Lbl; JobNoLbl)
                {
                }
                column(JobTaskNo_PurchLine; "Job Task No.")
                {
                }
                column(JobTaskNo_PurchLine_Lbl; JobTaskNoLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AllowInvDisctxt := FORMAT("Allow Invoice Disc.");
                    TotalSubTotal += "Line Amount";
                    TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    //IF "Cross-Reference No." <> '' THEN STD
                    //  "No." := "Cross-Reference No.";

                    // DEB DELPHI MHR 18/01/2019          MIG
                    "GTxtNo." := "Purchase Line"."No.";
                    if "Purchase Line".Type = "Purchase Line".Type::Item then
                        if "Purchase Line"."Item Reference No." <> '' then
                            "GTxtNo." := "Purchase Line"."Item Reference No.";
                    //FIN DELPHI XAVC

                    FormatDocument.SetPurchaseLine("Purchase Line", FormattedQuanitity, FormattedDirectUnitCost);
                end;
            }
            dataitem(Totals; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));
                column(VATAmountText; TempVATAmountLine.VATAmountText())
                {
                }
                column(TotalVATAmount; VATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATDiscountAmount; -VATDiscountAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseAmount; VATBaseAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
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
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    TempPrepaymentInvLineBuffer.DELETEALL();
                    PurchasePostPrepayments.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    if not TempPrepmtPurchLine.ISEMPTY then begin
                        PurchasePostPrepayments.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchasePostPrepayments.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrePmtVATAmountLineDeduct);
                    PurchasePostPrepayments.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    PurchasePostPrepayments.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepaymentInvLineBuffer);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    //DEB DELPHI AUB 15.10.2019
                    GTxtDisplayTotalAmountVAT := '';
                    GTxtDisplayTotalAmountInclVAT := '';
                    GTxtTotalTVA_Lbl := '';
                    GTxtTotalTTC_Lbl := '';
                    if VATAmount > 0 then begin
                        GTxtDisplayTotalAmountVAT := FORMAT(VATAmount, 0, '<Integer Thousand><Decimals,3>');
                        GTxtDisplayTotalAmountInclVAT := FORMAT(TotalAmountInclVAT, 0, '<Integer Thousand><Decimals,3>');
                        GTxtTotalTVA_Lbl := 'Total EUR TVA';
                        GTxtTotalTTC_Lbl := 'Total EUR TTC';
                    end;
                    //END DELPHI AUB 15.10.2019
                end;
            }
            dataitem(VATCounter; Integer)
            {
                DataItemTableView = sorting(Number);
                column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TempVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    if VATAmount = 0 then
                        CurrReport.BREAK();
                    SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                end;
            }
            dataitem(VATCounterLCY; Integer)
            {
                DataItemTableView = sorting(Number);
                column(VALExchRate; VALExchRate)
                {
                }
                column(VALSpecLCYHeader; VALSpecLCYHeader)
                {
                }
                column(VALVATAmountLCY; VALVATAmountLCY)
                {
                    AutoFormatType = 1;
                }
                column(VALVATBaseLCY; VALVATBaseLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    TempVATAmountLine.GetLine(Number);
                    VALVATBaseLCY :=
                      TempVATAmountLine.GetBaseLCY(
                        "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                    VALVATAmountLCY :=
                      TempVATAmountLine.GetAmountLCY(
                        "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                end;

                trigger OnPreDataItem()
                begin
                    if (not GLSetup."Print VAT specification in LCY") or
                       ("Purchase Header"."Currency Code" = '') or
                       (TempVATAmountLine.GetTotalVATAmount() = 0)
                    then
                        CurrReport.BREAK();

                    SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                    if GLSetup."LCY Code" = '' then
                        VALSpecLCYHeader := VATAmountSpecificationLbl + LocalCurrentyLbl
                    else
                        VALSpecLCYHeader := VATAmountSpecificationLbl + FORMAT(GLSetup."LCY Code");

                    CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                    VALExchRate := STRSUBSTNO(ExchangeRateLbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                end;
            }
            dataitem(PrepmtLoop; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = filter(1 ..));
                column(PrepmtLineAmount; PrepmtLineAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtInvBufGLAccNo; TempPrepaymentInvLineBuffer."G/L Account No.")
                {
                }
                column(PrepmtInvBufDesc; TempPrepaymentInvLineBuffer.Description)
                {
                }
                column(TotalInclVATText2; TotalInclVATText)
                {
                }
                column(TotalExclVATText2; TotalExclVATText)
                {
                }
                column(PrepmtInvBufAmt; TempPrepaymentInvLineBuffer.Amount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmountText; TempPrepmtVATAmountLine.VATAmountText())
                {
                }
                column(PrepmtVATAmount; PrepmtVATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                {
                }
                column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                {
                }
                column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        if not TempPrepaymentInvLineBuffer.FIND('-') then
                            CurrReport.BREAK();
                    end else
                        if TempPrepaymentInvLineBuffer.NEXT() = 0 then
                            CurrReport.BREAK();

                    if "Purchase Header"."Prices Including VAT" then
                        PrepmtLineAmount := TempPrepaymentInvLineBuffer."Amount Incl. VAT"
                    else
                        PrepmtLineAmount := TempPrepaymentInvLineBuffer.Amount;
                end;
            }
            dataitem(PrepmtVATCounter; Integer)
            {
                DataItemTableView = sorting(Number);
                column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVAT; TempPrepmtVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(PrepmtVATAmtLineVATId; TempPrepmtVATAmountLine."VAT Identifier")
                {
                }
                column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TempPrepmtVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, TempPrepmtVATAmountLine.COUNT);
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
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                if not IsReportInPreviewMode() then begin
                    codeunit.RUN(codeunit::"Purch.Header-Printed", "Purchase Header");
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
                end;

                //DEB DELPHI XAV 20/06/18
                if GRecFourniseur2.GET("Purchase Header"."Buy-from Vendor No.") then
                    GTxtNumTVAClient := GRecFourniseur2."VAT Registration No.";
                //FIN DELPHI XAV
                //DEB DELPHI XAV 09/04/2018 N° Devis
                if "Purchase Header"."Quote No." <> '' then begin
                    GTxTDevisLbl := TextNoDevis;
                    GTxtNumDevis := "Purchase Header"."Quote No.";
                end
                else begin
                    GTxTDevisLbl := '';
                    GTxtNumDevis := '';
                end;
                //FIN DELPHI XAV
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
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                    }
                    field(LogInteractionF; LogInteraction)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := PurchSetup."Archive Orders";
        end;

        trigger OnOpenPage()
        begin
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        PurchSetup.GET();
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Purchase Header".FINDSET() then
                repeat
                    SegManagement.LogDocument(
                      13, "Purchase Header"."No.", 0, 0, DATABASE::Vendor, "Purchase Header"."Buy-from Vendor No.",
                      "Purchase Header"."Purchaser Code", '', "Purchase Header"."Posting Description", '');
                until "Purchase Header".NEXT() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();
    end;

    var
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        TempPrepaymentInvLineBuffer: Record "Prepayment Inv. Line Buffer" temporary;
        TempPurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        GRecFourniseur2: Record Vendor;
        ArchiveManagement: codeunit ArchiveManagement;
        FormatAddr: codeunit "Format Address";
        FormatDocument: codeunit "Format Document";
        LanguageMgt: Codeunit Language;
        PurchPost: codeunit "Purch.-Post";
        PurchasePostPrepayments: codeunit "Purchase-Post Prepayments";
        SegManagement: codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        CompanyLogoPosition: Integer;
        OutputNo: Integer;
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        BodyLbl: Label 'The purchase order is attached to this message.', Comment = 'FRA="La commande achat est jointe à ce message."';
        ClosingLbl: Label 'Sincerely', Comment = 'FRA="Cordialement"';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        ConfirmToCaptionLbl: Label 'Confirm To', Comment = 'FRA="Confirmer à"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        DocumentTitleLbl: Label 'Purchase Order', Comment = 'FRA="Commande achat"';
        EmailIDCaptionLbl: Label 'Email', Comment = 'FRA="Adresse e-mail"';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change: %1/%2"';
        GreetingLbl: Label 'Hello', Comment = 'FRA="Bonjour"';
        GTxtBillAdresse_Lbl: Label 'Billing address', Comment = 'FRA="Adresse de facturation"';
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
        GTxtCompanyVAT: Label 'VAT Id. Num.', Comment = 'FRA="No. TVA"';
        GTxtItemNo_Line_Lbl: Label 'Item No.', Comment = 'FRA="N° d''article"';
        GTxtQuantity_Line_Lbl: Label 'Qty', Comment = 'FRA="Qté"';
        GTxtTotalPrice_Lbl: Label 'Total', Comment = 'FRA="Montant"';
        GTxtUnitOfMeasure_Lbl: Label 'Unit', Comment = 'FRA="Unité"';
        GTxtUnitPrice_Lbl: Label 'Unit Price', Comment = 'FRA="Prix Unit."';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        InvDiscCaptionLbl: Label 'Invoice Discount:', Comment = 'FRA="Remise facture:"';
        ItemDescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        ItemLineAmountCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        ItemNumberCaptionLbl: Label 'Item No.', Comment = 'FRA="N° article"';
        ItemQuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ItemUnitCaptionLbl: Label 'Unit', Comment = 'FRA="Unité"';
        ItemUnitPriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        JobNoLbl: Label 'Job No.', Comment = 'FRA="N° projet"';
        JobTaskNoLbl: Label 'Job Task No.', Comment = 'FRA="N° tâche projet"';
        LocalCurrentyLbl: Label 'Local Currency', Comment = 'FRA="Devise société"';
        OrderDateLbl: Label 'Order Date', Comment = 'FRA="Date commande"';
        OrderNoCaptionLbl: Label 'Order No.', Comment = 'FRA="N° commande"';
        PageCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        PageLbl: Label 'Page %1', Comment = 'FRA="Page %1"';
        PaymentDetailsCaptionLbl: Label 'Payment Details', Comment = 'FRA="Détail paiement"';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification', Comment = 'FRA="Spécification acompte"';
        PrepmtInvBuDescCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.', Comment = 'FRA="N° compte général"';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms', Comment = 'FRA="Conditions paiement acompte"';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification', Comment = 'FRA="Spécification montant TVA acompte"';
        PricesIncludingVATCaptionLbl: Label 'Prices Including VAT', Comment = 'FRA="Prix TTC"';
        PricesInclVATtxtLbl: Label 'Prices Including VAT', Comment = 'FRA="Prix TTC"';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        PurchLineLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER', Comment = 'FRA="COMMANDE ACHAT"';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:', Comment = 'FRA="Date Commande achat:"';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:', Comment = 'FRA="N° commande achat:"';
        ReceivebyCaptionLbl: Label 'Receive By', Comment = 'FRA="Réceptionner par"';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type', Comment = 'FRA="Type Ident. Taxe"';
        TextNoDevis: Label 'Quote N°', Comment = 'FRA="N° Devis"';
        ToCaptionLbl: Label 'To:', Comment = 'FRA="À :"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        UnitPriceLbl: Label 'Unit Price (LCY)', Comment = 'FRA="Prix unitaire DS"';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmountSpecificationLbl: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtLineVATCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VendNoCaptionLbl: Label 'Vendor No.', Comment = 'FRA="N° fournisseur"';
        VendorIDCaptionLbl: Label 'Vendor ID', Comment = 'FRA="ID fournisseur"';
        VendorInvoiceNoLbl: Label 'Vendor Invoice No.', Comment = 'FRA="N° facture fournisseur"';
        VendorOrderNoLbl: Label 'Vendor Order No.', Comment = 'FRA="N° commande fournisseur"';
        FormattedDirectUnitCost: Text;
        FormattedQuanitity: Text;
        GTxtNumDevis: Text[20];
        AllowInvDisctxt: Text[30];
        GTxTDevisLbl: Text[35];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtDisplayTotalAmountVAT: Text[50];
        "GTxtNo.": Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
        PurchaserText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        GTxtNumTVAClient: Text[60];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        BuyFromAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        DimText: Text[120];

    procedure InitializeRequest(LogInteractionParam: Boolean)
    begin
        LogInteraction := LogInteractionParam;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalespersonPurchaser, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeader."Prepmt. Payment Terms Code", PurchaseHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FIELDCAPTION("VAT Registration No."));
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
    end;
}

