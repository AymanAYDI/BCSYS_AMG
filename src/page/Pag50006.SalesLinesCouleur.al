namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Archive;
using Microsoft.Utilities;
page 50006 "Sales Lines Couleur"
{
    Caption = 'Sales Lines', Comment = 'FRA="Lignes vente"';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.', Comment = 'FRA="Réf."';
                    StyleExpr = GTxtStyleText;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Qté réceptionnée"; GDecQtyReceived)
                {
                    Caption = 'Qté reçue du Fourn.', Comment = 'FRA="Qté reçue du Fourn."';
                    DecimalPlaces = 0 : 1;
                    StyleExpr = GTxtStyleText;
                }
                field("Qté en stock"; GDecStock)
                {
                    Caption = 'Qté en stock';
                    DecimalPlaces = 0 : 1;
                    StyleExpr = GTxtStyleText;
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Fournisseur article"; Rec."Fournisseur article")
                {
                    Caption = 'Fourn.', Comment = 'FRA="Fourn."';
                    StyleExpr = GTxtStyleText;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line', Comment = 'FRA="Ligne"';
                Image = Line;
                action("Show Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Document', Comment = 'FRA="Afficher document"';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit "Page Management";
                    begin
                        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
                        PageManagement.PageRun(SalesHeader);
                    end;
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    Caption = 'Reservation Entries', Comment = 'FRA="Écritures réservation"';
                    Image = ReservationLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines', Comment = 'FRA="Lignes traçabilité"';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        GRecItem: Record Item;
        LRecPurchaseLine: Record "Purchase Line";
        LRecPurchInvLine: Record "Purch. Inv. Line";
        LRecPurchInvHeader: Record "Purch. Inv. Header";
        LRecPurchHeaderArchive: Record "Purchase Header Archive";
        LRecPurchLineArchive: Record "Purchase Line Archive";
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        //DELPHI AUB 14.06.2019 edited by AUB 24.09.2019
        GTxtStyleText := 'Standard';
        GDecQtyReceived := 0;
        GDecStock := 0;
        if Rec.Type = Rec.Type::Item then begin
            GRecItem.RESET();
            if GRecItem.GET(Rec."No.") then begin
                GRecItem.CALCFIELDS(Inventory);
                GDecStock := GRecItem.Inventory;
            end;
            /*IF Rec."Qty. to Ship" = 0 THEN BEGIN
              GTxtStyleText := 'Favorable';
              EXIT;
            END;*/
            LRecPurchaseLine.RESET();
            if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
                LRecPurchaseLine.SETRANGE("Document No.", Rec."Special Order Purchase No.");
                LRecPurchaseLine.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                if LRecPurchaseLine.FINDFIRST() then
                    GDecQtyReceived := LRecPurchaseLine."Quantity Received"
                else begin
                    // If no result, search in Purch. Invoice Lines
                    LRecPurchInvHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
                    if LRecPurchInvHeader.FindSet() then
                        repeat
                            LRecPurchInvLine.SETRANGE("Document No.", LRecPurchInvHeader."No.");
                            LRecPurchInvLine.SETRANGE(Type, Rec.Type::Item);
                            LRecPurchInvLine.SETRANGE("No.", Rec."No.");
                            LRecPurchInvLine.SETFILTER(Quantity, '<>0');
                            if LRecPurchInvLine.FIND('-') then
                                repeat
                                    GDecQtyReceived += LRecPurchInvLine.Quantity;
                                until LRecPurchInvLine.NEXT() = 0;
                        until LRecPurchInvHeader.NEXT() = 0
                    else begin
                        //DELPHI AUB search in Purchase Order Archives 03.09.2020
                        LRecPurchHeaderArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                        LRecPurchHeaderArchive.SETRANGE("No.", Rec."Special Order Purchase No.");
                        if LRecPurchHeaderArchive.FINDLAST() then begin
                            LRecPurchLineArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                            LRecPurchLineArchive.SETRANGE("Document No.", LRecPurchHeaderArchive."No.");
                            LRecPurchLineArchive.SETRANGE("Doc. No. Occurrence", LRecPurchHeaderArchive."Doc. No. Occurrence");
                            LRecPurchLineArchive.SETRANGE("Version No.", LRecPurchHeaderArchive."Version No.");
                            LRecPurchLineArchive.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                            if LRecPurchLineArchive.FINDFIRST() then
                                GDecQtyReceived += LRecPurchLineArchive."Quantity Received";
                        end;
                    end;
                end;
            end else
                //No Special Order - verify quantity in stock
                if (Rec.Quantity > GDecStock) then
                    GTxtStyleText := 'StandardAccent'
                else
                    GTxtStyleText := 'StrongAccent';
        end;
        if (GDecQtyReceived > 0) and (GDecQtyReceived >= Rec.Quantity) then
            GTxtStyleText := 'Favorable'
        else
            if GDecQtyReceived > 0 then
                GTxtStyleText := 'Ambiguous';
        //END DELPHI AUB

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        ShortcutDimCode: array[8] of Code[20];
        GDecStock: Decimal;
        GDecQtyReceived: Decimal;
        GTxtStyleText: Text[80];
}

