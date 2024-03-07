namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Payables;
pageextension 50031 ApplyVendorEntries extends "Apply Vendor Entries" //233
{
    PromotedActionCategories = 'New,Process,Report,Line,Entry';
    layout
    {
        addafter("Document Type")
        {
            field("Document Date"; Rec."Document Date")
            {
                Editable = false;
            }
        }
    }
    //todo i can't find solution line 58,914
}
