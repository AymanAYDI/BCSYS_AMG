namespace BCSYS.AMGALLOIS.Basic;

page 50012 "Liste DGX"
{
    CardPageID = "Fiche DGX";
    PageType = List;
    SourceTable = "DGX Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("DGX No."; rec."DGX No.")
                {
                    ToolTip = 'Specifies the value of the DGX No. field.';
                }
                field("DGX Type"; rec."DGX Type")
                {
                    ToolTip = 'Specifies the value of the DGX Type field.';
                }
                field(Recipient; rec.Recipient)
                {
                    ToolTip = 'Specifies the value of the Recipient field.', Comment = 'FRA="Destinataire"';
                }
                field("Recipient Name"; rec."Recipient Name")
                {
                    ToolTip = 'Specifies the value of the Recipient Name field.';
                }
                field("Recipient Country EN"; rec."Recipient Country EN")
                {
                    ToolTip = 'Specifies the value of the Recipient Country EN field.';
                }
                field("Airport of departure"; rec."Airport of departure")
                {
                    ToolTip = 'Specifies the value of the Airport of departure field.';
                }
                field("Document Date "; rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Delivery slip no."; rec."Delivery slip no.")
                {
                    ToolTip = 'Specifies the value of the Delivery slip no. field.';
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
                ToolTip = 'Executes the Imprimer action.';
                trigger OnAction()
                begin
                    rec.SETFILTER("DGX No.", Rec."DGX No.");
                    if Rec."DGX Type" = Rec."DGX Type"::"Multi-modal" then
                        REPORT.RunModal(Report::"DGX CERFA RDLC", true, false, xRec)
                    else
                        REPORT.RunModal(Report::"DGX IATA RDLC", true, false, xRec);
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
            rec.Validate("Delivery slip no.");
        end;
    end;

    var
        GTxtBonLivraison: Code[20];
}

