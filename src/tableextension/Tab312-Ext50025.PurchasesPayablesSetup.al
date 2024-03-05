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
        field(50000; "Date début factures achats"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Limite inférieure de date de comptabilisation pour affichage des factures achats';
        }
    }
}

