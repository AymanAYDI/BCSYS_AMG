namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Setup;
tableextension 50025 PurchasesPayablesSetup extends "Purchases & Payables Setup" //312
{
    fields
    {
        field(50000; "Date debut factures achats"; Date)
        {
            Caption = 'Date début factures achats', Comment = 'FRA="Date début factures achats"';
        }
    }
}

