namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Requisition;

pageextension 50032 "ReqWorksheet" extends "Req. Worksheet" //291
{
    layout
    {
        addafter(Type)
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {
                ApplicationArea = All;
            }
            field("Nom du client"; Rec."Nom du client")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Vendor No.")
        {
            field("Nom du fournisseur"; Rec."Nom du fournisseur")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Nom du client", "Nom du fournisseur");
    end;
}
