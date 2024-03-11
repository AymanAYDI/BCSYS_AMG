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
                field("DGX No."; Rec."DGX No.")
                {
                }
                field("DGX Type"; Rec."DGX Type")
                {
                }
                field("Delivery slip no."; Rec."Delivery slip no.")
                {
                }
                field(Recipient; Rec.Recipient)
                {
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                }
                field("Recipient Adress 1"; Rec."Recipient Adress 1")
                {
                }
                field("Recipient Adress 2"; Rec."Recipient Adress 2")
                {
                }
                field("Recipient Post Code"; Rec."Recipient Post Code")
                {
                }
                field("Recipient City"; Rec."Recipient City")
                {
                }
                field("Recipient Country EN"; Rec."Recipient Country EN")
                {
                }
                field("Airport of departure"; Rec."Airport of departure")
                {
                }
                field(Radioactive; Rec.Radioactive)
                {
                }
                field("Document Date "; Rec."Document Date")
                {
                }
            }
            part(LignesDGX; "Lignes DGX")
            {
                SubPageLink = DGXNo = FIELD("DGX No.");
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
                    IF Rec."Delivery slip no." <> '' THEN BEGIN
                        LRecDGXLines.SETFILTER(DGXNo, Rec."DGX No.");
                        LIntLineNo := 0;
                        IF LRecDGXLines.FINDLAST() THEN
                            LIntLineNo := LRecDGXLines.LineNo + 10000
                        ELSE
                            LIntLineNo := 10000;

                        //on récupère les informations à partir des lignes de l'expédition vente enregistrée
                        LRecShipLines.CALCFIELDS("Code ONU");
                        LRecShipLines.SETRANGE(Type, LRecShipLines.Type::Item);
                        LRecShipLines.SETFILTER("Document No.", Rec."Delivery slip no.");
                        LRecShipLines.SETFILTER(Quantity, '>0'); //DELPHI AUB 12.10.2021
                        LRecShipLines.SETFILTER("Code ONU", '<>%1', '');


                        IF LRecShipLines.FIND('-') THEN BEGIN
                            REPEAT
                                LRecDGXLines.RESET();
                                LRecDGXLines.LineNo := LIntLineNo;
                                LRecDGXLines.DGXNo := Rec."DGX No.";
                                LRecDGXLines.ItemNo := LRecShipLines."No.";
                                LRecItem.RESET();
                                LRecONU.RESET();
                                IF LRecItem.GET(LRecShipLines."No.") THEN BEGIN
                                    IF (LRecItem."Code ONU" <> ' ') AND LRecONU.GET(LRecItem."Code ONU", LRecItem."UN version") THEN BEGIN
                                        LRecDGXLines.UN := LRecItem."Code ONU";
                                        LRecDGXLines.Class := LRecONU.Class;
                                        LRecDGXLines."Packaging Group" := LRecONU."Packaging group";
                                        LRecDGXLines.Description := LRecONU.Description;
                                        LRecDGXLines."Sub-Class" := LRecONU."Sub-Class";
                                        LRecDGXLines."Package No." := LRecShipLines."N° Package";
                                        LRecDGXLines."Unit of measure" := LRecShipLines."Unit of Measure";
                                        IF LRecDGXHeader.GET(Rec."DGX No.") THEN BEGIN
                                            IF LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien cargo" THEN
                                                LRecDGXLines."Packing Inst" := LRecONU."Packing instr cargo"
                                            ELSE
                                                IF LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien passager" THEN
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr passager"
                                                ELSE
                                                    LRecDGXLines."Packing Inst" := '';
                                        END;
                                        //DELPHI AUB récupération du poids net du colis
                                        IF LRecColis.GET(LRecShipLines."N° Package") THEN BEGIN
                                            LRecDGXLines."Net mass (kg)" := LRecColis."Net Weight";
                                            LRecDGXLines."Gross Mass (kg)" := LRecColis."Gross Weight";
                                            LRecColis.CALCFIELDS("Nb of pieces");
                                            LRecDGXLines.Qty := LRecColis."Nb of pieces";
                                            LRecDGXLines."Qty colis" := LRecColis."Nb of pieces";
                                            LRecDGXLines."Flash point" := LRecONU."Flash Point";
                                            LRecDGXLines."Limited qty" := LRecONU."Limited quantity";
                                        END;
                                        LRecDGXLines.Qty := LRecShipLines.Quantity;
                                    END ELSE BEGIN
                                        LRecDGXLines.UN := '';
                                        LRecDGXLines.Class := '';
                                        LRecDGXLines.Description := '';
                                        LRecDGXLines."Sub-Class" := '';
                                        LRecDGXLines."Packaging Group" := LRecDGXLines."Packaging Group"::" ";
                                        LRecDGXLines."Package No." := '';
                                        LRecDGXLines."Unit of measure" := '';
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
                    Rec.SETFILTER("DGX No.", Rec."DGX No.");
                    IF Rec."DGX Type" = Rec."DGX Type"::"Multi-modal" THEN
                        REPORT.RUNMODAL(50017, TRUE, FALSE, Rec)
                    ELSE
                        REPORT.RUNMODAL(50018, TRUE, FALSE, Rec);
                    Rec.SETFILTER("DGX No.", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := Rec.GETFILTER("Delivery slip no.");
        IF Rec.GETFILTER("Delivery slip no.") <> '' THEN BEGIN
            Rec."Delivery slip no." := GTxtBonLivraison;
            Rec.VALIDATE("Delivery slip no.");
        END;
    end;

    var
        GTxtBonLivraison: Code[20];
}

