namespace BCSYS.AMGALLOIS.Basic;

using System.Utilities;
using System.Globalization;
using Microsoft.Utilities;
using Microsoft.Finance.Dimension;
report 50018 "DGX IATA RDLC"
{
    RDLCLayout = './src/report/rdl/DGXIATARDLC.rdl';
    DefaultLayout = RDLC;
    EnableExternalImages = true;
    PreviewMode = PrintLayout;
    WordMergeDataItem = CopyLoop;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending);
            dataitem("DGX Header"; "DGX Header")
            {
                RequestFilterFields = "No DGX";
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
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
                    column(Datedocument_DGXHeader; FORMAT("DGX Header"."Date document", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                        AutoFormatExpression = FORMAT("DGX Header"."Date document", 0, '<Day,2>/<Month,2>/<Year4>');
                    }
                    column(NoBonLivraison_DGXHeader; "DGX Header"."No Bon Livraison")
                    {
                    }
                    column(OutputNo; OutputNo)
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
                }
                dataitem("DGX Lines"; "DGX Lines")
                {
                    DataItemLink = DGXNo = field("No DGX");
                    DataItemLinkReference = "DGX Header";
                    DataItemTableView = sorting(DGXNo, LineNo)
                                        order(ascending);
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
                    column(SousClasse_DGXLines; GTxtSousClasse)
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

                    trigger OnAfterGetRecord()
                    begin
                        LinNo := LineNo;

                        GTxtSousClasse := '';
                        if "DGX Lines"."Sous-classe" <> '' then
                            GTxtSousClasse := '(' + "DGX Lines"."Sous-classe" + ')';
                    end;

                    trigger OnPreDataItem()
                    begin
                        MoreLines := FIND('+');
                        while MoreLines and (ItemNo = '') do
                            MoreLines := NEXT(-1) <> 0;
                        if not MoreLines then
                            CurrReport.BREAK();
                        SETRANGE(LineNo, 0, "DGX Lines".LineNo);
                    end;
                }
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
            }
        }
    }

    trigger OnInitReport()
    begin
        CurrReport.LANGUAGE := GRecLanguage.GetLanguageIdOrDefault('ENU');
    end;

    var
        DimSetEntry1: Record "Dimension Set Entry";
        FormatDocument: Codeunit "Format Document";
        GRecLanguage: Codeunit Language;
        Continue: Boolean;
        MoreLines: Boolean;
        LinNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CTxtAirport: Label 'ROISSY', Comment = 'FRA="ROISSY"';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        GTxtSousClasse: Text[20];
        CopyText: Text[30];
        OldDimText: Text[75];
        DimText: Text[120];
}

