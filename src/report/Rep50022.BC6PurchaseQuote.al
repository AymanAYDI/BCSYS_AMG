namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
using System.Utilities;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.CRM.Team;
using Microsoft.Foundation.Shipping;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.Setup;
using Microsoft.Inventory.Location;
using Microsoft.Utilities;
using Microsoft.Foundation.Address;
using System.Globalization;
using Microsoft.Purchases.Posting;
using Microsoft.CRM.Segment;
using System.EMail;
using Microsoft.Purchases.Vendor;
using Microsoft.CRM.Interaction;
report 50022 "BC6 Purchase - Quote"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/BC6PurchaseQuote.rdl';
    Caption = 'Purchase - Quote', Comment = 'FRA="Achats : Demande de prix"';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    ApplicationArea = All;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Quote', Comment = 'FRA="Demande de prix"';
            column(DocType_PurchHead; "Document Type")
            {
            }
            column(PurchHeadNo; "No.")
            {
            }
            column(PurchaseQuoteCopyText; STRSUBSTNO(Text002, "No."))
            {
            }
            column(CompanyInfoPhoneNoCap; CompanyInfoPhoneNoCapLbl)
            {
            }
            column(CompanyInfoVATRegNoCap; CompanyInfoVATRegNoCapLbl)
            {
            }
            column(CompanyInfoGiroNoCap; CompanyInfoGiroNoCapLbl)
            {
            }
            column(CompanyInfoBankNameCap; CompanyInfoBankNameCapLbl)
            {
            }
            column(CompInfoBankAccNoCap; CompInfoBankAccNoCapLbl)
            {
            }
            column(DocumentDateCap; DocumentDateCapLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(ShipmentMethodDescCap; ShipmentMethodDescCapLbl)
            {
            }
            column(PurchLineVendItemNoCap; PurchLineVendItemNoCapLbl)
            {
            }
            column(PurchaseLineDescCap; PurchaseLineDescCapLbl)
            {
            }
            column(PurchaseLineQuantityCap; PurchaseLineQuantityCapLbl)
            {
            }
            column(PurchaseLineUOMCaption; PurchaseLineUOMCaptionLbl)
            {
            }
            column(PurchaseLineNoCaption; PurchaseLineNoCaptionLbl)
            {
            }
            column(PurchaserTextCaption; PurchaserTextCaptionLbl)
            {
            }
            column(ReferenceTextCaption; ReferenceTextCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(VatRegistrationNoCaption; VatRegistrationNoCaptionLbl)
            {
            }
            column(PurchaserCode; "Purchaser Code")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoPicture; CompanyInfo."Info Picture")
            {
            }
            column(PlaceLbl; PlaceLbl)
            {
            }
            column(PaymentTermsDesc; RecGPaymentTerms.Description)
            {
            }
            column(PaymentTermsLbl; PaymentTermsLbl)
            {
            }
            column(Footer1; Footer1)
            {
            }
            column(FooterBankLbl; FooterBankLbl)
            {
            }
            column(BankName; CompanyInfo."Bank Name")
            {
            }
            column(BankIBAN; CompanyInfo.IBAN)
            {
            }
            column(FooterSiege; FooterSiege)
            {
            }
            column(BankAddress; CompanyInfo.Address)
            {
            }
            column(BankPostCode; CompanyInfo."Post Code")
            {
            }
            column(BankCity; CompanyInfo.City)
            {
            }
            column(FooterRcs; FooterRcs)
            {
            }
            column(FooterSiretLbl; FooterSiretLbl)
            {
            }
            column(BankSIRET; CompanyInfo."Registration No.")
            {
            }
            column(FooterVatLbl; FooterVatLbl)
            {
            }
            column(FooterVAT; CompanyInfo."VAT Registration No.")
            {
            }
            column(DocDate_PurchHdr; GDocDate)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                        IncludeCaption = false;
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(CompanyInfoVatRegNo; CompanyInfo."VAT Registration No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                        IncludeCaption = false;
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(PaytoVendNo_PurchHdr; "Purchase Header"."Pay-to Vendor No.")
                    {
                    }
                    column(VatNoText; VATNoText)
                    {
                    }
                    column(VatTRegNo_PurchHdr; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(ExpctRecpDt_PurchHdr; FORMAT("Purchase Header"."Expected Receipt Date"))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesPurchPersonEmail; SalesPurchPerson."E-Mail")
                    {
                    }
                    column(No1_PurchaseHdr; "Purchase Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHdr; "Purchase Header"."Your Reference")
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(ShipMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(OutpuNo; OutputNo)
                    {
                    }
                    column(BuyfromVendNo_PurchHdr; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(ExpectedDateCaption; ExpectedDateCaptionLbl)
                    {
                    }
                    column(QuoteNoCaption; QuoteNoCaptionLbl)
                    {
                    }
                    column(PaytoVendNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(BuyfromVendNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; Number)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"),
                                       "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ArchiveDocument; ArchiveDocument)
                        {
                        }
                        column(LogInteraction; LogInteraction)
                        {
                        }
                        column(Type_PurchaseLine; FORMAT("Purchase Line".Type, 0, 2))
                        {
                            IncludeCaption = false;
                        }
                        column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                        {
                            IncludeCaption = false;
                        }
                        column(Description_PurchaseLine; "Purchase Line".Description)
                        {
                            IncludeCaption = false;
                        }
                        column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                        {
                            IncludeCaption = false;
                        }
                        column(UnitOfMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                        {
                            IncludeCaption = false;
                        }
                        column(ExpcRecpDt_PurchHdr; FORMAT("Purchase Line"."Expected Receipt Date"))
                        {
                            IncludeCaption = false;
                        }
                        column(No_PurchaseLine; "Purchase Line"."No.")
                        {
                        }
                        column(VendItemNo_PurchLine; "Purchase Line"."Vendor Item No.")
                        {
                            IncludeCaption = false;
                        }
                        column(PurchaseLineNoOurNoCap; PurchaseLineNoOurNoCapLbl)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(Number2_DimensionLoop; Number)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FINDSET() then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                PurchLine.FIND('-')
                            else
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;
                            if ("Purchase Line"."Item Reference No." <> '') and (not ShowInternalInfo) then
                                "Purchase Line"."No." := CopyStr("Purchase Line"."Item Reference No.", 1, MaxStrLen("Purchase Line"."No."));

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
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
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode() then
                        codeunit.RUN(codeunit::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CurrReport.LANGUAGE := LanguageCdu.GetLanguageIdOrDefault("Language Code");

                if "Payment Terms Code" <> '' then
                    RecGPaymentTerms.GET("Payment Terms Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if not IsReportInPreviewMode() then
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);



                //--> BC6 NC 13052024
                if "Language Code" = 'ENU' then
                    GDocDate := FORMAT("Purchase Header"."Document Date", 0, '<Month Text> <Closing><Day>, <Year4>')
                else
                    GDocDate := FORMAT("Purchase Header"."Document Date", 0, 4);
            end;

            trigger OnPostDataItem()
            begin
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
                    field(NoOfCopiesF; NoOfCopies)
                    {
                        ApplicationArea = Suite;
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field(ShowInternalInfoF; ShowInternalInfo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteractionF; LogInteraction)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;

            case PurchSetup."Archive Quotes" of
                PurchSetup."Archive Quotes"::Never:
                    ArchiveDocument := false;
                PurchSetup."Archive Quotes"::Always:
                    ArchiveDocument := true;
            end;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        PurchSetup.GET();

        CompanyInfo.CALCFIELDS(Picture, "Info Picture");
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Purchase Header".FINDSET() then
                repeat
                    "Purchase Header".CALCFIELDS("No. of Archived Versions");
                    SegManagement.LogDocument(
                      11, "Purchase Header"."No.", "Purchase Header"."Doc. No. Occurrence", "Purchase Header"."No. of Archived Versions",
                      DATABASE::Vendor, "Purchase Header"."Pay-to Vendor No.", "Purchase Header"."Purchaser Code", '',
                      "Purchase Header"."Posting Description", '');
                until "Purchase Header".NEXT() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();
    end;

    var
        CompanyInfo: Record "Company Information";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RecGPaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ArchiveManagement: codeunit ArchiveManagement;
        FormatAddr: codeunit "Format Address";
        FormatDocument: codeunit "Format Document";
        LanguageCdu: Codeunit Language;
        PurchPost: codeunit "Purch.-Post";
        SegManagement: codeunit SegManagement;
        ArchiveDocument: Boolean;
        ArchiveDocumentEnable: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CompanyInfoBankNameCapLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoGiroNoCapLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoCapLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCapLbl: Label 'VAT Reg. No.', Comment = 'FRA="N° id. intracomm."';
        CompInfoBankAccNoCapLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        DocumentDateCapLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        EMailCaptionLbl: Label 'Email', Comment = 'FRA="E-mail"';
        ExpectedDateCaptionLbl: Label 'Expected Date', Comment = 'FRA="Date prévue"';
        Footer1: Label 'SAS with capital of €50,000 - C.C.P PARIS 10634-30 H', Comment = 'FRA="SAS au capital de 50.000 € - C.C.P PARIS 10634-30 H"';
        FooterBankLbl: Label 'Bank', Comment = 'FRA="Banque"';
        FooterRcs: Label 'RC Compiègne B572113918', Comment = 'FRA="RC Compiègne B572113918"';
        FooterSiege: Label 'The Head Office : ', Comment = 'FRA="Siège Social : "';
        FooterSiretLbl: Label 'SIRET N°', Comment = 'FRA="SIRET N°"';
        FooterVatLbl: Label 'IDENTIFIANT TVA/VAT N°', Comment = 'FRA="IDENTIFIANT TVA/VAT N°"';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        LineDimensionsCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        PageNoCaptionLbl: Label 'Page %1/%2', Comment = 'FRA="Page %1/%2"';
        PaymentTermsLbl: Label 'Payments Terms', Comment = 'FRA="Conditions de paiement"';
        PlaceLbl: Label 'Gouvieux,', Comment = 'FRA="Gouvieux le"';
        PurchaseLineDescCapLbl: Label 'Description', Comment = 'FRA="Description"';
        PurchaseLineNoCaptionLbl: Label 'Item No.', Comment = 'FRA="N° article"';
        PurchaseLineNoOurNoCapLbl: Label 'Our No.', Comment = 'FRA="Notre n°"';
        PurchaseLineQuantityCapLbl: Label 'Qty', Comment = 'FRA="Qté"';
        PurchaseLineUOMCaptionLbl: Label 'Unit of Measure', Comment = 'FRA="Unité"';
        PurchaserTextCaptionLbl: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        PurchLineVendItemNoCapLbl: Label 'Vendor Item No.', Comment = 'FRA="Référence fournisseur"';
        QuoteNoCaptionLbl: Label 'Quote No.', Comment = 'FRA="N° devis"';
        ReferenceTextCaptionLbl: Label 'Your Reference', Comment = 'FRA="Votre référence"';
        ShipmentMethodDescCapLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        Text002: Label 'Purchase - Quote %1', Comment = 'FRA="Demande de prix : %1"';
        VatRegistrationNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        GDocDate: Text;
        CopyText: Text[30];
        PurchaserText: Text[30];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VATNoText: Text[80];
        CompanyAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        DimText: Text[120];

    procedure IntializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch.Qte.") <> '';
    end;

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");
        FormatDocument.SetPaymentTerms(RecGPaymentTerms, PurchaseHeader."Payment Terms Code", PurchaseHeader."Language Code");
        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FIELDCAPTION("VAT Registration No."));
    end;
}

