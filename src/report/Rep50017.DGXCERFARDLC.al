namespace BCSYS.AMGALLOIS.Basic;

using System.Utilities;
using System.Globalization;
using Microsoft.Sales.History;
using Microsoft.Finance.Dimension;
using Microsoft.Utilities;
report 50017 "DGX CERFA RDLC"
{
    RDLCLayout = './src/report/rdl/DGXCERFARDLC.rdl';
    DefaultLayout = RDLC;
    UsageCategory = None;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending);
            dataitem("DGX Header"; "DGX Header")
            {
                column(NoDGX_DGXHeader; "DGX Header"."No DGX")
                {
                }
                column(TypeDGX_DGXHeader; "DGX Header"."Type DGX")
                {
                }
                column(Destinataire_DGXHeader; "DGX Header".Destinataire)
                {
                }
                column(Destinatairenom_DGXHeader; "DGX Header"."Destinataire nom")
                {
                }
                column(Destinataireadresse1_DGXHeader; "DGX Header"."Destinataire adresse 1")
                {
                }
                column(Destinataireadresse2_DGXHeader; "DGX Header"."Destinataire adresse 2")
                {
                }
                column(Destinatairecodepostal_DGXHeader; "DGX Header"."Destinataire code postal")
                {
                }
                column(Destinataireville_DGXHeader; "DGX Header"."Destinataire ville")
                {
                }
                column(DestinatairepaysEN_DGXHeader; "DGX Header"."Destinataire pays EN")
                {
                }
                column(Typedetransport_DGXHeader; "DGX Header"."Type de transport")
                {
                }
                column("Aéroportdedépart_DGXHeader"; "DGX Header"."Aeroport de depart")
                {
                }
                column(Radioactif_DGXHeader; "DGX Header".Radioactif)
                {
                }
                column(Datedocument_DGXHeader; FORMAT("DGX Header"."Date document", 0, '<Day,2><Filler Character, > <Month Text,3>. <Year4>'))
                {
                }
                column(NoBonLivraison_DGXHeader; "DGX Header"."No Bon Livraison")
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(MasseBruteTotale_DGXLines; GDecMasseBruteTotale)
                {
                }
                column(NbPages; '')
                {
                }
                column(RefClient; GTxtRefClient)
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
                }
                dataitem("DGX Lines"; "DGX Lines")
                {
                    DataItemLink = DGXNo = field("No DGX");
                    DataItemLinkReference = "DGX Header";
                    DataItemTableView = sorting(DGXNo, LineNo)
                                        order(ascending);
                    dataitem(PageLoop; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
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
                        column(Classe_DGXLines; "DGX Lines".Classe)
                        {
                        }
                        column(GroupeEmballage_DGXLines; "DGX Lines"."Groupe Emballage")
                        {
                        }
                        column(Qty_DGXLines; "DGX Lines".Qty)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(TypeofPacking_DGXLines; "DGX Lines"."Type of Packing")
                        {
                        }
                        column("Pointéclair_DGXLines"; "DGX Lines"."Point eclair")
                        {
                        }
                        column(Limitedqty_DGXLines; "DGX Lines"."Limited qty")
                        {
                        }
                        column(Massebrutekg_DGXLines; "DGX Lines"."Masse brute (kg)")
                        {
                        }
                        column(Massenettekg_DGXLines; "DGX Lines"."Masse nette (kg)")
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
                        column("Unitédemesure_DGXLines"; "DGX Lines"."Unite de mesure")
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
                        column(NoColis_DGXLines; "DGX Lines"."No Colis")
                        {
                        }
                        column(QtyColis_DGXLines; "DGX Lines"."Qty colis")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        LinNo := LineNo;
                        if "DGX Lines"."Point eclair" <> 0 then
                            GTxtFlashPoint := 'FLASH POINT : ' + FORMAT("DGX Lines"."Point eclair") + '°C'
                        else
                            GTxtFlashPoint := ' ';
                        if "DGX Lines"."Masse nette (kg)" <= "DGX Lines"."Limited qty" then
                            GTxtLimitedQty := 'LIMITED QUANTITY'
                        else
                            GTxtLimitedQty := ' ';
                        if "DGX Lines"."Sous-classe" <> '' then
                            GTxtSousClasse := '(' + "DGX Lines"."Sous-classe" + ')'
                        else
                            GTxtSousClasse := ' ';
                        GDecMasseBruteTotale += "DGX Lines"."Masse brute (kg)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        MoreLines := FIND('+');
                        while MoreLines and (ItemNo = '') do
                            MoreLines := NEXT(-1) <> 0;
                        if not MoreLines then
                            CurrReport.BREAK();
                        SETRANGE(LineNo, 0, "DGX Lines".LineNo);


                        if (GCodUN <> '') and ("DGX Lines".UN <> GCodUN) then
                            CurrReport.NEWPAGE();
                        GCodUN := "DGX Lines".UN;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "DGX Header".CALCFIELDS("Masse brute totale");
                    GTxtRefClient := '';
                    if GRecShipHeader.GET("DGX Header"."No Bon Livraison") then
                        GTxtRefClient := GRecShipHeader."Your Reference";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Number > 1 then begin
                    CopyText := FormatDocument.GetCOPYText();
                    OutputNo += 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                NoOfLoops := "DGX Header".COUNT * (ABS(NoOfCopies) + 1); //1 + ABS(NoOfCopies);
                CopyText := '';
                SETRANGE(Number, 1, NoOfLoops);

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
                    field("No DGX"; "DGX Header"."No DGX")
                    {
                        TableRelation = "DGX Header"."No DGX";
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        SYSTEM.GLOBALLANGUAGE(1033);
        GDecMasseBruteTotale := 0;
        CurrReport.LANGUAGE := GRecLanguage.GetLanguageIdOrDefault('ENU');
        GCodUN := '';
    end;

    var
        DimSetEntry1: Record "Dimension Set Entry";
        GRecShipHeader: Record "Sales Shipment Header";
        FormatDocument: Codeunit "Format Document";
        GRecLanguage: Codeunit Language;
        Continue: Boolean;
        MoreLines: Boolean;
        GCodUN: Code[10];
        GDecMasseBruteTotale: Decimal;
        LinNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CTxtAirport: Label 'ROISSY', Comment = 'FRA="ROISSY"';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        CopyText: Text[30];
        GTxtSousClasse: Text[50];
        OldDimText: Text[75];
        GTxtRefClient: Text[100];
        DimText: Text[120];
        GTxtFlashPoint: Text[150];
        GTxtLimitedQty: Text[150];
}

