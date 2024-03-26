namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.NoSeries;
tableextension 50024 SalesReceivablesSetup extends "Sales & Receivables Setup" //311
{
    fields
    {
        modify("Blanket Order Nos.")
        {
            Caption = 'Blanket Order Nos.';
        }
        modify("Archive Blanket Orders")
        {
            Caption = 'Archive Blanket Orders';
        }
        modify("Freight G/L Acc. No.")
        {
            Caption = 'Freight G/L Acc. No.';
        }
        field(50000; "Category Code Carbo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
            Caption = 'Category Code Carbo', Comment = 'Category Code Carbo';
        }
        field(50010; "Package Serie No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
            Caption = 'Package Serie No.', Comment = 'Package Serie No.';
        }
        field(50020; "DGX Serie No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
            Caption = 'DGX Serie No.', Comment = 'DGX Serie No.';
        }
    }
}

