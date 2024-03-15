namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Sales.History;
pageextension 50029 PostedSalesInvoices extends "Posted Sales Invoices" //143
{
    //TODO DeleteAllowed ,SourceTableView cannot be customized
    // DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Invoice,Navigate,Correct,Print/Send';
    layout
    {
        //TODO DrillDown cannot be customized
        // modify(Amount)
        // {
        //     DrillDown = false;
        // }

        //TODO DrillDown cannot be customized
        // modify("Amount Including VAT")
        // {
        //     DrillDown = false;
        // }
        //TODO DrillDown cannot be customized
        // modify("Remaining Amount")  field Closed
        // {
        //     DrillDown = false;
        // }
        addafter("Document Exchange Status")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
        }
    }
}

