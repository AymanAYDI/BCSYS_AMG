namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Archive;

pageextension 50048 "PurchaseOrderArchiveSubform" extends "Purchase Order Archive Subform" //5168
{
    layout
    {
        addafter(ShortcutDimCode8)
        {
            field("Special Order Sales No."; Rec."Special Order Sales No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
