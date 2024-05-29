namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item.Substitution;

pageextension 50016 "SalesOrderSubform" extends "Sales Order Subform" //46
{
    layout
    {
        modify("Purchasing Code")
        {
            Visible = true;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                DeltaUpdateTotals();
            end;
        }
        addafter("Special Order")
        {
            field("Special Order Purchase No."; Rec."Special Order Purchase No.")
            {
                ApplicationArea = All;
            }
            field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(SalesLineDiscExists)
        {
            field(Marge; Rec.Marge)
            {
                Importance = Standard;
                Style = Strong;
                StyleExpr = true;
                ApplicationArea = All;
            }
            field(Marque; Rec.Marque)
            {
                Style = StrongAccent;
                StyleExpr = true;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
        moveafter(Marque; "Line Discount %")
        moveafter("Document No."; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
    }
    actions
    {
        addafter(SelectMultiItems)
        {
            action(ActRemplir)
            {
                ApplicationArea = All;
                Image = UntrackedQuantity;
                Caption = 'ActRemplir', Comment = 'FRA="Remplir Qté"';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", GRecSalesLine."Outstanding Quantity");
                            if GRecSalesLine."Qty. to Ship (Base)" <> GRecSalesLine."Outstanding Qty. (Base)" then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", GRecSalesLine."Outstanding Qty. (Base)");
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActViderAExpedier)
            {
                Image = DeleteQtyToHandle;
                ApplicationArea = All;
                Caption = 'ActViderAExpedier', Comment = 'FRA="Vider Qté à expédier"';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", 0);
                            if GRecSalesLine."Qty. to Ship (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
            action(ActViderAFacturer)
            {
                Image = DeleteQtyToHandle;
                ApplicationArea = All;
                Caption = 'ActViderAFacturer', Comment = 'FRA="Vider Qté à facturer"';
                trigger OnAction()
                begin
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Invoice", 0);
                            if GRecSalesLine."Qty. to Invoice (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Invoice (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                end;
            }
        }
    }
    var
        GRecSalesLine: Record "Sales Line";
}
