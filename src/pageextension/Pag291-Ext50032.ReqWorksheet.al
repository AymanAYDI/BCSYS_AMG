namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Inventory.Requisition;

pageextension 50032 "ReqWorksheet" extends "Req. Worksheet" //291
{
    layout
    {
        addafter(Type)
        {
            field("Sales Order No."; rec."Sales Order No.")
            {

            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {

            }
            field("Nom du client"; rec."Nom du client")
            {
                Editable = false;
            }
        }
        moveafter("Sales Order Line No."; "Sell-to Customer No.")
        addafter("Vendor No.")
        {
            field("Nom du fournisseur"; rec."Nom du fournisseur")
            {

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Nom du client", "Nom du fournisseur");
    end;
}
