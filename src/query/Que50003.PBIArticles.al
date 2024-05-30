namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
query 50003 "PBI_Articles"
{

    elements
    {
        dataitem(Item; Item)
        {
            column(Code_Article; "No.")
            {
            }
            column(Nom_Article; Description)
            {
            }
        }
    }
}

