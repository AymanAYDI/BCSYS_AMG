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
                field("DGX No."; rec."DGX No.")
                {
                }
                field("DGX Type"; rec."DGX Type")
                {
                }
                field(Recipient; rec.Recipient)
                {
                }
                field("Recipient Name"; rec."Recipient Name")
                {
                }
                field("Recipient Country EN"; rec."Recipient Country EN")
                {
                }
                field("Airport of departure"; rec."Airport of departure")
                {
                }
                field("Document Date "; rec."Document Date")
                {
                }
                field("Delivery slip no."; rec."Delivery slip no.")
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
                    rec.SETFILTER("DGX No.", Rec."DGX No.");
                    if Rec."DGX Type" = Rec."DGX Type"::"Multi-modal" then
                        REPORT.RUNMODAL(50017, true, false, xRec)
                    else
                        REPORT.RUNMODAL(50018, true, false, xRec);
                    rec.SETFILTER("DGX No.", '');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GTxtBonLivraison := Rec.GETFILTER("Delivery slip no.");
        if rec.GETFILTER("Delivery slip no.") <> '' then begin
            rec."Delivery slip no." := GTxtBonLivraison;
            rec.VALIDATE("Delivery slip no.");
        end;
    end;

    var
        GTxtBonLivraison: Code[20];
}

