namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
report 50005 "MAJ PriceProfit Calculation"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            column(PriceProfitCalculation; Item."Price/Profit Calculation")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Validate("Price/Profit Calculation", Item."Price/Profit Calculation"::"Price=Last Direct Cost+Profit");
                Modify();
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

