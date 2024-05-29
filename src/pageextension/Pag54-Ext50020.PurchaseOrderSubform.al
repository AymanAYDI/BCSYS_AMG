namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;

pageextension 50020 "PurchaseOrderSubform" extends "Purchase Order Subform" //54
{
    layout
    {
        addafter("Drop Shipment")
        {
            field("Special Order Sales No."; Rec."Special Order Sales No.")
            {
                ApplicationArea = All;
            }
            field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SelectMultiItems)
        {
            action(ActRemplir)
            {
                Caption = 'Remplir Qté à recevoir';
                Image = AutofillQtyToHandle;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEB DELPHI 18/01/2019 MHR
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    GRecPurchLine.SETRANGE(Type, Rec.Type::Item); //DELPHI AUB 17.05.21 pour réception type Item uniquement
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Receive", GRecPurchLine."Outstanding Quantity");
                            if GRecPurchLine."Qty. to Receive (Base)" <> GRecPurchLine."Outstanding Qty. (Base)" then
                                GRecPurchLine.VALIDATE("Qty. to Receive (Base)", GRecPurchLine."Outstanding Qty. (Base)");
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //FIN DELPHI 18/01/2019 MHR
                end;
            }
            action(ActVider)
            {
                Caption = 'Vider Qté à recevoir';
                Image = DeleteQtyToHandle;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DEB DELPHI 18/01/2019 MHR
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Receive", 0);
                            if GRecPurchLine."Qty. to Receive (Base)" <> 0 then
                                GRecPurchLine.VALIDATE("Qty. to Receive (Base)", 0);
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //FIN DELPHI 18/01/2019 MHR
                end;
            }
            action(ActViderAFacturer)
            {
                Caption = 'Vider Qté à facturer';
                Image = DeleteQtyToHandle;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecPurchLine.RESET();
                    GRecPurchLine.SETRANGE("Document Type", GRecPurchLine."Document Type"::Order);
                    GRecPurchLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecPurchLine.FINDSET() then
                        repeat
                            GRecPurchLine.VALIDATE("Qty. to Invoice", 0);
                            if GRecPurchLine."Qty. to Invoice (Base)" <> 0 then
                                GRecPurchLine.VALIDATE("Qty. to Invoice (Base)", 0);
                            GRecPurchLine.MODIFY();
                        until GRecPurchLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //END DELPHI AUB 24/09/2019
                end;
            }
        }
    }

    var
        GRecPurchLine: Record "Purchase Line";
}

