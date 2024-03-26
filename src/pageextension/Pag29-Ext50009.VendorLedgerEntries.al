namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Payables;
pageextension 50009 VendorLedgerEntries extends "Vendor Ledger Entries" //29
{
    PromotedActionCategories = 'New,Process,Report,Line,Entry';
    layout
    {
        moveafter("Document No."; "Document Date")
    }


    //Unsupported feature: Code Modification on "GetBatchRecord(PROCEDURE 1)".

    //procedure GetBatchRecord();//TODO possibly not needed
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JournalTemplateName := CreatePayment.GetTemplateName;
    JournalBatchName := CreatePayment.GetBatchNumber;

    GenJournalTemplate.GET(JournalTemplateName);
    GenJournalBatch.GET(JournalTemplateName,JournalBatchName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GenJournalTemplate.Reset;
    GenJournalTemplate.SetRange(Type,GenJournalTemplate.Type::Payments);
    GenJournalTemplate.SetRange(Recurring,FALSE);
    IF GenJournalTemplate.FINDFIRST THEN
      JournalTemplateName := GenJournalTemplate.Name;

    #2..5
    */
    //end;
}

