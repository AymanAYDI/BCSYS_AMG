namespace BCSYS.AMGALLOIS.Basic;
page 50012 "Liste DGX"
{
    CardPageID = "Fiche DGX";
    PageType = List;
    SourceTable = "DGX Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No DGX"; rec."No DGX")
                {
                }
                field("Type DGX"; rec."Type DGX")
                {
                }
                field(Destinataire; rec.Destinataire)
                {
                }
                field("Destinataire nom"; rec."Destinataire nom")
                {
                }
                field("Destinataire pays EN"; rec."Destinataire pays EN")
                {
                }
                field("Aéroport de départ"; rec."Aéroport de départ")
                {
                }
                field("Date document"; rec."Date document")
                {
                }
                field("No Bon Livraison"; rec."No Bon Livraison")
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
                    rec.SETFILTER("No DGX", Rec."No DGX");
                    if Rec."Type DGX" = Rec."Type DGX"::"Multi-modal" then
                        REPORT.RUNMODAL(50017, true, false, xRec)
                    else
                        REPORT.RUNMODAL(50018, true, false, xRec);
                    rec.SETFILTER("No DGX", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := rec.GETFILTER("No Bon Livraison");
        if rec.GETFILTER("No Bon Livraison") <> '' then begin
            rec."No Bon Livraison" := GTxtBonLivraison;
            rec.VALIDATE("No Bon Livraison");
        end;
    end;

    var
        GTxtBonLivraison: Code[20];
}

