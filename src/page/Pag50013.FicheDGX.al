namespace BCSYS.AMGALLOIS.Basic;
page 50013 "Fiche DGX"
{
    PageType = Card;
    SourceTable = "DGX Header";

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("No DGX"; Rec."No DGX")
                {
                }
                field("Type DGX"; Rec."Type DGX")
                {
                }
                field("No Bon Livraison"; Rec."No Bon Livraison")
                {
                }
                field(Destinataire; Rec.Destinataire)
                {
                }
                field("Destinataire nom"; Rec."Destinataire nom")
                {
                }
                field("Destinataire adresse 1"; Rec."Destinataire adresse 1")
                {
                }
                field("Destinataire adresse 2"; Rec."Destinataire adresse 2")
                {
                }
                field("Destinataire code postal"; Rec."Destinataire code postal")
                {
                }
                field("Destinataire ville"; Rec."Destinataire ville")
                {
                }
                field("Destinataire pays EN"; Rec."Destinataire pays EN")
                {
                }
                field("Aéroport de départ"; Rec."Aéroport de départ")
                {
                }
                field(Radioactif; Rec.Radioactif)
                {
                }
                field("Date document"; Rec."Date document")
                {
                }
            }
            part(LignesDGX; "Lignes DGX")
            {
                SubPageLink = DGXNo = FIELD("No DGX");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Importer lignes")
            {
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LRecDGXLines: Record 50007;
                    LIntLineNo: Integer;
                    LRecShipLines: Record 111;
                    LRecItem: Record 27;
                    LRecONU: Record 50012;
                    LRecColis: Record 50009;
                    LRecDGXHeader: Record 50006;
                begin
                    IF Rec."No Bon Livraison" <> '' THEN BEGIN
                        LRecDGXLines.SETFILTER(DGXNo, Rec."No DGX");
                        LIntLineNo := 0;
                        IF LRecDGXLines.FINDLAST() THEN
                            LIntLineNo := LRecDGXLines.LineNo + 10000
                        ELSE
                            LIntLineNo := 10000;

                        //on récupère les informations à partir des lignes de l'expédition vente enregistrée
                        LRecShipLines.CALCFIELDS("Code ONU");
                        LRecShipLines.SETRANGE(Type, LRecShipLines.Type::Item);
                        LRecShipLines.SETFILTER("Document No.", Rec."No Bon Livraison");
                        LRecShipLines.SETFILTER(Quantity, '>0'); //DELPHI AUB 12.10.2021
                        LRecShipLines.SETFILTER("Code ONU", '<>%1', '');


                        IF LRecShipLines.FIND('-') THEN BEGIN
                            REPEAT
                                LRecDGXLines.RESET();
                                LRecDGXLines.LineNo := LIntLineNo;
                                LRecDGXLines.DGXNo := Rec."No DGX";
                                LRecDGXLines.ItemNo := LRecShipLines."No.";
                                LRecItem.RESET();
                                LRecONU.RESET();
                                IF LRecItem.GET(LRecShipLines."No.") THEN BEGIN
                                    IF (LRecItem."Code ONU" <> ' ') AND LRecONU.GET(LRecItem."Code ONU", LRecItem."UN version") THEN BEGIN
                                        LRecDGXLines.UN := LRecItem."Code ONU";
                                        LRecDGXLines.Classe := LRecONU.Classe;
                                        LRecDGXLines."Groupe Emballage" := LRecONU."Groupe emballage";
                                        LRecDGXLines.Description := LRecONU.Description;
                                        LRecDGXLines."Sous-classe" := LRecONU."Sous-classe";
                                        LRecDGXLines."No Colis" := LRecShipLines."N° Colis";
                                        LRecDGXLines."Unité de mesure" := LRecShipLines."Unit of Measure";
                                        IF LRecDGXHeader.GET(Rec."No DGX") THEN BEGIN
                                            IF LRecDGXHeader."Type DGX" = LRecDGXHeader."Type DGX"::"Aerien cargo" THEN
                                                LRecDGXLines."Packing Inst" := LRecONU."Packing instr cargo"
                                            ELSE
                                                IF LRecDGXHeader."Type DGX" = LRecDGXHeader."Type DGX"::"Aerien passager" THEN
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr passager"
                                                ELSE
                                                    LRecDGXLines."Packing Inst" := '';
                                        END;
                                        //DELPHI AUB récupération du poids net du colis
                                        IF LRecColis.GET(LRecShipLines."N° Colis") THEN BEGIN
                                            LRecDGXLines."Masse nette (kg)" := LRecColis."Poids net";
                                            LRecDGXLines."Masse brute (kg)" := LRecColis."Poids brut";
                                            LRecColis.CALCFIELDS("Nb pièce dans le colis");
                                            LRecDGXLines.Qty := LRecColis."Nb pièce dans le colis";
                                            LRecDGXLines."Qty colis" := LRecColis."Nb pièce dans le colis";
                                            LRecDGXLines."Point éclair" := LRecONU."Flash Point";
                                            LRecDGXLines."Limited qty" := LRecONU."Limited quantity";
                                        END;
                                        LRecDGXLines.Qty := LRecShipLines.Quantity;
                                    END ELSE BEGIN
                                        LRecDGXLines.UN := '';
                                        LRecDGXLines.Classe := '';
                                        LRecDGXLines.Description := '';
                                        LRecDGXLines."Sous-classe" := '';
                                        LRecDGXLines."Groupe Emballage" := LRecDGXLines."Groupe Emballage"::" ";
                                        LRecDGXLines."No Colis" := '';
                                        LRecDGXLines."Unité de mesure" := '';
                                        LRecDGXLines."Packing Inst" := '';
                                    END;
                                END;
                                LRecDGXLines."Type of Packing" := '1 FIBREBOARD BOX';
                                LRecDGXLines.INSERT();
                                COMMIT();
                                LIntLineNo += 10000;
                            UNTIL LRecShipLines.NEXT() <= 0;
                        END;

                    END ELSE
                        MESSAGE('Le No de bon de colisage est manquant');
                end;
            }
            action(Imprimer)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.SETFILTER("No DGX", Rec."No DGX");
                    IF Rec."Type DGX" = Rec."Type DGX"::"Multi-modal" THEN
                        REPORT.RUNMODAL(50017, TRUE, FALSE, Rec)
                    ELSE
                        REPORT.RUNMODAL(50018, TRUE, FALSE, Rec);
                    Rec.SETFILTER("No DGX", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := Rec.GETFILTER("No Bon Livraison");
        IF Rec.GETFILTER("No Bon Livraison") <> '' THEN BEGIN
            Rec."No Bon Livraison" := GTxtBonLivraison;
            Rec.VALIDATE("No Bon Livraison");
        END;
    end;

    var
        GTxtBonLivraison: Code[20];
}

