namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Reporting;
tableextension 50013 ReportSelections extends "Report Selections" //77
{
    fields
    {
        modify(Usage)
        {
            OptionCaption = 'S.Quote,S.Order,S.Invoice,S.Cr.Memo,S.Test,P.Quote,P.Order,P.Invoice,P.Cr.Memo,P.Receipt,P.Ret.Shpt.,P.Test,B.Stmt,B.Recon.Test,B.Check,Reminder,Fin.Charge,Rem.Test,F.C.Test,Prod.Order,S.Blanket,P.Blanket,M1,M2,M3,M4,Inv1,Inv2,Inv3,SM.Quote,SM.Order,SM.Invoice,SM.Credit Memo,SM.Contract Quote,SM.Contract,SM.Test,S.Return,P.Return,S.Shipment,S.Ret.Rcpt.,S.Work Order,Invt.Period Test,SM.Shipment,S.Test Prepmt.,P.Test Prepmt.,S.Arch.Quote,S.Arch.Order,P.Arch.Quote,P.Arch.Order,S.Arch.Return,P.Arch.Return,Asm.Order,P.Asm.Order,S.Order Pick Instruction,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,P.V.Remit.,C.Statement,V.Remittance,JQ,S.Invoice Draft,Pro Forma S. Invoice,S.Arch.Blanket,P.Arch.Blanket,Phys.Invt.Order Test,Phys.Invt.Order,P.Phys.Invt.Order,Phys.Invt.Rec.,P.Phys.Invt.Rec.,S.Proforma';

            //Unsupported feature: Property Modification (OptionString) on "Usage(Field 1)".

        }
    }

    //Unsupported feature: Code Modification on "PrintDocumentsWithCheckGUIYesNoCommon(PROCEDURE 65)".

    //procedure PrintDocumentsWithCheckGUIYesNoCommon();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetReportLayout(RecordVariant);

    RecRef.GETTABLE(RecordVariant);
    GetUniqueAccountNos(TempNameValueBuffer,RecRef,AccountNoFieldNo);

    SelectTempReportSelectionsToPrint(TempReportSelections,TempNameValueBuffer,WithCheck,ReportUsage,TableNo);
    OnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint(
      RecordVariant,TempReportSelections,TempNameValueBuffer,WithCheck,ReportUsage,TableNo);
    if TempReportSelections.FINDSET Then
      REPEAT
        if TempReportSelections."Custom Report Layout Code" <> '' Then
          ReportLayoutSelection.SetTempLayoutSelected(TempReportSelections."Custom Report Layout Code")
        else
          ReportLayoutSelection.SetTempLayoutSelected('');

        TempNameValueBuffer.FINDSET;
        AccountNoFilter := GetAccountNoFilterForCustomReportLayout(TempReportSelections,TempNameValueBuffer,TableNo);
        GetFilteredRecordRef(RecRefToPrint,RecRef,AccountNoFieldNo,AccountNoFilter);
        RecVarToPrint := RecRefToPrint;

        IsHandled := FALSE;
        OnBeforePrintDocument(TempReportSelections,IsGUI,RecVarToPrint,IsHandled);
        if NOT IsHandled Then
          REPORT.RUNMODAL(TempReportSelections."Report ID",IsGUI,FALSE,RecVarToPrint);

        OnAfterPrintDocument(TempReportSelections,IsGUI,RecVarToPrint);

        ReportLayoutSelection.SetTempLayoutSelected('');
      UNTIL TempReportSelections.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6

    #9..20
        REPORT.RUNMODAL(TempReportSelections."Report ID",IsGUI,FALSE,RecVarToPrint);
    #27..29
    */
    //end;


    //Unsupported feature: Code Modification on "GetHtmlReport(PROCEDURE 29)".

    //procedure GetHtmlReport();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeGetHtmlReport(DocumentContent,ReportUsage,RecordVariant,CustNo,IsHandled);
    if IsHandled Then
      EXIT;

    FindPrintUsage(ReportUsage,CustNo,TempBodyReportSelections);

    ServerEmailBodyFilePath :=
      SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Custom Report Layout Code");

    DocumentContent := '';
    if ServerEmailBodyFilePath <> '' Then
      DocumentContent := FileManagement.GetFileContent(ServerEmailBodyFilePath);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ServerEmailBodyFilePath := '';
    #4..8
    */
    //end;


    //Unsupported feature: Code Modification on "GetEmailBodyCustomText(PROCEDURE 327)".

    //procedure GetEmailBodyCustomText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServerEmailBodyFilePath := '';

    OnBeforeGetEmailBodyCustomer;

    if CustEmailAddress = '' Then
      CustEmailAddress := GetEmailAddressIgnoringLayout(ReportUsage,RecordVariant,CustNo);

    if NOT FindEmailBodyUsage(ReportUsage,CustNo,TempBodyReportSelections) Then BEGIN
      IsHandled := FALSE;
      OnGetEmailBodyCustomerTextOnAfterNotFindEmailBodyUsage(
        ReportUsage,RecordVariant,CustNo,TempBodyReportSelections,IsHandled);
      if IsHandled Then
        EXIT(TRUE);
      EXIT(FALSE);
    END;

    CASE "Email Body Layout Type" OF
      "Email Body Layout Type"::"Custom Report Layout":
        ServerEmailBodyFilePath :=
          SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Email Body Layout Code");
      "Email Body Layout Type"::"HTML Layout":
        ServerEmailBodyFilePath :=
          O365HTMLTemplMgt.CreateEmailBodyFromReportSelections(Rec,RecordVariant,CustEmailAddress,EmailBodyText);
    END;

    CustEmailAddress := GetEmailAddress(ReportUsage,RecordVariant,CustNo,TempBodyReportSelections);

    OnAfterGetEmailBodyCustomer(CustEmailAddress,ServerEmailBodyFilePath);

    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    if NOT FindEmailBodyUsage(ReportUsage,CustNo,TempBodyReportSelections) Then
      EXIT(FALSE);
    #16..30
    */
    //end;


    //Unsupported feature: Code Modification on "GetEmailAddress(PROCEDURE 60)".

    //procedure GetEmailAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecordRef.GETTABLE(RecordVariant);
    if NOT RecordRef.IsEmpty Then
      if DataTypeManagement.FindFieldByName(RecordRef,FieldRef,'No.') Then BEGIN
        DocumentNo := FieldRef.VALUE;
        EmailAddress := GetDocumentEmailAddress(DocumentNo,ReportUsage);
        if EmailAddress <> '' Then
          EXIT(EmailAddress);
      END;

    if NOT TempBodyReportSelections.IsEmpty Then BEGIN
      EmailAddress :=
        FindEmailAddressForEmailLayout(TempBodyReportSelections."Email Body Layout Code",CustNo,ReportUsage,DATABASE::Customer);
      if EmailAddress <> '' Then
        EXIT(EmailAddress);
    END;

    if NOT RecordRef.IsEmpty Then
      if IsSalesDocument(RecordRef) Then
        if DataTypeManagement.FindFieldByName(RecordRef,FieldRef,'Sell-to E-Mail') Then BEGIN
          EmailAddress := FieldRef.VALUE;
          if EmailAddress <> '' Then
            EXIT(EmailAddress);
        END;

    EmailAddress := GetCustEmailAddress(CustNo,ReportUsage);
    if EmailAddress <> '' Then
      EXIT(EmailAddress);

    EXIT(EmailAddress);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    //DELPHI AUB 23.07.2020
    // récupération de l'adresse mail du contact indiqué dans l'entête du document CV/Devis, CA, FV
    GRecSalesHeader.Reset;
    GRecSalesHeader.SetRange("No.",DocumentNo);
    GRecSalesInvoiceHeader.Reset;

    if GRecSalesHeader.FINDFIRST Then BEGIN
      if (GRecContact.Get(GRecSalesHeader."Sell-to Contact No.")) AND (GRecContact."E-Mail" <> '') Then
        EmailAddress:= GRecContact."E-Mail"
      else
        EmailAddress := GetCustEmailAddress(CustNo,ReportUsage);
    END else if GRecSalesInvoiceHeader.Get(DocumentNo) Then BEGIN
      if (GRecContact.Get(GRecSalesInvoiceHeader."Sell-to Contact No.")) AND (GRecContact."E-Mail" <> '') Then
        EmailAddress:= GRecContact."E-Mail"
      else
        EmailAddress := GetCustEmailAddress(CustNo,ReportUsage);
    END else
      EmailAddress := GetCustEmailAddress(CustNo,ReportUsage);

    //END DELPHI AUB
    //EmailAddress := GetCustEmailAddress(CustNo,ReportUsage);
    #26..28
    #17..24
    EXIT(EmailAddress);
    */
    //end;


    //Unsupported feature: Code Modification on "GetEmailBodyVendor(PROCEDURE 40)".

    //procedure GetEmailBodyVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServerEmailBodyFilePath := '';

    OnBeforeGetEmailBodyVendor;

    VendorEmailAddress := GetVendorEmailAddress(VendorNo,RecordVariant,ReportUsage);

    if NOT FindEmailBodyUsageVendor(ReportUsage,VendorNo,TempBodyReportSelections) Then BEGIN
      IsHandled := FALSE;
      OnGetEmailBodyVendorTextOnAfterNotFindEmailBodyUsage(
        ReportUsage,RecordVariant,VendorNo,TempBodyReportSelections,IsHandled);
      if IsHandled Then
        EXIT(TRUE);
      EXIT(FALSE);
    END;

    ServerEmailBodyFilePath :=
      SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Email Body Layout Code");

    FoundVendorEmailAddress :=
      FindEmailAddressForEmailLayout(TempBodyReportSelections."Email Body Layout Code",VendorNo,ReportUsage,DATABASE::Vendor);
    if FoundVendorEmailAddress <> '' Then
      VendorEmailAddress := FoundVendorEmailAddress;

    OnAfterGetEmailBodyVendor(VendorEmailAddress,ServerEmailBodyFilePath);

    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    if NOT FindEmailBodyUsageVendor(ReportUsage,VendorNo,TempBodyReportSelections) Then
      EXIT(FALSE);
    #15..26
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: JobQueueEntry) (VariableCollection) on "SendEmailToCust(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "SendEmailToCust(PROCEDURE 9)".

    //procedure SendEmailToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSendEmailToCust(ReportUsage,RecordVariant,DocNo,DocName,ShowDialog,CustNo,Handled);
    if Handled Then
      EXIT;

    RecRef.GETTABLE(RecordVariant);

    if GraphMail.IsEnabled AND GraphMail.HasConfiguration Then BEGIN
      if O365DocumentSentHistory.NewInProgressFromRecRef(RecRef) Then BEGIN
        O365DocumentSentHistory.SetStatusAsFailed;
        UpdateDocumentSentHistory := TRUE;
      END;

      if SendEmailToCustDirectly(ReportUsage,RecordVariant,DocNo,DocName,ShowDialog,CustNo) AND UpdateDocumentSentHistory Then
        O365DocumentSentHistory.SetStatusAsSuccessfullyFinished;

      EXIT;
    END;

    if ShowDialog OR
       (NOT SMTPMail.IsEnabled) OR
       (GetEmailAddressIgnoringLayout(ReportUsage,RecordVariant,CustNo) = '') OR
       OfficeMgt.IsAvailable
    Then BEGIN
      SendEmailToCustDirectly(ReportUsage,RecordVariant,DocNo,DocName,TRUE,CustNo);
      EXIT;
    END;

    RecRef.GETTABLE(RecordVariant);
    if RecordsCanBeSent(RecRef) Then
      EnqueueMailingJob(RecRef.RECORDID,STRSUBSTNO('%1|%2|%3|%4|',ReportUsage,DocNo,DocName,CustNo),DocName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..28
    if RecordsCanBeSent(RecRef) Then BEGIN
      JobQueueEntry.INIT;
      JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
      JobQueueEntry."Object ID to Run" := CODEUNIT::"Document-Mailing";
      JobQueueEntry."Maximum No. of Attempts to Run" := 3;
      JobQueueEntry."Record ID to Process" := RecRef.RECORDID;
      JobQueueEntry."Parameter String" := STRSUBSTNO('%1|%2|%3|%4|',ReportUsage,DocNo,DocName,CustNo);
      JobQueueEntry.Description := COPYSTR(DocName,1,MAXSTRLEN(JobQueueEntry.Description));
      CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue",JobQueueEntry);
    END;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: JobQueueEntry) (VariableCollection) on "SendEmailToVendor(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "SendEmailToVendor(PROCEDURE 34)".

    //procedure SendEmailToVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSendEmailToVendor(ReportUsage,RecordVariant,DocNo,DocName,ShowDialog,VendorNo,Handled);
    if Handled Then
      EXIT;

    RecRef.GETTABLE(RecordVariant);

    if GraphMail.IsEnabled AND GraphMail.HasConfiguration Then BEGIN
      if O365DocumentSentHistory.NewInProgressFromRecRef(RecRef) Then BEGIN
        O365DocumentSentHistory.SetStatusAsFailed;
        UpdateDocumentSentHistory := TRUE;
      END;

      if SendEmailToVendorDirectly(ReportUsage,RecordVariant,DocNo,DocName,ShowDialog,VendorNo) AND UpdateDocumentSentHistory Then
        O365DocumentSentHistory.SetStatusAsSuccessfullyFinished;

      EXIT;
    END;

    VendorEmail := GetVendorEmailAddress(VendorNo,RecordVariant,ReportUsage);
    if ShowDialog OR NOT SMTPMail.IsEnabled OR (VendorEmail = '') OR OfficeMgt.IsAvailable Then BEGIN
      SendEmailToVendorDirectly(ReportUsage,RecordVariant,DocNo,DocName,TRUE,VendorNo);
      EXIT;
    END;

    EnqueueMailingJob(RecRef.RECORDID,STRSUBSTNO('%1|%2|%3|%4|%5',ReportUsage,DocNo,DocName,VendorNo,'Vendor'),DocName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19

    #20..24
    JobQueueEntry.INIT;
    JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
    JobQueueEntry."Object ID to Run" := CODEUNIT::"Document-Mailing";
    JobQueueEntry."Maximum No. of Attempts to Run" := 3;
    JobQueueEntry."Record ID to Process" := RecRef.RECORDID;
    JobQueueEntry."Parameter String" := STRSUBSTNO('%1|%2|%3|%4|%5',ReportUsage,DocNo,DocName,VendorNo,'Vendor');
    JobQueueEntry.Description := COPYSTR(DocName,1,MAXSTRLEN(JobQueueEntry.Description));
    CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue",JobQueueEntry);
    */
    //end;


    //Unsupported feature: Code Modification on "SendEmailToVendorDirectly(PROCEDURE 37)".

    //procedure SendEmailToVendorDirectly();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetReportLayout(RecordVariant);
    BINDSUBSCRIPTION(MailManagement);
    FoundBody := GetEmailBodyVendor(ServerEmailBodyFilePath,ReportUsage,RecordVariant,VendorNo,EmailAddress);
    UNBINDSUBSCRIPTION(MailManagement);
    FoundAttachment := FindEmailAttachmentUsageVendor(ReportUsage,VendorNo,TempAttachReportSelections);

    CustomReportSelection.SetRange("Source Type",DATABASE::Vendor);
    CustomReportSelection.SetRange("Source No.",VendorNo);
    EXIT(SendEmailDirectly(
        ReportUsage,RecordVariant,DocNo,DocName,FoundBody,FoundAttachment,ServerEmailBodyFilePath,EmailAddress,ShowDialog,
        TempAttachReportSelections,CustomReportSelection));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //DELPHI AUB 23.07.2020
    GRecPurchaseHeader.Reset;
    GRecPurchaseHeader.SetRange("No.",DocNo);

    if GRecPurchaseHeader.FINDFIRST Then BEGIN
      if (GRecContact.Get(GRecPurchaseHeader."Buy-from Contact sNo.")) AND (GRecContact."E-Mail" <> '') Then
        EmailAddress := GRecContact."E-Mail";
    END;
    DocName := 'Commande Achat ';
    //END DELPHI AUB

    #7..11
    */
    //end;


    //Unsupported feature: Code Modification on "SendEmailDirectly(PROCEDURE 50)".

    //procedure SendEmailDirectly();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AllEmailsWereSuccessful := TRUE;

    ShowNoBodyNoAttachmentError(ReportUsage,FoundBody,FoundAttachment);

    if FoundBody AND NOT FoundAttachment Then
      AllEmailsWereSuccessful :=
        DocumentMailing.EmailFile('','',ServerEmailBodyFilePath,DocNo,EmailAddress,DocName,NOT ShowDialog,ReportUsage);

    if FoundAttachment Then BEGIN
      if ReportUsage = Usage::JQ Then BEGIN
        Usage := ReportUsage;
        CustomReportSelection.SETFILTER(Usage,GETFILTER(Usage));
        if CustomReportSelection.FINDFIRST Then
          if CustomReportSelection."Send To Email" <> '' Then
            DefaultEmailAddress := CustomReportSelection."Send To Email";
      END;

      OnSendEmailDirectlyOnBeforeSendFiles(
        ReportUsage,RecordVariant,DefaultEmailAddress,TempAttachReportSelections,CustomReportSelection);
      WITH TempAttachReportSelections DO BEGIN
        OfficeAttachmentManager.IncrementCount(COUNT - 1);
        REPEAT
          EmailAddress := COPYSTR(
              GetNextEmailAddressFromCustomReportSelection(CustomReportSelection,DefaultEmailAddress,Usage,Sequence),
              1,MAXSTRLEN(EmailAddress));
          ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
          AllEmailsWereSuccessful := AllEmailsWereSuccessful AND DocumentMailing.EmailFile(
              ServerAttachmentFilePath,
              '',
              ServerEmailBodyFilePath,
              DocNo,
              EmailAddress,
              DocName,
              NOT ShowDialog,
              ReportUsage);
        UNTIL NEXT = 0;
      END;
    END;

    OnAfterSendEmailDirectly(ReportUsage,RecordVariant,AllEmailsWereSuccessful);
    EXIT(AllEmailsWereSuccessful);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    #20..41
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: LDelphiText) (VariableCollection) on "SaveReportAsHTML(PROCEDURE 15)".


    //Unsupported feature: Variable Insertion (Variable: LDelphiReportId) (VariableCollection) on "SaveReportAsHTML(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "SaveReportAsHTML(PROCEDURE 15)".

    //procedure SaveReportAsHTML();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSetReportLayout(RecordVariant);
    FilePath := COPYSTR(FileMgt.ServerTempFileName('html'),1,250);

    ReportLayoutSelection.SetTempLayoutSelected(LayoutCode);
    REPORT.SAVEASHTML(ReportID,FilePath,RecordVariant);
    ReportLayoutSelection.SetTempLayoutSelected('');

    COMMIT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //DELPHI AUB;
    LDelphiReportId := FORMAT(ReportID);
    if LDelphiReportId = '1304' Then
      LDelphiText := REPORT.RUNREQUESTPAGE(ReportID);
    //END DELPHI AUB 31.07.2020
    #5..8
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustomReportSelection(PROCEDURE 23)".

    //procedure GetCustomReportSelection();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustomReportSelection.SetRange("Source Type",TableNo);
    CustomReportSelection.SetRange("Source No.",AccountNo);
    if CustomReportSelection.IsEmpty Then
      EXIT(FALSE);

    CustomReportSelection.SETFILTER("Use for Email Attachment",GETFILTER("Use for Email Attachment"));
    CustomReportSelection.SETFILTER("Use for Email Body",GETFILTER("Use for Email Body"));

    OnAfterGetCustomReportSelection(CustomReportSelection,AccountNo,TableNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    */
    //end;

    [Scope('Internal')]
    procedure GetEmailBodyInPdf(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var CustEmailAddress: Text[250]): Boolean
    var
        TempBodyReportSelections: Record "77" temporary;
    begin
        ServerEmailBodyFilePath := '';

        CustEmailAddress := GetEmailAddressIgnoringLayout(ReportUsage, RecordVariant, CustNo);

        if not FindEmailBodyUsage(ReportUsage, CustNo, TempBodyReportSelections) then
            exit(false);

        ServerEmailBodyFilePath :=
          SaveReportAsPDF(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Email Body Layout Code");

        CustEmailAddress := GetEmailAddress(ReportUsage, RecordVariant, CustNo, TempBodyReportSelections);

        exit(true);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "PrintDocumentsWithCheckGUIYesNoCommon(PROCEDURE 65).IsHandled(Variable 1010)".


    //Unsupported feature: Property Modification (Name) on "GetHtmlReport(PROCEDURE 29).DocumentContent(Parameter 1001)".


    //Unsupported feature: Property Insertion (Length) on "GetHtmlReport(PROCEDURE 29).DocumentContent(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetHtmlReport(PROCEDURE 29).ServerEmailBodyFilePath(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "GetHtmlReport(PROCEDURE 29).IsHandled(Variable 1006)".


    //Unsupported feature: Deletion (VariableCollection) on "GetEmailBodyCustomText(PROCEDURE 327).IsHandled(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "GetEmailBodyVendor(PROCEDURE 40).IsHandled(Variable 1006)".


    var
        "---- DELPHISOFT ----": Integer;
        GRecSalesHeader: Record "36";
        GRecContact: Record "5050";
        GRecSalesInvoiceHeader: Record "112";
        GRecPurchaseHeader: Record "38";
}

