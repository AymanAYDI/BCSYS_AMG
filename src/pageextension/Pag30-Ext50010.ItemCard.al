namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Inventory.Item;
using BCSYS.AMGALLOIS.Basic;

pageextension 50010 "ItemCard" extends "Item Card" //30
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            Visible = true;
        }
        addafter("Description 2")
        {
            field(Historique; Rec.Historique)
            {
                Lookup = true;
                DrillDown = true;
                TableRelation = "Sales Archive"."Reference";
                Importance = Promoted;
                trigger OnLookup(var myText: Text): Boolean
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    LRecHisto.SETRANGE("Reference", Rec."No.");
                    PAGE.RUNMODAL(Page::"Historique ventes article", LRecHisto);
                end;

                trigger OnDrillDown()
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    LRecHisto.SETRANGE("Reference", Rec."No.");
                    PAGE.RUNMODAL(Page::"Historique ventes article", LRecHisto);
                end;
            }
            field("Code ONU"; Rec."Code ONU")
            {
                Lookup = false;
                DrillDown = true;
                AssistEdit = false;
                trigger OnLookup(var myText: Text): Boolean
                begin
                    CLEAR(GPageONU);
                    GPageONU.SETRECORD(GRecONU);
                    GPageONU.RUNMODAL();
                    GPageONU.GETRECORD(GRecONU);
                    if GRecONU.Code <> '' then begin
                        Rec."Code ONU" := GRecONU.Code;
                        Rec."UN version" := GRecONU.Version;
                    end;
                end;

                trigger OnDrillDown()
                begin
                    CLEAR(GPageONU);
                    GPageONU.SETRECORD(GRecONU);
                    GPageONU.RUNMODAL();
                    GPageONU.GETRECORD(GRecONU);
                    if GRecONU.Code <> '' then begin
                        Rec."Code ONU" := GRecONU.Code;
                        Rec."UN version" := GRecONU.Version;
                    end;
                end;

                trigger OnAssistEdit()
                begin
                    CLEAR(GPageONU);
                    GPageONU.SETRECORD(GRecONU);
                    GPageONU.RUNMODAL();
                    GPageONU.GETRECORD(GRecONU);
                    if GRecONU.Code <> '' then begin
                        Rec."Code ONU" := GRecONU.Code;
                        Rec."UN version" := GRecONU.Version;
                    end;
                end;
            }
            field("UN version"; Rec."UN version")
            {
                ApplicationArea = All;
                TableRelation = "ONU table".Version where(Code = field("Code ONU"));
                Visible = false;
            }
            field(Brand; Rec.Brand)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Color; Rec.Color)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Process1; Rec.Process1)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Process2; Rec.Process2)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Origine; Rec.Origine)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Item Category Code")
        {
            field("Type carbo"; Rec."Type carbo")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Direct Cost")
        {
            field("Last Date Modified Price"; Rec."Last Date Modified Price")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            //todo page spe
            // part(LPSubstitute; "Sustitutions possibles")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Substitution';
            //     SubPageLink = "No." = field("No.");
            // }
        }
    }
    actions
    {
        moveafter("T&urnover"; "Co&mments")
        addfirst(Functions)
        {
            action(Etiquette)
            {
                Promoted = true;
                PromotedIsBig = true;
                image = BarCode;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    //todo codeunit spe
                    //  LCUCodeBar: Codeunit 50000;
                    LRecArticle: Record Item;
                begin
                    if not Rec.CodeBar then
                        // LCUCodeBar.AddCodeBarAztec(Rec);
                        LRecArticle.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50015, true, true, LRecArticle);
                end;
            }
        }
        modify("CopyItem")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.VALIDATE("Unit Price");
        if (Rec."Code ONU" <> '') and (Rec."UN version" >= 0) then
            GRecONU.GET(Rec."Code ONU", Rec."UN version");
    end;

    var
        GRecONU: Record "ONU table";
        GPageONU: Page "Liste ONU";

}
