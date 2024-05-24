namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.NoSeries;
tableextension 50024 SalesReceivablesSetup extends "Sales & Receivables Setup" //311
{
    fields
    {
        field(50000; "Code catégorie Carbo"; Code[20])
        {
            TableRelation = "Item Category".Code;
            Caption = 'Code categorie Carbo', Comment = 'FRA="Code catégorie Carbo"';
        }
        field(50010; "Souche No. colis"; Code[20])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Souche N° colis', Comment = 'FRA="Souche N° colis"';
        }
        field(50020; "Souche No. DGX"; Code[20])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Souche N° DGX', Comment = 'FRA="Souche N° DGX"';
        }
    }
}

