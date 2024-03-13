namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;
using System.Utilities;
using BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Customer;
using System.Globalization;
report 50016 "Etiquette Packaging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EtiquetteColisage.rdlc';
    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(DocumentNo_BC; GTxtDocumentNo)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfoPays; GTxtCompanyInfoPays)
                    {
                    }
                    column(SalesShptCopyText; GTxtSalesShptCopyText)
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyNoEORI; CompanyInfo."No. EORI")
                    {
                    }
                    column(CompanyNoEORI_Lbl; CompanyInfo.FIELDCAPTION("No. EORI"))
                    {
                    }
                    column(SalesShipmentHeaderOrderNo; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(SalesShipmentHeaderOrderNo_Lbl; "Sales Shipment Header".FIELDCAPTION("Order No."))
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date"))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
                    {
                    }
                    column(OrderNoCaption_SalesShptHeader; 'Our Document No.')
                    {
                    }
                    column(ExternalDocumentNoCaption_SalesShptHeader; 'Purchase Order No.')
                    {
                    }
                    column(ExternalDocumentNo_SalesShptHeader; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(CompanyFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
                    {
                    }
                    column(SalesPersonPhone; SalesPurchPerson."Phone No.")
                    {
                    }
                    column(SalesPersonEmail; SalesPurchPerson."E-Mail")
                    {
                    }
                    column(CompanyInfoBankBranchNo; CompanyInfo."Bank Branch No.")
                    {
                    }
                    column(CompanyInfoBankIBAN; CompanyInfo.IBAN)
                    {
                    }
                    column(CompanyInfoBankSWIFT; CompanyInfo."SWIFT Code")
                    {
                    }
                    column(CompanyBankSWIFT; GTxtCompanyBankSWIFT)
                    {
                    }
                    column(CompanyBankIBAN; GTxtCompanyBankIBAN)
                    {
                    }
                    column(CompanyBankBranch; GTxtCompanyBankBranch)
                    {
                    }
                    column(YourRef_Lbl; GTxtYourRef_Lbl)
                    {
                    }
                    column(PackingDetail; "Sales Shipment Header"."Packing detail")
                    {
                    }
                    column(PoidsBrute; GDecPoidsBrut)
                    {
                    }
                    column(PoidsNet; GDecPoidsnet)
                    {
                    }
                    column(CodeTransporteur; GTxtTransporteur)
                    {
                    }
                    column(PackingDetail_Lbl; TextPackingDetaile)
                    {
                    }
                    column(GrossWeight_Lbl; TextPoids)
                    {
                    }
                    column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoRegistrationNumber; CompanyInfo."Registration No.")
                    {
                    }
                    column(NumTVAClient; GTxtNumTVAClient)
                    {
                    }
                    column(ShepingMethodeCode; GTxtCondLivraisonEtendues)
                    {
                    }
                    column(ShepingMethodeCode_Lbl; ShptMethodDescLbl)
                    {
                    }
                    column(PaymentTerms_Lbl; PaymentTermsDescLbl)
                    {
                    }
                    column(PayementTerms; GTxtPayementsTerm)
                    {
                    }
                    column(CompanyInfoVATNo_Lbl; GTxtCompanyVAT)
                    {
                    }
                    column(CompanyVAT_ICE_Lbl; GTxtCompanyVAT_ICE)
                    {
                    }
                    column(TxtOrigineCE_ICE; GTxtOrigineCE)
                    {
                    }
                    column(TxtItemNoLbl; GTxtItemNoLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Text01: Label '%1 - %2', Comment = '%1 = "Dimension Code",%2 = "Dimension Value Code"';
                            Text02: Label '%1; %2 - %3', Comment = '%1 = DimText , %2 = "Dimension Code", %3 = "Dimension Value Code"';
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
                                    DimText := STRSUBSTNO(Text01, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        Text02, DimText,
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
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.")
                                            where(Quantity = filter(> 0));
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(Description2_SalesShptLine; "Description 2")
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure")
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(Description_SalesShptLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesShptLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(OutstandingQty_SalesShpline; "Sales Shipment Line"."Outstandin Qty report")
                        {
                            DecimalPlaces = 0 : 3;
                        }
                        column(OutstandingQty_SalesShplineCaption; FIELDCAPTION("Outstanding Qty"))
                        {
                        }
                        column(Reference_Externe; "Sales Shipment Line"."Item Reference No.")
                        {
                        }
                        column(ResteALivrer_Lbl; GTxtResteALivrerLbl)
                        {
                        }
                        column(QteRestante_Lbl; GTxtQteRestante)
                        {
                        }
                        column(QteExpediee_Lbl; GTxtQteExpedieeLbl)
                        {
                        }
                        column(QteCommandee_Lbl; GTxtQteCommandeeLbl)
                        {
                        }
                        column(QteCommandee; GIntQteCommandee)
                        {
                        }
                        column(NoOrRef_SalesShpline; GTxtItemNo)
                        {
                        }
                        column(NomenclatureArticle; GTxtNomenclatureArticle)
                        {
                        }
                        column(SalesLine_NoColis; "Sales Shipment Line"."N° Package")
                        {
                        }
                        column(SalesLine_NoColisCaption; GTxtColisCaption)
                        {
                        }
                        column(GTxtColisRef; GTxtColisREF)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                Text01: Label '%1 - %2', Comment = '%1 = "Dimension Code",%2 = "Dimension Value Code"';
                                Text02: Label '%1; %2 - %3', Comment = '%1 = DimText , %2 = "Dimension Code", %3 = "Dimension Value Code"';
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
                                        DimText := STRSUBSTNO(Text01, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            Text02, DimText,
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
                        dataitem(DisplayAsmInfo; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent() + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent() + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record 30;
                            begin
                                if Number = 1 then
                                    PostedAsmLine.FINDSET()
                                else
                                    PostedAsmLine.NEXT();

                                if ItemTranslation.GET(PostedAsmLine."No.",
                                     PostedAsmLine."Variant Code",
                                     "Sales Shipment Header"."Language Code")
                                then
                                    PostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.BREAK();
                                if not AsmHeaderExists then
                                    CurrReport.BREAK();

                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            LinNo := "Line No.";
                            if not ShowCorrectionLines and Correction then
                                CurrReport.SKIP();

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DisplayAssemblyInformation then
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            //DELPHI AUB 18/02/2019
                            GTxtItemNo := "Sales Shipment Line"."No.";
                            if "Sales Shipment Line".Type = "Sales Shipment Line".Type::Item then
                                if "Sales Shipment Line"."Item Reference No." <> '' then
                                    GTxtItemNo := "Sales Shipment Line"."Item Reference No.";
                            //END DELPHI AUB
                            //DELPHI AUB 03.10.2019
                            GRecSalesLine.SETFILTER("Document No.", "Sales Shipment Line"."Order No.");
                            GRecSalesLine.SETRANGE("Line No.", "Sales Shipment Line"."Order Line No.");
                            if GRecSalesLine.FINDFIRST() then
                                GIntQteCommandee := GRecSalesLine.Quantity
                            else begin
                                //On regarde dans les commandes archivées si pas de commande trouvée
                                GRecSalesHeaderArchive.SETFILTER("No.", "Sales Shipment Line"."Order No.");
                                if GRecSalesHeaderArchive.FINDLAST() then begin
                                    GRecSalesLineArchive.SETRANGE("Document No.", "Sales Shipment Line"."Order No.");
                                    GRecSalesLineArchive.SETRANGE("Version No.", GRecSalesHeaderArchive."Version No.");
                                    GRecSalesLineArchive.SETRANGE("Doc. No. Occurrence", GRecSalesHeaderArchive."Doc. No. Occurrence");
                                    GRecSalesLineArchive.SETRANGE("Line No.", "Sales Shipment Line"."Order Line No.");
                                    if GRecSalesLineArchive.FINDFIRST() then
                                        GIntQteCommandee := GRecSalesLineArchive.Quantity;
                                end;
                            end;

                            //END DELPHI AUB 03.10.2019

                            //DEB DELPHI XAV Package 24/03/21
                            if "Sales Shipment Line"."N° Package" <> '' then begin
                                GTxtColisCaption := 'Package : ';
                                LRecColis.GET("Sales Shipment Line"."N° Package");
                                GTxtColisREF := LRecColis."Package Reference" + ' ' + LRecColis."Type of package";
                            end
                            else begin
                                GTxtColisREF := '';
                                GTxtColisCaption := '';
                            end;
                        end;

                        trigger OnPostDataItem()
                        begin
                            if ShowLotSN then begin
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                                TrackingSpecCount :=
                                  ItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer,
                                    "Sales Shipment Header"."No.", DATABASE::"Sales Shipment Header", 0);
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(false);
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FINDLAST();
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(DimensionLoop3; Integer)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(DimText3; DimText3)
                        {
                        }
                        column(HeaderDimensionsCaption3; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Text01: Label '%1 - %2', Comment = '%1 = "Dimension Code",%2 = "Dimension Value Code"';
                            Text02: Label '%1; %2 - %3', Comment = '%1 = DimText , %2 = "Dimension Code", %3 = "Dimension Value Code"';
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry3.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText3);
                            Continue := false;
                            repeat
                                OldDimText := DimText3;
                                if DimText3 = '' then
                                    DimText3 := STRSUBSTNO(Text01, DimSetEntry3."Dimension Code", DimSetEntry3."Dimension Value Code")
                                else
                                    DimText3 :=
                                      STRSUBSTNO(
                                        Text02, DimText3,
                                        DimSetEntry3."Dimension Code", DimSetEntry3."Dimension Value Code");
                                if STRLEN(DimText3) > MAXSTRLEN(OldDimText) then begin
                                    DimText3 := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry3.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(SalesShipmentLineResteALivrer; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.")
                                            where("Outstandin Qty report" = filter(> 0));
                        column(No_SalesShiptLine2; SalesShipmentLineResteALivrer."No.")
                        {
                        }
                        column(Description_SalesShiptLine2; SalesShipmentLineResteALivrer.Description)
                        {
                        }
                        column(UOM_SalesShiptLine2; SalesShipmentLineResteALivrer."Unit of Measure")
                        {
                        }
                        column(QteRestanteCalculee_SSL2; SalesShipmentLineResteALivrer."Outstandin Qty report")
                        {
                            DecimalPlaces = 0 : 3;
                        }
                        column(QteRestante_SalesShiptLine2; SalesShipmentLineResteALivrer."Outstanding Qty")
                        {
                            DecimalPlaces = 0 : 3;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            LinNo := SalesShipmentLineResteALivrer."Line No.";

                            DimSetEntry3.SETRANGE("Dimension Set ID", "Dimension Set ID");
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FINDLAST();
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, SalesShipmentLineResteALivrer."Line No.");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                        {
                        }
                        column(CustAddr1; CustAddr[1])
                        {
                        }
                        column(CustAddr2; CustAddr[2])
                        {
                        }
                        column(CustAddr3; CustAddr[3])
                        {
                        }
                        column(CustAddr4; CustAddr[4])
                        {
                        }
                        column(CustAddr5; CustAddr[5])
                        {
                        }
                        column(CustAddr6; CustAddr[6])
                        {
                        }
                        column(CustAddr7; CustAddr[7])
                        {
                        }
                        column(CustAddr8; CustAddr[8])
                        {
                        }
                        column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                        {
                        }
                        column(BilltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Bill-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowCustAddr then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(ItemTrackingLine; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(TrackingSpecBufferNo; TrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NoCaption; NoCaptionLbl)
                        {
                        }
                        dataitem(TotalItemTracking; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = const(1));
                            column(Quantity1; TotalQty)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TrackingSpecBuffer.FINDSET()
                            else
                                TrackingSpecBuffer.NEXT();

                            if not ShowCorrectionLines and TrackingSpecBuffer.Correction then
                                CurrReport.SKIP();
                            if TrackingSpecBuffer.Correction then
                                TrackingSpecBuffer."Quantity (Base)" := -TrackingSpecBuffer."Quantity (Base)";

                            ShowTotal := false;
                            if ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer) then
                                ShowTotal := true;

                            ShowGroup := false;
                            if (TrackingSpecBuffer."Source Ref. No." <> OldRefNo) or
                               (TrackingSpecBuffer."Item No." <> OldNo)
                            then begin
                                OldRefNo := TrackingSpecBuffer."Source Ref. No.";
                                OldNo := TrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            end else
                                ShowGroup := true;
                            TotalQty += TrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TrackingSpecCount = 0 then
                                CurrReport.BREAK();
                            CurrReport.NEWPAGE();
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        if ShowLotSN then begin
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := false;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;
                    TotalQty := 0;           // Item Tracking
                end;

                trigger OnPostDataItem()
                begin
                    if not IsReportInPreviewMode() then
                        codeunit.RUN(codeunit::"Sales Shpt.-Printed", "Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
            dataitem(Package; Package)
            {
                DataItemLink = "Shipping No." = field("No.");
                column(Colis_No; Package."Package No.")
                {
                }
                column(Colis_Longueur_Cm; ZeroIsBlanckDecimal(Package."Length (cm)"))
                {
                }
                column(Colis_Largeur_Cm; ZeroIsBlanckDecimal(Package."Width (cm)"))
                {
                }
                column(Colis_Hauteur_Cm; ZeroIsBlanckDecimal(Package."Height (cm)"))
                {
                }
                column(Colis_Volume_M3; Package."Volume (m3)")
                {
                }
                column(Colis_PoidsNet; ZeroIsBlanckDecimal(Package."Net Weight"))
                {
                }
                column(Colis_PoidsBrut; ZeroIsBlanckDecimal(Package."Gross Weight"))
                {
                }
                column(Colis_NbarticleColis; ZeroIsBlanckInteger(Package."Nb of pieces"))
                {
                }
                column(Colis_Nature; Package."Type of package")
                {
                }
                column(Colis_Designation; Package."Product Description")
                {
                }
                column(Colis_Reference; Package."Package Reference")
                {
                }
                column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                {
                }
                column(ShipToAddr1; ShipToAddr[1])
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
                column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Package.CALCFIELDS("Nb of pieces");
                end;
            }

            trigger OnAfterGetRecord()
            var
                LRecPays: Record 9;
            begin
                CurrReport.LANGUAGE := CDULanguage.GetLanguageID("Language Code");

                //FormatAddressFields("Sales Shipment Header");

                //DELPHI AUB 12.10.2021
                ShipToAddr[1] := "Sales Shipment Header"."Ship-to Name";
                ShipToAddr[3] := "Sales Shipment Header"."Ship-to Address" + ' ' + "Sales Shipment Header"."Ship-to Address 2";
                ShipToAddr[4] := "Sales Shipment Header"."Ship-to Post Code" + ' ' + "Sales Shipment Header"."Ship-to City";
                ShipToAddr[5] := ' ';
                if LRecPays.GET("Sales Shipment Header"."Sell-to Country/Region Code") then ShipToAddr[5] := LRecPays."County Name";
                //END DELPHI AUB
                FormatDocumentFields("Sales Shipment Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                //DEB DELPHI XAV Poids- Code Transport - Incoterms
                if ShipmentMethod.GET("Sales Shipment Header"."Shipment Method Code") then begin
                    if ShipmentMethod.Incoterms then
                        GTxtCondLivraisonEtendues := ShipmentMethod.Description + ' - ' + "Sales Shipment Header"."Compl. cond. livraison" + ' - Incoterms © 2010'
                    else
                        GTxtCondLivraisonEtendues := ShipmentMethod.Description + ' - ' + "Sales Shipment Header"."Compl. cond. livraison";
                end
                else
                    GTxtCondLivraisonEtendues := "Sales Shipment Header"."Shipment Method Code" + ' - ' + "Sales Shipment Header"."Compl. cond. livraison";

                if GrecTransporteur.GET("Sales Shipment Header"."Shipping Agent Code") then
                    GTxtTransporteur := GrecTransporteur.Name
                else
                    GTxtTransporteur := "Sales Shipment Header"."Shipping Agent Code";

                GRecSalesShipmentLine.SETRANGE("No.", "Sales Shipment Header"."No.");
                if GRecSalesShipmentLine.FINDFIRST() then
                    repeat
                        GDecPoidsBrut += GRecSalesShipmentLine."Gross Weight";
                        GDecPoidsnet += GRecSalesShipmentLine."Net Weight";
                    until GRecSalesShipmentLine.NEXT() = 0;

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;
                // DELPHI AUB 11.06.2019
                GTxtCompanyVAT_ICE := 'No. TVA';
                GTxtOrigineCE := '';

                if GRecCust2.GET("Bill-to Customer No.") then begin
                    // DELPHI AUB 11.06.2019
                    if GRecCust2.ICE then begin
                        GTxtCompanyVAT_ICE := 'No. ICE';
                        GTxtOrigineCE := 'L''exportateur des produits couverts par le présent document déclare que sauf indication claire du contraire ces produits ont l''origine préférentielle CE.';
                    end;
                    // END DELPHI AUB 11.06.2019
                    GTxtNumTVAClient := GRecCust2."VAT Registration No.";
                end;
                //DELPHI AUB 28.06.2019
                if GRecCust2."VAT Registration No." = '' then
                    GTxtCompanyVAT_ICE := '';
                //END DELPHI AUB 28.06.2019
                //DELPHI AUB 07.10.2019
                GTxtDocumentNo := "Sales Shipment Header"."No.";
                GTxtDocumentNo := CONVERTSTR(GTxtDocumentNo, 'L', 'C');
                //END DELPHI AUB 07.10.2019

                if PaymentTerms.GET("Payment Terms Code") then
                    GTxtPayementsTerm := PaymentTerms.Description
                else
                    GTxtPayementsTerm := "Sales Shipment Header"."Payment Terms Code";

                //FIN DELPHI XAV
            end;

            trigger OnPostDataItem()
            begin
                OnAfterPostDataItem("Sales Shipment Header");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        SalesSetup.GET();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);

        OnAfterInitReport();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Sales Shipment Header".FINDSET() then
                repeat
                    SegManagement.LogDocument(
                      5, "Sales Shipment Header"."No.", 0, 0, DATABASE::Customer, "Sales Shipment Header"."Sell-to Customer No.",
                      "Sales Shipment Header"."Salesperson Code", "Sales Shipment Header"."Campaign No.",
                      "Sales Shipment Header"."Posting Description", '');
                until "Sales Shipment Header".NEXT() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();
        AsmHeaderExists := false;
    end;

    var
        Text002: Label 'Sales - Shipment %1', Comment = '%1 = Document No.';
        SalesPurchPerson: Record 13;
        GRecCust2: Record 18;
        GRecSalesLine: Record 37;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        CompanyInfo3: Record 79;
        GRecSalesShipmentLine: Record 111;
        GrecTransporteur: Record 291;
        SalesSetup: Record 311;
        TrackingSpecBuffer: Record 336 temporary;
        GrecTraductionShipMethode: Record 463;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        Language: Record 8;
        TrackingSpecBuffer: Record 336 temporary;
        PostedAsmHeader: Record 910;
        PostedAsmLine: Record 911;
        GRecSalesHeaderArchive: Record 5107;
        GRecSalesLineArchive: Record 5108;
        RespCenter: Record 5714;
        ItemTrackingAppendix: report 6521;
        ShipmentMethod: Record 10;
        GRecSalesShipmentLine: Record 111;
        GrecTransporteur: Record 291;
        GRecItemEntryRelation: Record 6507;
        FormatAddr: Codeunit 365;
        FormatDocument: Codeunit 368;
        SegManagement: Codeunit 5051;
        ItemTrackingDocMgt: Codeunit 6503;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        DisplayAssemblyInformation: Boolean;
        LogInteraction: Boolean;
        [InDataSet]

        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowCorrectionLines: Boolean;
        ShowCustAddr: Boolean;
        ShowGroup: Boolean;
        ShowInternalInfo: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        OldNo: Code[20];
        GDecPoidsBrut: Decimal;
        GDecPoidsnet: Decimal;
        GIntQteCommandee: Decimal;
        TotalQty: Decimal;
        [InDataSet]

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OldRefNo: Integer;
        OutputNo: Integer;
        TrackingSpecCount: Integer;
        BankAccNoCaptionLbl: Label 'Account No.';
        BankNameCaptionLbl: Label 'Bank';
        BilltoAddressCaptionLbl: Label 'Bill-to Address';
        DescriptionCaptionLbl: Label 'Description';
        NoCaptionLbl: Label 'No.';
        PageCaptionCap: Label 'Page %1 of %2';
        GTxtCondLivraisonEtendues: Text[150];
        GTxtNomenclatureArticle: Text[20];
        GDecPoidsBrut: Decimal;
        GDecPoidsnet: Decimal;
        GTxtTransporteur: Text[80];
        GRecCountry: Record 9;
        GTxtCompanyInfoPays: Text[50];
        GRecCust2: Record 18;
        GTxtNumTVAClient: Text[60];
        PaymentTerms: Record 3;
        GTxtPayementsTerm: Text[150];
        GrecTraductionShipMethode: Record 463;
        ShipmentMethod2: Record 10;
        GTxtShipmentMethodedescription: Text[150];
        GTxtItemNo: Text[20];
        GTxtCompanyVAT_ICE: Text[80];
        GTxtOrigineCE: Text[250];
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyPhoneNo: Label 'Phone';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyHomepage: Label 'Website';
        GTxtCompanyemail: Label 'E-Mail';
        GTxtCompanyVAT: Label 'VAT Id. Num.';
        GTxtCompanyGesch: Label 'Director';
        GTxtCompanySitz: Label 'H. Q.';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyTrib: Label 'Trial court';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanySalespers: Label 'Agent';
        GTxtCustomerNum: Label 'Customer num.';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        GTxtCompanyBankIBAN: Label 'IBAN';
        GTxtSalesShptCopyText: Label 'Shipment';
        GTxtItemNo_Line_Lbl: Label 'Item No.';
        GTxtYourRef_Lbl: Label 'Your Reference';
        TextTransporteur: Label 'Transporteur';
        TextPackingDetaile: Label 'Packing details';
        TextPoids: Label 'Gross Weight';
        ShptMethodDescLbl: Label 'Shipment Method';
        PaymentTermsDescLbl: Label 'Payment Terms';
        GTxtQteCommandeeLbl: Label 'Qté commandée';
        GTxtResteALivrerLbl: Label 'Reste à livrer';
        GTxtItemNoLbl: Label 'N° article';
        GRecSalesLine: Record 37;
        GRecSalesHeaderArchive: Record 5107;
        GIntQteCommandee: Decimal;
        GRecSalesLineArchive: Record 5108;
        GTxtQteExpedieeLbl: Label 'Qté expédiée';
        GTxtDocumentNo: Text[50];
        GTxtQteRestante: Label 'Qté restante';
        DimSetEntry3: Record 480;
        DimText3: Text[120];
        GTxtColisCaption: Text[50];
        GTxtColisREF: Text[100];
        LRecColis: Record 50009;
        CDULanguage: codeunit Language;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: codeunit 9520;
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record 110)
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FormatDocumentFields(SalesShipmentHeader: Record 110)
    begin
        with SalesShipmentHeader do begin
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
        end;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record 204;
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PADSTR('', 2, ' '));
    end;

    [IntegrationEvent(true, true)]
    local procedure OnAfterInitReport()
    begin
    end;

    [IntegrationEvent(true, true)]
    local procedure OnAfterPostDataItem(var SalesShipmentHeader: Record 110)
    begin
    end;

    local procedure ZeroIsBlanckDecimal(Decimale: Decimal) Return: Text[150]
    begin
        if Decimale <> 0 then
            Return := FORMAT(Decimale, 10, '<Standard Format,0>')
        else
            Return := '';
    end;

    local procedure ZeroIsBlanckInteger("Integer": Integer) Return: Text[150]
    begin
        if Integer <> 0 then
            Return := FORMAT(Integer)
        else
            Return := '';
    end;
}

