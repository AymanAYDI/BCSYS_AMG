namespace BCSYS.AMGALLOIS.Basic;
page 50012 "Liste DGX"
{
    CardPageID = "Fiche DGX";
    PageType = List;
    SourceTable = "DGX Header";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No DGX"; Rec."No DGX")
                {
                }
                field("Type DGX"; Rec."Type DGX")
                {
                }
                field(Destinataire; Rec.Destinataire)
                {
                }
                field("Destinataire nom"; Rec."Destinataire nom")
                {
                }
                field("Destinataire pays EN"; Rec."Destinataire pays EN")
                {
                }
                field("Aéroport de départ"; Rec."Aeroport de depart")
                {
                }
                field("Date document"; Rec."Date document")
                {
                }
                field("No Bon Livraison"; Rec."No Bon Livraison")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
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
                        REPORT.RUNMODAL(Report::"DGX CERFA RDLC", true, false, xRec)
                    else
                        REPORT.RUNMODAL(Report::"DGX IATA RDLC", true, false, xRec);
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

