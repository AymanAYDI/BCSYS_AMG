namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Setup;
tableextension 50025 PurchasesPayablesSetup extends "Purchases & Payables Setup" //312
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
        field(50000; "Purchase Invoice Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Lower accounting date limit for displaying purchase invoices';
            Caption = 'Purchase Invoice Start Date', Comment = 'Purchase Invoice Start Date';
        }
    }
}

