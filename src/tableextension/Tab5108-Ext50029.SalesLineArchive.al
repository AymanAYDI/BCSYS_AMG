namespace BCSYS.AMGALLOIS.Basic;
tableextension 50029 SalesLineArchive extends "Sales Line Archive" //5108
{
    fields
    {
        modify("Document Type")
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        }
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".

    }
    keys
    {

        //Unsupported feature: Property Insertion (SumIndexFields) on ""Document Type,Document No.,Doc. No. Occurrence,Version No.,Line No."(Key)".

    }
}

