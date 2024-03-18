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
                ToolTip = 'Specifies the value of the No. 2 field.';
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
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Historique field.';
                trigger OnLookup(var myText: Text): Boolean
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    LRecHisto.SetRange("Reference", Rec."No.");
                    PAGE.RunModal(Page::"Historique ventes article", LRecHisto);
                end;

                trigger OnDrillDown()
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    LRecHisto.SetRange("Reference", Rec."No.");
                    PAGE.RunModal(Page::"Historique ventes article", LRecHisto);
                end;
            }
            field("Code ONU"; Rec."Code ONU")
            {
                Lookup = false;
                DrillDown = true;
                AssistEdit = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Code ONU field.';
                trigger OnLookup(var myText: Text): Boolean
                begin
                    Clear(GPageONU);
                    GPageONU.SetRecord(GRecONU);
                    GPageONU.RunModal();
                    GPageONU.GetRecord(GRecONU);
                    if GRecONU.Code <> '' then begin
                        Rec."Code ONU" := GRecONU.Code;
                        Rec."UN version" := GRecONU.Version;
                    end;
                end;

                trigger OnDrillDown()
                begin
                    Clear(GPageONU);
                    GPageONU.SetRecord(GRecONU);
                    GPageONU.RunModal();
                    GPageONU.GetRecord(GRecONU);
                    if GRecONU.Code <> '' then begin
                        Rec."Code ONU" := GRecONU.Code;
                        Rec."UN version" := GRecONU.Version;
                    end;
                end;

                trigger OnAssistEdit()
                begin
                    Clear(GPageONU);
                    GPageONU.SetRecord(GRecONU);
                    GPageONU.RunModal();
                    GPageONU.GetRecord(GRecONU);
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
                ToolTip = 'Specifies the value of the UN version field.';
            }
            field(Brand; Rec.Brand)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Brand field.';
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Grade field.';
            }
            field(Color; Rec.Color)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Color field.';
            }
            field(Process1; Rec.Process1)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Process1 field.';
            }
            field(Process2; Rec.Process2)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Process2 field.';
            }
            field(Origin; Rec.Origin)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Origin field.';
            }
        }
        addafter("Item Category Code")
        {
            field("Type carbo"; Rec."Type carbo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type carbo field.';
            }
        }
        addafter("Last Direct Cost")
        {
            field("Last Date Modified Price"; Rec."Last Date Modified Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Date Modified Price field.';
            }
        }
        addfirst(factboxes)
        {
            part(LPSubstitute; "Sustitutions possibles")
            {
                ApplicationArea = All;
                Caption = 'Substitution';
                SubPageLink = "No." = field("No.");
            }
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
                ApplicationArea = All;
                ToolTip = 'Executes the Etiquette action.';
                trigger OnAction()
                var
                    LRecArticle: Record Item;
                    LCUCodeBar: Codeunit 50000;
                begin
                    if not Rec.CodeBar then
                        LCUCodeBar.AddCodeBarAztec(Rec);
                    LRecArticle.SetRange("No.", Rec."No.");
                    REPORT.RUN(Report::"Etiquette article", true, true, LRecArticle);
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
        Rec.Validate("Unit Price");
        if (Rec."Code ONU" <> '') and (Rec."UN version" >= 0) then
            GRecONU.GET(Rec."Code ONU", Rec."UN version");
    end;

    var
        GRecONU: Record "ONU table";
        GPageONU: Page "Liste ONU";

}
