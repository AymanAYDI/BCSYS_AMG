namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using System.Utilities;
using Microsoft.Inventory.Item;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Address;
using Microsoft.Inventory.Reports;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Sales.Document;
using Microsoft.Sales.Archive;
using System.Globalization;
using Microsoft.Inventory.Location;
using Microsoft.Assembly.History;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.Company;
using Microsoft.CRM.Team;
using Microsoft.Utilities;
using Microsoft.CRM.Segment;
using System.EMail;
using Microsoft.Foundation.UOM;
using Microsoft.CRM.Interaction;
report 50043 "Sales-Shipment" //208 duplicate
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesShipment.rdlc';
    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
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
                    column(ShipToAddr1; ShipToAddr[1])
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
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
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
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
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
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
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
                            Text001: Label '%1 - %2', Comment = '%1="Dimension Code" %2="Dimension Value Code"';
                            Text002: Label '%1; %2 - %3', Comment = '%1=DimText %2="Dimension Code" %3="Dimension Value Code"';
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
                                    DimText := STRSUBSTNO(Text001, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        Text002, DimText,
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
                            if not BoolShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(Description2_SalesShptLine; "Description 2")
                        {
                        }
                        column(ShowInternalInfo; BoolShowInternalInfo)
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
                        column(OutstandingQty_SalesShpline; "Sales Shipment Line"."Outstanding Qty")
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
                                Text001: Label '%1 - %2', Comment = '%1="Dimension Code" %2="Dimension Value Code"';
                                Text002: Label '%1; %2 - %3', Comment = '%1=DimText %2="Dimension Code" %3="Dimension Value Code"';
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
                                        DimText := STRSUBSTNO(Text001, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            Text002, DimText,
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
                                if not BoolShowInternalInfo then
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
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
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
                        end;

                        trigger OnPostDataItem()
                        begin
                            if BoolShowLotSN then begin
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                                TrackingSpecCount :=
                                  ItemTrackingDocMgt.RetrieveDocumentItemTracking(TempTrackingSpecBuffer,
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
                            Text001: Label '%1 - %2', Comment = '%1="Dimension Code" %2="Dimension Value Code"';
                            Text002: Label '%1; %2 - %3', Comment = '%1=DimText %2="Dimension Code" %3="Dimension Value Code"';
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
                                    DimText3 := STRSUBSTNO(Text001, DimSetEntry3."Dimension Code", DimSetEntry3."Dimension Value Code")
                                else
                                    DimText3 :=
                                      STRSUBSTNO(
                                        Text002, DimText3,
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
                            if not BoolShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(SalesShipmentLineResteALivrer; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.")
                                            where("Outstanding Qty" = filter(> 0));
                        column(No_SalesShiptLine2; SalesShipmentLineResteALivrer."No.")
                        {
                        }
                        column(Description_SalesShiptLine2; SalesShipmentLineResteALivrer.Description)
                        {
                        }
                        column(UOM_SalesShiptLine2; SalesShipmentLineResteALivrer."Unit of Measure")
                        {
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
                        column(TrackingSpecBufferNo; TempTrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TempTrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TempTrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TempTrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TempTrackingSpecBuffer."Quantity (Base)")
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
                                TempTrackingSpecBuffer.FINDSET()
                            else
                                TempTrackingSpecBuffer.NEXT();

                            if not ShowCorrectionLines and TempTrackingSpecBuffer.Correction then
                                CurrReport.SKIP();
                            if TempTrackingSpecBuffer.Correction then
                                TempTrackingSpecBuffer."Quantity (Base)" := -TempTrackingSpecBuffer."Quantity (Base)";

                            ShowTotal := false;
                            if ItemTrackingAppendix.IsStartNewGroup(TempTrackingSpecBuffer) then
                                ShowTotal := true;

                            ShowGroup := false;
                            if (TempTrackingSpecBuffer."Source Ref. No." <> OldRefNo) or
                               (TempTrackingSpecBuffer."Item No." <> OldNo)
                            then begin
                                OldRefNo := TempTrackingSpecBuffer."Source Ref. No.";
                                OldNo := TempTrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            end else
                                ShowGroup := true;
                            TotalQty += TempTrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TrackingSpecCount = 0 then
                                CurrReport.BREAK();
                            CurrReport.NEWPAGE();
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TempTrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        if BoolShowLotSN then begin
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
                        CODEUNIT.RUN(CODEUNIT::"Sales Shpt.-Printed", "Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(IntNoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := CULanguage.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields("Sales Shipment Header");
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
                    field(NoOfCopies; IntNoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; BoolShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field(LogInteraction; BoolLogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the reports that you print as interactions.';
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Correction Lines';
                        ToolTip = 'Specifies if the correction lines of an undoing of quantity posting will be shown on the report.';
                    }
                    field(ShowLotSN; BoolShowLotSN)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Serial/Lot Number Appendix';
                        ToolTip = 'Specifies if you want to print an appendix to the sales shipment report showing the lot and serial numbers in the shipment.';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        SalesSetup.GET();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPostReport()
    begin
        if BoolLogInteraction and not IsReportInPreviewMode() then
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
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        DimSetEntry3: Record "Dimension Set Entry";
        PaymentTerms: Record "Payment Terms";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        GRecSalesHeaderArchive: Record "Sales Header Archive";
        GRecSalesLine: Record "Sales Line";
        GRecSalesLineArchive: Record "Sales Line Archive";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GRecSalesShipmentLine: Record "Sales Shipment Line";
        ShipmentMethod: Record "Shipment Method";
        GrecTransporteur: Record "Shipping Agent";
        TempTrackingSpecBuffer: Record "Tracking Specification" temporary;
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        CULanguage: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        AsmHeaderExists: Boolean;
        Continue: Boolean;
        DisplayAssemblyInformation: Boolean;
        BoolLogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowCorrectionLines: Boolean;
        ShowCustAddr: Boolean;
        ShowGroup: Boolean;
        BoolShowInternalInfo: Boolean;
        BoolShowLotSN: Boolean;
        ShowTotal: Boolean;
        OldNo: Code[20];
        GDecPoidsBrut: Decimal;
        GDecPoidsnet: Decimal;
        GIntQteCommandee: Decimal;
        TotalQty: Decimal;
        LinNo: Integer;
        IntNoOfCopies: Integer;
        NoOfLoops: Integer;
        OldRefNo: Integer;
        OutputNo: Integer;
        TrackingSpecCount: Integer;
        BankAccNoCaptionLbl: Label 'Account No.';
        BankNameCaptionLbl: Label 'Bank';
        BilltoAddressCaptionLbl: Label 'Bill-to Address';
        DescriptionCaptionLbl: Label 'Description';
        DocumentDateCaptionLbl: Label 'Document Date';
        EmailCaptionLbl: Label 'Email';
        GiroNoCaptionLbl: Label 'Giro No.';
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyBankIBAN: Label 'IBAN';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyVAT: Label 'VAT Id. Num.';
        GTxtItemNoLbl: Label 'N° article';
        GTxtQteCommandeeLbl: Label 'Qté commandée';
        GTxtQteExpedieeLbl: Label 'Qté expédiée';
        GTxtQteRestante: Label 'Qté restante';
        GTxtResteALivrerLbl: Label 'Reste à livrer';
        GTxtSalesShptCopyText: Label 'Shipment';
        GTxtYourRef_Lbl: Label 'Your Reference';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        HomePageCaptionLbl: Label 'Home Page';
        ItemTrackingAppendixCaptionLbl: Label 'Item Tracking - Appendix';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        LotNoCaptionLbl: Label 'Lot No.';
        NoCaptionLbl: Label 'No.';
        PageCaptionCap: Label 'Page %1 of %2';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        QuantityCaptionLbl: Label 'Quantity';
        SerialNoCaptionLbl: Label 'Serial No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        ShipmentNoCaptionLbl: Label 'Shipment No.';
        ShptMethodDescLbl: Label 'Shipment Method';
        TextPackingDetaile: Label 'Packing details';
        TextPoids: Label 'Gross Weight';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        GTxtCondLivraisonEtendues: Text;//[150];
        GTxtItemNo: Text[20];
        GTxtNomenclatureArticle: Text[20];
        SalesPersonText: Text[20];
        CopyText: Text[30];
        GTxtCompanyInfoPays: Text[50];
        GTxtDocumentNo: Text[50];
        GTxtNumTVAClient: Text[60];
        OldDimText: Text[75];
        GTxtCompanyVAT_ICE: Text[80];
        GTxtTransporteur: Text[80];
        ReferenceText: Text[80];
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        DimText: Text[75];
        DimText3: Text[75];
        GTxtPayementsTerm: Text[150];
        GTxtOrigineCE: Text[250];

    procedure InitLogInteraction()
    var
        DocumentType: Enum "Interaction Log Entry Document Type";
    begin
        BoolLogInteraction := SegManagement.FindInteractionTemplateCode(DocumentType::"Sales Shpt. Note") <> '';
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        IntNoOfCopies := NewNoOfCopies;
        BoolShowInternalInfo := NewShowInternalInfo;
        BoolLogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        BoolShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FormatDocumentFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        with SalesShipmentHeader do begin
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
        end;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PADSTR('', 2, ' '));
    end;

}

