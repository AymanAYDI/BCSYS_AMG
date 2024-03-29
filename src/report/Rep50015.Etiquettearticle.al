namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
report 50015 "Etiquette article"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/Etiquettearticle.rdlc';
    ApplicationArea = All;

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

