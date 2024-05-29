namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
page 50013 "Fiche DGX"
{
    PageType = Card;
    SourceTable = "DGX Header";
    UsageCategory = None;

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
                field("Aéroport de départ"; Rec."Aeroport de depart")
                {
                }
                field(Radioactif; Rec.Radioactif)
                {
                }
                field("Date document"; Rec."Date document")
                {
                }
            }
            part("Lignes DGX"; "Lignes DGX")
            {
                SubPageLink = DGXNo = field("No DGX");
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
                    LRecColis: Record Colis;
                    LRecDGXHeader: Record "DGX Header";
                    LRecDGXLines: Record "DGX Lines";
                    LRecItem: Record Item;
                    LRecONU: Record "ONU table";
                    LRecShipLines: Record "Sales Shipment Line";
                    LIntLineNo: Integer;
                begin
                    if Rec."No Bon Livraison" <> '' then begin
                        LRecDGXLines.SETFILTER(DGXNo, Rec."No DGX");
                        LIntLineNo := 0;
                        if LRecDGXLines.FINDLAST() then
                            LIntLineNo := LRecDGXLines.LineNo + 10000
                        else
                            LIntLineNo := 10000;

                        //on récupère les informations à partir des lignes de l'expédition vente enregistrée
                        LRecShipLines.CALCFIELDS("Code ONU");
                        LRecShipLines.SETRANGE(Type, LRecShipLines.Type::Item);
                        LRecShipLines.SETFILTER("Document No.", Rec."No Bon Livraison");
                        LRecShipLines.SETFILTER(Quantity, '>0'); //DELPHI AUB 12.10.2021
                        LRecShipLines.SETFILTER("Code ONU", '<>%1', '');


                        if LRecShipLines.FIND('-') then
                            repeat
                                LRecDGXLines.RESET();
                                LRecDGXLines.LineNo := LIntLineNo;
                                LRecDGXLines.DGXNo := Rec."No DGX";
                                LRecDGXLines.ItemNo := LRecShipLines."No.";
                                LRecItem.RESET();
                                LRecONU.RESET();
                                if LRecItem.GET(LRecShipLines."No.") then
                                    if (LRecItem."Code ONU" <> ' ') and LRecONU.GET(LRecItem."Code ONU", LRecItem."UN version") then begin
                                        LRecDGXLines.UN := LRecItem."Code ONU";
                                        LRecDGXLines.Classe := LRecONU.Classe;
                                        LRecDGXLines."Groupe Emballage" := LRecONU."Groupe emballage";
                                        LRecDGXLines.Description := LRecONU.Description;
                                        LRecDGXLines."Sous-classe" := LRecONU."Sous-classe";
                                        LRecDGXLines."No Colis" := LRecShipLines."No. Colis";
                                        LRecDGXLines."Unite de mesure" := LRecShipLines."Unit of Measure";
                                        if LRecDGXHeader.GET(Rec."No DGX") then
                                            case LRecDGXHeader."Type DGX" of
                                                LRecDGXHeader."Type DGX"::"Aerien cargo":
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr cargo";
                                                LRecDGXHeader."Type DGX"::"Aerien passager":
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr passager";
                                                else
                                                    LRecDGXLines."Packing Inst" := '';
                                            end;
                                        //DELPHI AUB récupération du poids net du colis
                                        if LRecColis.GET(LRecShipLines."No. Colis") then begin
                                            LRecDGXLines."Masse nette (kg)" := LRecColis."Poids net";
                                            LRecDGXLines."Masse brute (kg)" := LRecColis."Poids brut";
                                            LRecColis.CALCFIELDS("Nb piece dans le colis");
                                            LRecDGXLines.Qty := LRecColis."Nb piece dans le colis";
                                            LRecDGXLines."Qty colis" := LRecColis."Nb piece dans le colis";
                                            LRecDGXLines."Point eclair" := LRecONU."Flash Point";
                                            LRecDGXLines."Limited qty" := LRecONU."Limited quantity";
                                        end;
                                        LRecDGXLines.Qty := LRecShipLines.Quantity;
                                    end else begin
                                        LRecDGXLines.UN := '';
                                        LRecDGXLines.Classe := '';
                                        LRecDGXLines.Description := '';
                                        LRecDGXLines."Sous-classe" := '';
                                        LRecDGXLines."Groupe Emballage" := LRecDGXLines."Groupe Emballage"::" ";
                                        LRecDGXLines."No Colis" := '';
                                        LRecDGXLines."Unite de mesure" := '';
                                        LRecDGXLines."Packing Inst" := '';
                                    end;
                                LRecDGXLines."Type of Packing" := '1 FIBREBOARD BOX';
                                LRecDGXLines.INSERT();
                                COMMIT();
                                LIntLineNo += 10000;
                            until LRecShipLines.NEXT() <= 0;

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
                    Rec.SETFILTER("No DGX", Rec."No DGX");
                    if Rec."Type DGX" = Rec."Type DGX"::"Multi-modal" then
                        REPORT.RUNMODAL(Report::"DGX CERFA RDLC", true, false, Rec)
                    else
                        REPORT.RUNMODAL(Report::"DGX IATA RDLC", true, false, Rec);
                    Rec.SETFILTER("No DGX", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := CopyStr(Rec.GETFILTER("No Bon Livraison"), 1, MaxStrLen(GTxtBonLivraison));
        if Rec.GETFILTER("No Bon Livraison") <> '' then begin
            Rec."No Bon Livraison" := GTxtBonLivraison;
            Rec.VALIDATE("No Bon Livraison");
        end;
    end;

    var
        GTxtBonLivraison: Code[20];
}

