namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
tableextension 50026 ItemTemplate extends "Item Template" //1301
{
    fields
    {
        modify("Price/Profit Calculation")
        {
            OptionCaption = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship,Last Direct Cost+Profit';
            //Unsupported feature: Property Modification (OptionString) on ""Price/Profit Calculation"(Field 19)".

        }
        field(50001; Fournisseur; Code[20])
        {
            TableRelation = Vendor."No.";
            DataClassification = ToBeClassified;
            Description = 'Spe AMG';
        } //TODO
    }

}