namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.History;
pageextension 50027 PostedPurchaseRcptSubform extends "Posted Purchase Rcpt. Subform" //137
{
    Editable = true;
    layout
    {
        addafter("Appl.-to Item Entry")
        {
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
            }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
            }
        }
    }
}

