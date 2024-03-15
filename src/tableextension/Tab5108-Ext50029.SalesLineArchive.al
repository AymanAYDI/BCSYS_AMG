namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Archive;
tableextension 50029 SalesLineArchive extends "Sales Line Archive" //5108
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
        //TODO Requested Delivery Date AccessByPermission
    }
    keys
    {
        key(Key50000; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
    }
}

