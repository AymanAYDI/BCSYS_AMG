namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
using System.Security.User;

pageextension 50018 "PurchaseOrder" extends "Purchase Order" //50
{
    layout
    {
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Rec."Requested Receipt Date" := Rec."Document Date";
                Rec.Validate("Requested Receipt Date");
            end;
        }
        addafter("Due Date")
        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Quote No.")
        {
            Editable = true;
        }
        addafter("Vendor Shipment No.")
        {
            field("Supplier Ack. date"; Rec."Supplier Ack. date")
            {
                ApplicationArea = All;
            }
            field("Supplier Ack. date validation"; Rec."Supplier Ack. date validation")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(Action186)
        {
            action(ActNewCdeSpe)
            {
                Caption = 'Inject New Special Order', Comment = 'FRA="Injection nouvelles commandes spéciales"';
                ApplicationArea = ALL;
                Promoted = true;
                PromotedIsBig = true;
                Image = CoupledOrder;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    AMG_Functions: Codeunit "AMG_Functions";
                begin
                    PurchHeader.COPY(Rec);
                    AMG_Functions.GetNewSpecialOrders(PurchHeader);
                    Rec := PurchHeader;
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        LRecUserSetup: Record "User Setup";
        LCodUserID: Code[50];
    begin
        Rec."Posting Date" := 0D;
        LCodUserID := CopyStr(USERID(), 1, MaxStrLen(LCodUserID));
        if LRecUserSetup.GET(LCodUserID) and (Rec."Purchaser Code" = '') then
            Rec."Purchaser Code" := LRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.Modify();
        if Rec."No." <> '' then
            Rec.Modify();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Document Date" <> 0D then
            Rec."Requested Receipt Date" := Rec."Document Date";
    end;
}
