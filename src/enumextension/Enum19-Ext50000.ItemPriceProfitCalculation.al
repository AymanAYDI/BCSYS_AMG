namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
enumextension 50000 "ItemPriceProfitCalculation" extends "Item Price Profit Calculation" //19
{

    value(5000; "Price=Last Direct Cost+Profit") //TODO: Attention à la migration des données. Il faut changer les valeurs des options
    {
        Caption = 'Price=Last Direct Cost+Profit', Comment = 'FRA="Prix=DCA+Marge"';
    }
}
