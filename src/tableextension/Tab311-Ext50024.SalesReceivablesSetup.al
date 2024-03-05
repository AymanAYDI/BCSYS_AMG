namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
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
        field(50000; "Code catégorie Carbo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
        field(50010; "Souche N° colis"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AMG.COLIS';
            TableRelation = "No. Series".Code;
        }
        field(50020; "Souche N° DGX"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AMG.DGX';
            TableRelation = "No. Series".Code;
        }
    }
}

