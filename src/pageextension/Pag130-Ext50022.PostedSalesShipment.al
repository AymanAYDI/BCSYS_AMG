namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
pageextension 50022 PostedSalesShipment extends "Posted Sales Shipment" //130
{
    PromotedActionCategories = 'New,Process,Report,Print/Send,Shipment';

    layout
    {
        addafter("Document Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
        }
        addafter("Shipment Method Code")
        {
            field("Compl. cond. livraison"; Rec."Compl. cond. livraison")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Additional terms of delivery field.';
            }
        }
        addafter("Shipment Date")
        {
            part("Sous-formulaire Package"; "Sous-formulaire Package")
            {
                SubPageLink = "Shipping No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
        // modify(SalesShipmLines)
        // {
        //     UpdatePropagation = Both;
        // }
        modify("Shipping Agent Code")
        {
            Editable = true;
        }
        modify("Shipping Agent Service Code")
        {
            Editable = true;
        }
        modify("Package Tracking No.")
        {
            Editable = true;
        }
    }
    actions
    {
        modify("Update Document")
        {
            Visible = false;
        }
        addafter("&Navigate")
        {
            action(DGX)
            {
                Caption = 'DGX';
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Liste DGX";
                RunPageLink = "Delivery slip no." = field("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the DGX action.';
            }
            action("Etiquette colisage")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Etiquette colisage action.';
                trigger OnAction()
                begin
                    //DELPHI AUB 23.04.2021
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RunModal(Report::"Etiquette Packaging", true, false, Rec)
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"Shipment Header - Edit", Rec);
        exit(false);
    end;
}

