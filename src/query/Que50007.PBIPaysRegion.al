namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Address;
query 50007 "PBI_Pays_Region"
{

    elements
    {
        dataitem(Country_Region; "Country/Region")
        {
            column("Code"; "Code")
            {
            }
            column(Nom_region; Name)
            {
            }
            column(Nom_Pays; "County Name")
            {
            }
        }
    }
}

