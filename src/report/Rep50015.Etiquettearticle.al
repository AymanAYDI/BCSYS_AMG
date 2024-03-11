namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Inventory.Item;
report 50015 "Etiquette article"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Etiquettearticle.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            column(Item_CodeAztec; Item.CodeAZTEC)
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(Item_No; Item."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item.CALCFIELDS(CodeAZTEC);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

