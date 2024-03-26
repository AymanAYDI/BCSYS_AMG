namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Setup;

pageextension 50035 "PurchasesPayablesSetup" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addafter("Discount Posting")
        {
            field("Purchase Invoice Start Date"; Rec."Purchase Invoice Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date début factures achats field.';
            }
        }
    }
    actions
    {

    }
}
