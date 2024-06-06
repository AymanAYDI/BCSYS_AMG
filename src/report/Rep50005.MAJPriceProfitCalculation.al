namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Inventory.Item;
report 50005 "MAJ PriceProfit Calculation"
{
    ProcessingOnly = true;
    UsageCategory = None;

    dataset
    {
        dataitem(Item; Item)
        {
            column(PriceProfitCalculation; Item."Price/Profit Calculation")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //DELPHI AUB 11.06.2019 - MAJ du mode de calcul du prix de vente
                VALIDATE("Price/Profit Calculation", Item."Price/Profit Calculation"::"Price=Last Direct Cost+Profit");
                MODIFY;
            end;
        }
    }
}

