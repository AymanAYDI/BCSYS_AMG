namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Payables;
pageextension 50031 ApplyVendorEntries extends "Apply Vendor Entries" //233
{
    layout
    {
        addafter("Document Type")
        {
            field("Document Date"; Rec."Document Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

