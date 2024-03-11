namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.History;
tableextension 50021 PurchRcptLine extends "Purch. Rcpt. Line" //121
{
    fields
    {
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }
    }


}

