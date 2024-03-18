namespace BCSYS.AMGALLOIS.Basic;
using System.Utilities;
using System.Globalization;
using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using Microsoft.Finance.Dimension;
using Microsoft.Utilities;
report 50009 "DGX CERFA"
{
    RDLCLayout = './DGXCERFA.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending);
            dataitem("DGX Header"; "DGX Header")
            {
                column(NoDGX_DGXHeader; "DGX Header"."DGX No.")
                {
                }
                column(TypeDGX_DGXHeader; "DGX Header"."DGX Type")
                {
                }
                column(Destinataire_DGXHeader; "DGX Header".Recipient)
                {
                }
                column(Destinatairenom_DGXHeader; "DGX Header"."Recipient Name")
                {
                }
                column(Destinataireadresse1_DGXHeader; "DGX Header"."Recipient Adress 1")
                {
                }
                column(Destinataireadresse2_DGXHeader; "DGX Header"."Recipient Adress 2")
                {
                }
                column(Destinatairecodepostal_DGXHeader; "DGX Header"."Recipient Post Code")
                {
                }
                column(Destinataireville_DGXHeader; "DGX Header"."Recipient City")
                {
                }
                column(DestinatairepaysEN_DGXHeader; "DGX Header"."Recipient Country EN")
                {
                }
                column(Typedetransport_DGXHeader; "DGX Header"."Type of transport")
                {
                }
                column("Aéroportdedépart_DGXHeader"; "DGX Header"."Airport of departure")
                {
                }
                column(Radioactif_DGXHeader; "DGX Header".Radioactive)
                {
                }
                column(Datedocument_DGXHeader; FORMAT("DGX Header"."Document Date", 0, '<Day,2><Filler Character, > <Month Text,3>. <Year4>'))
                {

                }
                column(NoBonLivraison_DGXHeader; "DGX Header"."Delivery slip no.")
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(MasseBruteTotale_DGXLines; GDecMasseBruteTotale)
                {
                }
                column(NbPages; CurrReport.PAGENO())
                {
                }
                dataitem(DimensionLoop1; Integer)
                {
                    DataItemLinkReference = "DGX Header";
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

                        Clear(DimText);
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
                        until DimSetEntry1.Next() = 0;
                    end;
                }
                dataitem("DGX Lines"; "DGX Lines")
                {
                    DataItemLink = DGXNo = field("DGX No.");
                    DataItemLinkReference = "DGX Header";
                    DataItemTableView = sorting(DGXNo, UN, LineNo)
                                        order(ascending);
                    dataitem(PageLoop; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(RefClient; GTxtRefClient)
                        {
                        }
                        column(LineNo_DGXLines; "DGX Lines".LineNo)
                        {
                        }
                        column(DGXNo_DGXLines; "DGX Lines".DGXNo)
                        {
                        }
                        column(ItemNo_DGXLines; "DGX Lines".ItemNo)
                        {
                        }
                        column(UN_DGXLines; "DGX Lines".UN)
                        {
                        }
                        column(Description_DGXLines; "DGX Lines".Description)
                        {
                        }
                        column(Classe_DGXLines; "DGX Lines".Class)
                        {
                        }
                        column(GroupeEmballage_DGXLines; "DGX Lines"."Packaging Group")
                        {
                        }
                        column(Qty_DGXLines; "DGX Lines".Qty)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(TypeofPacking_DGXLines; "DGX Lines"."Type of Packing")
                        {
                        }
                        column("Pointéclair_DGXLines"; "DGX Lines"."Flash point")
                        {
                        }
                        column(Limitedqty_DGXLines; "DGX Lines"."Limited qty")
                        {
                        }
                        column(Massebrutekg_DGXLines; "DGX Lines"."Gross Mass (kg)")
                        {
                        }
                        column(Massenettekg_DGXLines; "DGX Lines"."Net mass (kg)")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Airport; CTxtAirport)
                        {
                        }
                        column(PackingInstr; "DGX Lines"."Packing Inst")
                        {
                        }
                        column("Unitédemesure_DGXLines"; "DGX Lines"."Unit of measure")
                        {
                        }
                        column(FlashPoint_DGXLines; GTxtFlashPoint)
                        {
                        }
                        column(LimitedQuantity_DGXLines; GTxtLimitedQty)
                        {
                        }
                        column(SousClasse_DGXLines; GTxtSousClasse)
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        LinNo := LineNo;
                        if "DGX Lines"."Flash point" <> 0 then
                            GTxtFlashPoint := 'FLASH POINT : ' + FORMAT("DGX Lines"."Flash point") + '°C'
                        else
                            GTxtFlashPoint := ' ';
                        if "DGX Lines".Qty <= "DGX Lines"."Limited qty" then
                            GTxtLimitedQty := 'LIMITED QUANTITY'
                        else
                            GTxtLimitedQty := ' ';
                        if "DGX Lines"."Sub-Class" <> '' then
                            GTxtSousClasse := '(' + "DGX Lines"."Sub-Class" + ')'
                        else
                            GTxtSousClasse := ' ';
                        GDecMasseBruteTotale := "DGX Lines"."Gross Mass (kg)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        MoreLines := FIND('+');
                        while MoreLines and (ItemNo = '') do
                            MoreLines := Next(-1) <> 0;
                        if not MoreLines then
                            CurrReport.BREAK();
                        SetRange(LineNo, 0, "DGX Lines".LineNo);


                        if (GCodUN <> '') and ("DGX Lines".UN <> GCodUN) then
                            CurrReport.NEWPAGE();
                        GCodUN := "DGX Lines".UN;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "DGX Header".CALCFIELDS("Total Gross Mass");
                    GTxtRefClient := '';
                    if GRecShipHeader.GET("DGX Header"."Delivery slip no.") then
                        GTxtRefClient := GRecShipHeader."Your Reference";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Number > 1 then begin
                    CopyText := FormatDocument.GetCOPYText();
                    OutputNo += 1;
                end;
                GIntPageNo += 1;
                CurrReport.PAGENO := GIntPageNo;
            end;

            trigger OnPreDataItem()
            begin
                NoOfLoops := "DGX Header".COUNT * (ABS(NoOfCopies) + 1); //1 + ABS(NoOfCopies);
                CopyText := '';
                SetRange(Number, 1, NoOfLoops);

                OutputNo := 1;
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
                    field("DGX No."; "DGX Header"."DGX No.")
                    {
                        TableRelation = "DGX Header"."DGX No.";
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the DGX No. field.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        SYSTEM.GLOBALLANGUAGE(1033);
        GDecMasseBruteTotale := 0;
        CurrReport.LANGUAGE := CDULanguage.GetLanguageID('ENU');
        GCodUN := '';
        GIntPageNo := 0;
    end;

    var
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        LinNo: Integer;
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
        DimSetEntry1: Record "Dimension Set Entry";
        Continue: Boolean;
        OldDimText: Text[150];
        MoreLines: Boolean;
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        CTxtAirport: Label 'ROISSY';
        GDecMasseBruteTotale: Decimal;
        GTxtFlashPoint: Text[150];
        GTxtLimitedQty: Text[150];
        GTxtSousClasse: Text[50];
        CDULanguage: codeunit Language;
        GRecShipHeader: Record "Sales Shipment Header";
        GTxtRefClient: Text[100];
        GCodUN: Code[10];
        GIntPageNo: Integer;
}

