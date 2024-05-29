namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Setup;

pageextension 50035 "PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addafter("Discount Posting")
        {
            field("Date debut factures achats"; Rec."Date debut factures achats")
            {
                ApplicationArea = All;
            }
        }
    }
}
