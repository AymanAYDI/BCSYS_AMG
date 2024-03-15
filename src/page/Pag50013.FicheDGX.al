namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using BCSYS_AMG.BCSYS_AMG;
page 50013 "Fiche DGX"
{
    PageType = Card;
    SourceTable = "DGX Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("DGX No."; Rec."DGX No.")
                {
                    ToolTip = 'Specifies the value of the DGX No. field.';
                }
                field("DGX Type"; Rec."DGX Type")
                {
                    ToolTip = 'Specifies the value of the DGX Type field.';
                }
                field("Delivery slip no."; Rec."Delivery slip no.")
                {
                    ToolTip = 'Specifies the value of the Delivery slip no. field.';
                }
                field(Recipient; Rec.Recipient)
                {
                    ToolTip = 'Specifies the value of the Recipient field.', Comment = 'FRA="Destinataire"';
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ToolTip = 'Specifies the value of the Recipient Name field.';
                }
                field("Recipient Adress 1"; Rec."Recipient Adress 1")
                {
                    ToolTip = 'Specifies the value of the Recipient Adress 1 field.';
                }
                field("Recipient Adress 2"; Rec."Recipient Adress 2")
                {
                    ToolTip = 'Specifies the value of the Recipient Adress 2 field.';
                }
                field("Recipient Post Code"; Rec."Recipient Post Code")
                {
                    ToolTip = 'Specifies the value of the Recipient Post Code field.';
                }
                field("Recipient City"; Rec."Recipient City")
                {
                    ToolTip = 'Specifies the value of the Recipient City field.';
                }
                field("Recipient Country EN"; Rec."Recipient Country EN")
                {
                    ToolTip = 'Specifies the value of the Recipient Country EN field.';
                }
                field("Airport of departure"; Rec."Airport of departure")
                {
                    ToolTip = 'Specifies the value of the Airport of departure field.';
                }
                field(Radioactive; Rec.Radioactive)
                {
                    ToolTip = 'Specifies the value of the Radioactive field.';
                }
                field("Document Date "; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
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
                ToolTip = 'Executes the Importer lignes action.';
                trigger OnAction()
                var
                    LRecItem: Record Item;
                    LRecShipLines: Record "Sales Shipment Line";
                    LRecDGXHeader: Record "DGX Header";
                    LRecDGXLines: Record "DGX Lines";
                    LRecColis: Record Package;
                    LRecONU: Record "ONU table";
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


                        IF LRecShipLines.FIND('-') THEN
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
                                        LRecDGXLines."Package No." := LRecShipLines."Package No.";
                                        LRecDGXLines."Unit of measure" := LRecShipLines."Unit of Measure";
                                        if LRecDGXHeader.GET(Rec."DGX No.") then
                                            if LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien cargo" then
                                                LRecDGXLines."Packing Inst" := LRecONU."Packing instr cargo"
                                            else
                                                if LRecDGXHeader."DGX Type" = LRecDGXHeader."DGX Type"::"Aerien passager" then
                                                    LRecDGXLines."Packing Inst" := LRecONU."Packing instr passager"
                                                else
                                                    LRecDGXLines."Packing Inst" := '';

                                        //DELPHI AUB récupération du poids net du colis
                                        if LRecColis.GET(LRecShipLines."Package No.") then begin
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

                                LRecDGXLines."Type of Packing" := '1 FIBREBOARD BOX';
                                LRecDGXLines.INSERT();
                                COMMIT();
                                LIntLineNo += 10000;
                            UNTIL LRecShipLines.NEXT() <= 0;

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
                ToolTip = 'Executes the Imprimer action.';
                trigger OnAction()
                begin
                    Rec.SETFILTER("DGX No.", Rec."DGX No.");
                    if Rec."DGX Type" = Rec."DGX Type"::"Multi-modal" then
                        REPORT.RUNMODAL(Report::"DGX CERFA RDLC", true, false, Rec)
                    else
                        REPORT.RUNMODAL(Report::"DGX IATA RDLC", true, false, Rec);
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

