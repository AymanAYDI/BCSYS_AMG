namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
tableextension 50019 SalesInvoiceHeader extends "Sales Invoice Header" //112
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Payment Reference"(Field 180)".


        //Unsupported feature: Deletion (FieldCollection) on "Reversed(Field 1312)".

        field(51010; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
}

