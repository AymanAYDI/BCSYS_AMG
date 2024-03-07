namespace BCSYS.AMGALLOIS.Basic;
page 50020 Colis
{
    PageType = List;
    SourceTable = Colis;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N°"; Rec."N°")
                {
                }
                field("N° expédition"; Rec."N° expédition")
                {
                }
                field("Nature du colis"; Rec."Nature du colis")
                {
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
                Caption = 'Créer Colis';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Colis.INIT();
                    Colis."N° ligne" := 1;
                    IF Rec.GETFILTER("N° expédition") <> '' THEN BEGIN
                        Colis."N° expédition" := Rec.GETFILTER("N° expédition");
                        Colis.INSERT(TRUE);
                    END;
                end;
            }
        }
    }

    var
        Colis: Record 50010;
}

