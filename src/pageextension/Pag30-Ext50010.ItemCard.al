namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;

pageextension 50010 "ItemCard" extends "Item Card" //30
{
    layout
    {
        addafter("Description 2")
        {
            field(Historique; Rec.Historique)
            {
                Lookup = true;
                DrillDown = true;
                TableRelation = "Historique ventes"."Reference";
                Importance = Promoted;
                ApplicationArea = All;
                trigger OnLookup(var myText: Text): Boolean
                var
                    LRecHisto: Record "Historique ventes";
                begin
                    LRecHisto.SetRange("Reference", Rec."No.");
                    PAGE.RunModal(Page::"Historique ventes article", LRecHisto);
                end;

                trigger OnDrillDown()
                var
                    LRecHisto: Record "Historique ventes";
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
            field(Origin; Rec.Origin)
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
        addlast(content)
        {
            group("Code a bar")
            {
                Caption = 'Code à bar';
                field(CodeBar; Rec.CodeBar)
                {
                    Caption = 'Code Aztec Générer';
                    ApplicationArea = All;
                }
            }
        }
        addfirst(factboxes)
        {
            part(LPSubstitute; "Sustitutions possibles")
            {
                ApplicationArea = All;
                Caption = 'Substitution', Comment = 'FRA="Substitution"';
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addfirst(Functions)
        {
            action(Etiquette)
            {
                Promoted = true;
                PromotedIsBig = true;
                image = BarCode;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    LRecArticle: Record Item;
                begin
                    Rec.AddCodeBarAztec();
                    LRecArticle.SetRange("No.", Rec."No.");
                    REPORT.RUN(Report::"Etiquette article", true, true, LRecArticle);
                end;
            }
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
