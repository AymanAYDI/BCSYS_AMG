namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Purchases.Setup;

pageextension 50035 "PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addafter("Discount Posting")
        {
            field("Date début factures achats"; Rec."Date début factures achats")
            {

            }
        }
    }
    actions
    {

    }
}
