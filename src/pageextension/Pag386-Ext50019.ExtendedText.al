namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.ExtendedText;

pageextension 50019 "ExtendedText" extends "Extended Text" //386
{
    actions
    {
        addfirst(processing)
        {
            action(ActDecocher)
            {
                Caption = 'Décocher tout sauf Devis';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Sales Quote" := true;
                    Rec."Sales Invoice" := false;
                    Rec."Sales Order" := false;
                    Rec."Sales Credit Memo" := false;
                    Rec."Purchase Quote" := false;
                    Rec."Purchase Invoice" := false;
                    Rec."Purchase Order" := false;
                    Rec."Purchase Credit Memo" := false;
                    Rec.Reminder := false;
                    Rec."Finance Charge Memo" := false;
                    Rec."Sales Blanket Order" := false;
                    Rec."Purchase Blanket Order" := false;
                    Rec."Prepmt. Sales Invoice" := false;
                    Rec."Prepmt. Sales Credit Memo" := false;
                    Rec."Prepmt. Purchase Invoice" := false;
                    Rec."Prepmt. Purchase Credit Memo" := false;
                    Rec."Service Order" := false;
                    Rec."Service Quote" := false;
                    Rec."Service Invoice" := false;
                    Rec."Service Credit Memo" := false;
                    Rec."Sales Return Order" := false;
                    Rec."Purchase Return Order" := false;
                    Rec.MODIFY();
                end;
            }
        }
    }

}
