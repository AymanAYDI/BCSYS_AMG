namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;

pageextension 50050 "ItemInvoicingFactBox" extends "Item Invoicing FactBox" //9089
{
    layout
    {
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
    }
}
