namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
tableextension 50009 PurchaseHeader extends "Purchase Header" //38
{
    fields
    {
        field(50000; "Supplier Ack. date"; Date)
        {
            Caption = 'Supplier acknowledgment date', Comment = 'FRA="Date accusé réception fournisseur"';
            Editable = false;
        }
        field(50001; "Supplier Ack. date validation"; Boolean)
        {
            Caption = 'Validate supplier acknowledgment', Comment = 'FRA="Valider accusé réception fournisseur"';

            trigger OnValidate()
            begin
                if "Supplier Ack. date validation" then
                    Rec."Supplier Ack. date" := TODAY;
            end;
        }
    }
}

