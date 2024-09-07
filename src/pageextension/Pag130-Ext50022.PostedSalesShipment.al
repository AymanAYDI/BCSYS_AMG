namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
pageextension 50022 PostedSalesShipment extends "Posted Sales Shipment" //130
{
    layout
    {
        addafter("Document Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Compl. cond. livraison"; Rec."Compl. cond. livraison")
            {
                ApplicationArea = All;
            }
        }
        addafter(Shipping)
        {
            part("Sous-formulaire Colis"; "Sous-formulaire Colis")
            {
                SubPageLink = "No. expedition" = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(DGX)
            {
                Caption = 'DGX', Comment = 'FRA="DGX"';
                Image = Shipment;
                RunObject = Page "Liste DGX";
                RunPageLink = "No Bon Livraison" = field("No.");
                ApplicationArea = All;
            }
            action("Etiquette colisage")
            {
                Image = Print;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RunModal(Report::"Etiquette Colisage", true, false, Rec)
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(DGX_Promoted; DGX)
            {
            }
            actionref("Etiquette colisage_Promoted"; "Etiquette colisage")
            {
            }
        }
    }
}

