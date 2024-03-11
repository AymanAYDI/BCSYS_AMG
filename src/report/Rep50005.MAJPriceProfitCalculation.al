namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
report 50005 "MAJ PriceProfit Calculation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            column(PriceProfitCalculation; Item."Price/Profit Calculation")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VALIDATE("Price/Profit Calculation", Item."Price/Profit Calculation"::"Price=Last Direct Cost+Profit");
                MODIFY();
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

