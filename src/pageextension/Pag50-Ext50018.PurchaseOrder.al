namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;

pageextension 50018 "PurchaseOrder" extends "Purchase Order" //50
{
    layout
    {
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Rec."Requested Receipt Date" := Rec."Document Date";
                Rec.VALIDATE("Requested Receipt Date");
            end;
        }
        addafter("Due Date")
        {
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {

            }
        }
        modify("Quote No.")
        {
            Editable = true;
        }
        addafter("Vendor Shipment No.")
        {
            field("Supplier Ack. date"; rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
            {

            }
            field("Supplier Ack. date validation"; rec."Supplier Ack. date validation")
            {

            }
        }
        modify("Pay-to Address")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Address 2")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to City")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to County")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Post Code")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Country/Region Code")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Contact No.")
        {
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
        modify("Pay-to Contact")
        {
            Importance = Additional;
            Enabled = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
            Editable = Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        }
    }
    actions
    {
        modify(Vendor)
        {
            Visible = false;
        }
        addafter(Vendor)
        {
            action(Vendorspe)
            {
                ApplicationArea = Suite;
                Caption = 'Vendor';
                Enabled = Rec."Buy-from Vendor No." <> '';
                Image = Vendor;
                RunObject = Page "Vendor Card";
                RunPageLink = "No." = field("Buy-from Vendor No.");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
            }
        }
        addafter(Warehouse_GetSalesOrder)
        {
            action(ActNewCdeSpe)
            {
                Caption = 'Inject New Special Order';
                ApplicationArea = ALL;
                Promoted = true;
                PromotedIsBig = true;
                Image = CoupledOrder;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PurchHeader: Record 38;
                    DistIntegration: Codeunit 5702;
                begin
                    PurchHeader.COPY(Rec);
                    //todo prod spe
                    //DistIntegration.GetNewSpecialOrders(PurchHeader);
                    Rec := PurchHeader;
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        LRecUserSetup: Record 91;
        LCodUserID: Code[20];
    begin
        Rec."Posting Date" := 0D;
        LCodUserID := USERID();
        if LRecUserSetup.GET(LCodUserID) and (Rec."Purchaser Code" = '') then
            Rec."Purchaser Code" := LRecUserSetup."Salespers./Purch. Code";
        if Rec."No." <> '' then
            Rec.MODIFY();
        if Rec."No." <> '' then
            Rec.MODIFY();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Document Date" <> 0D then
            Rec."Requested Receipt Date" := Rec."Document Date";
    end;
    //todo check line 1420,1659
}
