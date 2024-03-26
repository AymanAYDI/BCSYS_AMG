namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
pageextension 50013 GeneralJournal extends "General Journal" //39
{
    layout
    {

        //Unsupported feature: Code Modification on "Control 39.OnLookup".

        //trigger OnLookup(var Text: Text): Boolean //TODO
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        SetControlAppearanceFromBatch;
        // Set simple view when batch is changed
        SetDataForSimpleModeOnBatchChange;
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        #4..6
        */
        //end;

        //Unsupported feature: Property Deletion (ClosingDates) on ""<CurrentPostingDate>"(Control 117)".


        //Unsupported feature: Code Modification on "Control 80.OnAssistEdit".

        //trigger OnAssistEdit() //TODO whut is this ? 
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        COMMIT;
        ShowDeferralSchedule;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowDeferralSchedule;
        */
        //end;
    }
    actions
    {
        //Unsupported feature: Code Modification on ""G/L Accounts Opening balance "(Action 102).OnAction".

        //trigger OnAction() //TODO no can do 
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLAccount.SETRANGE("Account Type",GLAccount."Account Type"::Posting);
        GLAccount.SETRANGE("Income/Balance",GLAccount."Income/Balance"::"Balance Sheet");
        GLAccount.SETRANGE("Direct Posting",TRUE);
        GLAccount.SETRANGE(Blocked,FALSE);
        CreateGLAccJournalLines.SETTABLEVIEW(GLAccount);
        CreateGLAccJournalLines.InitializeRequest(DocumentTypes,TODAY,"Journal Template Name","Journal Batch Name",'');
        CreateGLAccJournalLines.USEREQUESTPAGE(FALSE);
        CreateGLAccJournalLines.SetDefaultDocumentNo(CurrentDocNo);
        COMMIT;  // Commit is required for Create Lines.
        CreateGLAccJournalLines.RUN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        COMMIT;  // Commit is required for Create Lines.
        CreateGLAccJournalLines.RUN;
        */
        //end;


        //Unsupported feature: Code Modification on ""Customers Opening balance"(Action 104).OnAction".

        //trigger OnAction()//TODO no can do 
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Customer.SETRANGE(Blocked,Customer.Blocked::" ");
        CreateCustomerJournalLines.SETTABLEVIEW(Customer);
        CreateCustomerJournalLines.InitializeRequest(DocumentTypes,TODAY,TODAY);
        CreateCustomerJournalLines.InitializeRequestTemplate("Journal Template Name","Journal Batch Name",'');
        CreateCustomerJournalLines.USEREQUESTPAGE(FALSE);
        CreateCustomerJournalLines.SetDefaultDocumentNo(CurrentDocNo);
        COMMIT;  // Commit is required for Create Lines.
        CreateCustomerJournalLines.RUN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        COMMIT;  // Commit is required for Create Lines.
        CreateCustomerJournalLines.RUN;
        */
        //end;


        //Unsupported feature: Code Modification on ""Vendors Opening balance"(Action 106).OnAction".

        //trigger OnAction()//TODO no can do 
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Vendor.SETRANGE(Blocked,Vendor.Blocked::" ");
        CreateVendorJournalLines.SETTABLEVIEW(Vendor);
        CreateVendorJournalLines.InitializeRequest(DocumentTypes,TODAY,TODAY);
        CreateVendorJournalLines.InitializeRequestTemplate("Journal Template Name","Journal Batch Name",'');
        CreateVendorJournalLines.USEREQUESTPAGE(FALSE);
        CreateVendorJournalLines.SetDefaultDocumentNo(CurrentDocNo);
        COMMIT;  // Commit is required for Create Lines.
        CreateVendorJournalLines.RUN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        COMMIT;  // Commit is required for Create Lines.
        CreateVendorJournalLines.RUN;
        */
        //end;
    }

    var
        LTextFilter: Text[80];


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord() //TODO no can do 
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    ShowShortcutDimCode(ShortcutDimCode);
    HasIncomingDocument := "Incoming Document Entry No." <> 0;
    CurrPage.IncomingDocAttachFactBox.PAGE.SetCurrentRecordID(RECORDID);
    SetUserInteractions;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    SetUserInteractions;
    */
    //end;



    //Unsupported feature: Code Modification on "SetDataForSimpleModeOnBatchChange(PROCEDURE 1106)".

    //procedure SetDataForSimpleModeOnBatchChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.SetLastViewedJournalBatchName(PAGE::"General Journal",CurrentJnlBatchName);
    // Need to set up simple page mode properties on batch change
    IF IsSimplePage THEN BEGIN
      GenJournalLine.RESET;
      GenJournalLine.SETRANGE("Journal Template Name","Journal Template Name");
      GenJournalLine.SETRANGE("Journal Batch Name",CurrentJnlBatchName);
      IsChangingDocNo := FALSE;
      IF GenJournalLine.FINDFIRST THEN
        SetDataForSimpleMode(GenJournalLine);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    #8..10
    */
    //end;


    //Unsupported feature: Code Modification on "SetDataForSimpleModeOnNewRecord(PROCEDURE 1107)".

    //procedure SetDataForSimpleModeOnNewRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // No lines shown
    IF COUNT = 0 THEN
      // If xrec."Document No." is empty that means this is the first entry for a batch
      // In this case we want to assign current doc no. to the document no. of the record
      // But if user changes the doc no. then we want to use whatever value they enter for
      // current doc no.
      IF ((xRec."Document No." = '') OR (xRec."Journal Batch Name" <> "Journal Batch Name")) AND (NOT IsChangingDocNo) THEN
        CurrentDocNo := "Document No."
      ELSE BEGIN
        "Document No." := CurrentDocNo;
        // Clear out credit / debit for empty page since these
        // might have been set if suggest balance amount is checked on the batch
        VALIDATE("Credit Amount",0);
        VALIDATE("Debit Amount",0);
      END
    ELSE
      "Document No." := CurrentDocNo;

    "Currency Code" := CurrentCurrencyCode;
    IF CurrentPostingDate <> 0D THEN
      VALIDATE("Posting Date",CurrentPostingDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
      IF (xRec."Document No." = '') AND (NOT IsChangingDocNo) THEN
    #8..21
    */
    //end;
}

