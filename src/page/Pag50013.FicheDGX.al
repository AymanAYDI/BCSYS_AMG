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
                SubPageLink = DGXNo = field("DGX No.");
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
                    LRecItem: Record 27;
                    LRecShipLines: Record 111;
                    LRecDGXHeader: Record 50006;
                    LRecDGXLines: Record 50007;
                    LRecColis: Record 50009;
                    LRecONU: Record 50012;
                    LIntLineNo: Integer;
                begin
                    if Rec."Delivery slip no." <> '' then begin
                        LRecDGXLines.SETFILTER(DGXNo, Rec."DGX No.");
                        LIntLineNo := 0;
                        if LRecDGXLines.FINDLAST() then
                            LIntLineNo := LRecDGXLines.LineNo + 10000
                        else
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
                                if LRecItem.GET(LRecShipLines."No.") then
                                    if (LRecItem."Code ONU" <> ' ') and LRecONU.GET(LRecItem."Code ONU", LRecItem."UN version") then begin
                                        LRecDGXLines.UN := LRecItem."Code ONU";
                                        LRecDGXLines.Class := LRecONU.Class;
                                        LRecDGXLines."Packaging Group" := LRecONU."Packaging group";
                                        LRecDGXLines.Description := LRecONU.Description;
                                        LRecDGXLines."Sub-Class" := LRecONU."Sub-Class";
                                        LRecDGXLines."Package No." := LRecShipLines."N° Package";
                                        LRecDGXLines."Unit of measure" := LRecShipLines."Unit of Measure";
                                        if LRecDGXHeader.GET(Rec."DGX No.") then
                                            if LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien cargo" then
                                                LRecDGXLines."Packing Inst" := LRecONU."Packing instr cargo"
                                            else
                                                if LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien passager" then
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr passager"
                                                else
                                                    LRecDGXLines."Packing Inst" := '';
                                    END;
                                //DELPHI AUB récupération du poids net du colis
                                if LRecColis.GET(LRecShipLines."N° Package") then begin
                                    LRecDGXLines."Net mass (kg)" := LRecColis."Net Weight";
                                    LRecDGXLines."Gross Mass (kg)" := LRecColis."Gross Weight";
                                    LRecColis.CALCFIELDS("Nb of pieces");
                                    LRecDGXLines.Qty := LRecColis."Nb of pieces";
                                    LRecDGXLines."Package Qty" := LRecColis."Nb of pieces";
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

                end else
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
                    if Rec."DGX Type" = Rec."DGX Type"::"Multi-modal" then
                        REPORT.RUNMODAL(50017, true, false, Rec)
                    else
                        REPORT.RUNMODAL(50018, true, false, Rec);
                    Rec.SETFILTER("DGX No.", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := Rec.GETFILTER("Delivery slip no.");
        if Rec.GETFILTER("Delivery slip no.") <> '' then begin
            Rec."Delivery slip no." := GTxtBonLivraison;
            Rec.VALIDATE("Delivery slip no.");
        end;
    end;

    var
        GTxtBonLivraison: Code[20];
}

