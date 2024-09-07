namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
page 50021 "Sous-formulaire Colis"
{
    Caption = 'Expéditions - Colis', Comment = 'FRA="Expéditions - Colis"';
    PageType = ListPart;
    RefreshOnActivate = false;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = Colis;
    SourceTableView = sorting("No.")
                      order(ascending);
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N°"; Rec."No.")
                {
                    DrillDownPageID = ListeColisage;
                    Editable = false;
                    Enabled = false;
                }
                field("N° expédition"; Rec."No. expedition")
                {
                    TableRelation = "Sales Shipment Header"."No.";
                }
                field("Nature du colis"; Rec."Nature du colis")
                {
                }
                field("Référence Colis"; Rec."Reference Colis")
                {
                    Editable = false;
                }
                field("Désignation marchandise"; Rec."Designation marchandise")
                {
                }
                field("Longueur (cm)"; Rec."Longueur (cm)")
                {
                }
                field("Largeur (cm)"; Rec."Largeur (cm)")
                {
                }
                field("Hauteur (cm)"; Rec."Hauteur (cm)")
                {
                }
                field("Volume (m3)"; Rec."Volume (m3)")
                {
                }
                field("Poids net"; Rec."Poids net")
                {
                }
                field("Poids brut"; Rec."Poids brut")
                {
                }
                field("Nb pièce dans le colis"; Rec."Nb piece dans le colis")
                {
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(VoirArticle)
            {
                Caption = 'Visualiser les article du colis', Comment = 'FRA="Visualiser les article du colis"';
                Image = CreateWarehousePick;

                trigger OnAction()
                var
                    LRecColis: Record Colis;
                    LRecColisages: Record Colisage;
                begin
                    CurrPage.SETSELECTIONFILTER(LRecColis);

                    if LRecColis.FINDFIRST() then begin
                        LRecColisages.SETRANGE("No.", LRecColis."No.");
                        PAGE.RUNMODAL(Page::ListeColisage, LRecColisages);
                    end;
                end;
            }
            action("Update Colis")
            {
                ApplicationArea = Suite;
                Caption = 'Update Colis', Comment = 'FRA="Mettre à jour colis"';
                Image = Edit;
                Enabled = Rec."No. expedition" <> '';

                trigger OnAction()
                var
                    Colis: Record Colis;
                    SousformulaireColis: Page "Sous-formulaire Colis";
                begin
                    Colis.SetRange("No. expedition", Rec."No. expedition");
                    SousformulaireColis.SetTableView(Colis);
                    SousformulaireColis.Editable(true);
                    SousformulaireColis.RunModal();
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        LRecColis: Record Colis;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("No. expedition", Rec."No. expedition");
        LIntNbColis := LRecColis.COUNT - 1;
        CurrPage.UPDATE(true);//DELPHI AUB 06.07.2021
        if LRecColis.FIND('-') then
            repeat
                if LRecColis."No." <> Rec."No." then begin
                    LRecColis."Reference Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;

        //END DELPHI AUB
        CurrPage.UPDATE(false);//DELPHI AUB 06.07.2021
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LRecColis: Record Colis;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        //DELPHI AUB 15.07.2021
        CLEAR(GRecColis);
        GRecColis.SETRANGE("No. expedition", Rec."No. expedition");
        Rec."Reference Colis" := FORMAT(GRecColis.COUNT + 1) + '/' + FORMAT(GRecColis.COUNT + 1);

        //DELPHI AUB 05.07.2021
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("No. expedition", Rec."No. expedition");
        LIntNbColis := LRecColis.COUNT + 1;
        //CurrPage.UPDATE(TRUE);//DELPHI AUB 06.07.2021
        if LRecColis.FIND('-') then
            repeat
                if LRecColis."No." <> Rec."No." then begin
                    LRecColis."Reference Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;

        //END DELPHI AUB 15.07.2021
    end;

    var
        GRecColis: Record Colis;
}

