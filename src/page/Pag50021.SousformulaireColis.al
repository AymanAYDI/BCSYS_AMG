namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
page 50021 "Sous-formulaire Colis"
{
    Caption = 'Expéditions - Colis';
    PageType = ListPart;
    RefreshOnActivate = false;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = Colis;
    SourceTableView = sorting("N°")
                      order(ascending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N°"; Rec."N°")
                {
                    DrillDownPageID = ListeColisage;
                    Editable = false;
                    Enabled = false;
                }
                field("N° expédition"; Rec."N° expédition")
                {
                    TableRelation = "Sales Shipment Header"."No.";
                }
                field("Nature du colis"; Rec."Nature du colis")
                {

                }
                field("Référence Colis"; Rec."Référence Colis")
                {
                    Editable = false;
                }
                field("Désignation marchandise"; Rec."Désignation marchandise")
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
                field("Nb pièce dans le colis"; Rec."Nb pièce dans le colis")
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
                Caption = 'Visualiser les article du colis';
                Image = CreateWarehousePick;

                trigger OnAction()
                var
                    LRecColisages: Record 50010;
                    LRecColis: Record 50009;
                    LPagColisage: Page 50022;
                begin
                    CurrPage.SETSELECTIONFILTER(LRecColis);

                    if LRecColis.FINDFIRST() then begin
                        LRecColisages.SETRANGE("N°", LRecColis."N°");
                        PAGE.RUNMODAL(50022, LRecColisages);
                    end;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        LIntI: Integer;
        LRecColis: Record 50009;
        LIntNbColis: Integer;
    begin
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("N° expédition", Rec."N° expédition");
        LIntNbColis := LRecColis.COUNT - 1;
        CurrPage.UPDATE(true);
        if LRecColis.FIND('-') then
            repeat
                if LRecColis."N°" <> Rec."N°" then begin
                    LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;
        CurrPage.UPDATE(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LIntI: Integer;
        LRecColis: Record 50009;
        LIntNbColis: Integer;
    begin
        CLEAR(GRecColis);
        GRecColis.SETRANGE("N° expédition", Rec."N° expédition");
        Rec."Référence Colis" := FORMAT(GRecColis.COUNT + 1) + '/' + FORMAT(GRecColis.COUNT + 1);
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("N° expédition", Rec."N° expédition");
        LIntNbColis := LRecColis.COUNT + 1;
        if LRecColis.FIND('-') then
            repeat
                if LRecColis."N°" <> Rec."N°" then begin
                    LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;
    end;

    var
        GRecColis: Record 50009;
}

