namespace BCSYS.AMGALLOIS.Basic;
page 50020 Colis
{
    PageType = List;
    SourceTable = Colis;
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
                }
                field("N° expédition"; Rec."No. expedition")
                {
                }
                field("Nature du colis"; Rec."Nature du colis")
                {
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
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ActCreerColis)
            {
                Caption = 'Créer Colis', Comment = 'FRA="Créer Colis"';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Colis.INIT();
                    Colis."No. ligne" := 1;
                    if Rec.GETFILTER("No. expedition") <> '' then begin
                        Colis."No. expedition" := CopyStr(Rec.GETFILTER("No. expedition"), 1, MaxStrLen(Colis."No. expedition"));
                        Colis.INSERT(true);
                    end;
                end;
            }
        }
    }

    var
        Colis: Record Colisage;
}

