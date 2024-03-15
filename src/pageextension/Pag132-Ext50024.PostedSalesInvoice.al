namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;

pageextension 50024 "PostedSalesInvoice" extends "Posted Sales Invoice" //132
{
    //TODO cannot be customized
    // DeleteAllowed =false;
    layout
    {
        modify("External Document No.")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(CorrectInvoice)
        {
            Promoted = true;
            PromotedOnly = true;
        }
    }
}
