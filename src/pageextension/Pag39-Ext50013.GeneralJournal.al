namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
pageextension 50013 GeneralJournal extends "General Journal" //39
{
    layout
    {

        //Unsupported feature: Code Modification on "Control 39.OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        SetControlAppearanceFromBatch;
        // Set simple view when batch is changed
        SetDataForSimpleModeOnBatchChange;
        CurrPage.Update(FALSE);
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

        //trigger OnAssistEdit()
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


        //Unsupported feature: Code Modification on "ShortcutDimCode3(Control 134).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(3,ShortcutDimCode[3]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,3);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(3,ShortcutDimCode[3]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode4(Control 133).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(4,ShortcutDimCode[4]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,4);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(4,ShortcutDimCode[4]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode5(Control 128).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(5,ShortcutDimCode[5]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,5);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(5,ShortcutDimCode[5]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode6(Control 121).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(6,ShortcutDimCode[6]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,6);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(6,ShortcutDimCode[6]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode7(Control 63).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(7,ShortcutDimCode[7]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,7);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(7,ShortcutDimCode[7]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode8(Control 61).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(8,ShortcutDimCode[8]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,8);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(8,ShortcutDimCode[8]);
        */
        //end;
    }
    actions
    {


        //Unsupported feature: Code Modification on ""G/L Accounts Opening balance "(Action 102).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLAccount.SetRange("Account Type",GLAccount."Account Type"::Posting);
        GLAccount.SetRange("Income/Balance",GLAccount."Income/Balance"::"Balance Sheet");
        GLAccount.SetRange("Direct Posting",TRUE);
        GLAccount.SetRange(Blocked,FALSE);
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

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Customer.SetRange(Blocked,Customer.Blocked::" ");
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

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Vendor.SetRange(Blocked,Vendor.Blocked::" ");
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

    //trigger OnAfterGetRecord()
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


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: LTextFilter)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
    IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
      EXIT;

    BalAccName := '';
    SetControlVisibility;
    SetDimensionVisibility;
    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
      SetControlAppearanceFromBatch;
      SetDataForSimpleModeOnOpen;
      EXIT;
    END;
    GenJnlManagement.TemplateSelection(PAGE::"General Journal",0,FALSE,Rec,JnlSelected);
    IF NOT JnlSelected THEN
      ERROR('');

    LastGenJnlBatch := GenJnlManagement.GetLastViewedJournalBatchName(PAGE::"General Journal");
    IF LastGenJnlBatch <> '' THEN
      CurrentJnlBatchName := LastGenJnlBatch;
    GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
    SetControlAppearanceFromBatch;

    IsSaaS := PermissionManager.SoftwareAsAService;
    SetDataForSimpleModeOnOpen;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    //DELPHI AUB
    IF Rec."Journal Template Name" = '' THEN BEGIN
    #15..17
    END;
    //END DELPHI AUB

    #18..26
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
      GenJournalLine.Reset;
      GenJournalLine.SetRange("Journal Template Name","Journal Template Name");
      GenJournalLine.SetRange("Journal Batch Name",CurrentJnlBatchName);
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
        Validate("Credit Amount",0);
        Validate("Debit Amount",0);
      END
    ELSE
      "Document No." := CurrentDocNo;

    "Currency Code" := CurrentCurrencyCode;
    IF CurrentPostingDate <> 0D THEN
      Validate("Posting Date",CurrentPostingDate);
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

