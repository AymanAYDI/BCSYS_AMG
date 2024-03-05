namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Reporting;
tableextension 50012 DocumentSendingProfile extends "Document Sending Profile" //60
{

    //Unsupported feature: Code Modification on "SendCustomerRecords(PROCEDURE 33)".

    //procedure SendCustomerRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSendCustomerRecords(ReportUsage,RecordVariant,DocName,CustomerNo,DocumentNo,CustomerFieldNo,DocumentFieldNo,Handled);
    if Handled Then
      EXIT;

    SingleCustomerSelected := IsSingleRecordSelected(RecordVariant,CustomerNo,CustomerFieldNo);

    if NOT SingleCustomerSelected Then
      if NOT DocumentSendingProfile.ProfileSelectionMethodDialog(ProfileSelectionMethod,TRUE) Then
        EXIT;

    if SingleCustomerSelected OR (ProfileSelectionMethod = ProfileSelectionMethod::ConfirmDefault) Then BEGIN
      if DocumentSendingProfile.LookupProfile(CustomerNo,TRUE,TRUE) Then
        DocumentSendingProfile.Send(ReportUsage,RecordVariant,DocumentNo,CustomerNo,DocName,CustomerFieldNo,DocumentFieldNo);
    END else BEGIN
      ShowDialog := ProfileSelectionMethod = ProfileSelectionMethod::ConfirmPerEach;
      RecRefSource.GETTABLE(RecordVariant);
      if RecRefSource.FINDSET Then
        REPEAT
          RecRefToSend := RecRefSource.DUPLICATE;
          RecRefToSend.SETRECFILTER;
          CustomerNo := RecRefToSend.FIELD(CustomerFieldNo).VALUE;
          DocumentNo := RecRefToSend.FIELD(DocumentFieldNo).VALUE;
          if DocumentSendingProfile.LookupProfile(CustomerNo,TRUE,ShowDialog) Then
            DocumentSendingProfile.Send(ReportUsage,RecRefToSend,DocumentNo,CustomerNo,DocName,CustomerFieldNo,DocumentFieldNo);
        UNTIL RecRefSource.NEXT = 0;
    END;

    OnAfterSendCustomerRecords(ReportUsage,RecordVariant,DocName,CustomerNo,DocumentNo,CustomerFieldNo,DocumentFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
    */
    //end;


    //Unsupported feature: Code Modification on "SendVendorRecords(PROCEDURE 35)".

    //procedure SendVendorRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSendVendorRecords(ReportUsage,RecordVariant,DocName,VendorNo,DocumentNo,VendorFieldNo,DocumentFieldNo,Handled);
    if Handled Then
      EXIT;

    SingleVendorSelected := IsSingleRecordSelected(RecordVariant,VendorNo,VendorFieldNo);

    if NOT SingleVendorSelected Then
      if NOT DocumentSendingProfile.ProfileSelectionMethodDialog(ProfileSelectionMethod,FALSE) Then
        EXIT;

    if SingleVendorSelected OR (ProfileSelectionMethod = ProfileSelectionMethod::ConfirmDefault) Then BEGIN
      if DocumentSendingProfile.LookUpProfileVendor(VendorNo,TRUE,TRUE) Then
        DocumentSendingProfile.SendVendor(ReportUsage,RecordVariant,DocumentNo,VendorNo,DocName,VendorFieldNo,DocumentFieldNo);
    END else BEGIN
      ShowDialog := ProfileSelectionMethod = ProfileSelectionMethod::ConfirmPerEach;
      RecRef.GETTABLE(RecordVariant);
      if RecRef.FINDSET Then
        REPEAT
          RecRef2 := RecRef.DUPLICATE;
          RecRef2.SETRECFILTER;
          VendorNo := RecRef2.FIELD(VendorFieldNo).VALUE;
          DocumentNo := RecRef2.FIELD(DocumentFieldNo).VALUE;
          if DocumentSendingProfile.LookUpProfileVendor(VendorNo,TRUE,ShowDialog) Then
            DocumentSendingProfile.SendVendor(ReportUsage,RecRef2,DocumentNo,VendorNo,DocName,VendorFieldNo,DocumentFieldNo);
        UNTIL RecRef.NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
      if DocumentSendingProfile.LookUpProfileVendor(VendorNo,TRUE,FALSE) Then  //DocumentSendingProfile.LookUpProfileVendor(VendorNo,TRUE,TRUE)
    #13..26
    */
    //end;


    //Unsupported feature: Code Modification on "SendToDisk(PROCEDURE 12)".

    //procedure SendToDisk();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Disk = Disk::No Then
      EXIT;

    OnBeforeSendToDisk(ReportUsage,RecordVariant,DocNo,DocName,ToCust,IsHandled);
    if IsHandled Then
      EXIT;

    CASE Disk OF
      Disk::PDF:
        ReportSelections.SendToDisk(ReportUsage,RecordVariant,DocNo,DocName,ToCust);
      Disk::"Electronic Document":
        BEGIN
          ElectronicDocumentFormat.SendElectronically(ServerFilePath,ClientFilePath,RecordVariant,"Disk Format");
          ReportDistributionManagement.SaveFileOnClient(ServerFilePath,ClientFilePath);
        END;
      Disk::"PDF & Electronic Document":
        BEGIN
          ElectronicDocumentFormat.SendElectronically(ServerFilePath,ClientFilePath,RecordVariant,"Disk Format");
          ReportDistributionManagement.CreateOrAppendZipFile(FileManagement,ServerFilePath,ClientFilePath,ZipPath,ClientZipFileName);
          ReportSelections.SendToZip(ReportUsage,RecordVariant,DocNo,ToCust,FileManagement);
          FileManagement.CloseZipArchive;

          ReportDistributionManagement.SaveFileOnClient(ZipPath,ClientZipFileName);
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    #8..25
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "SendToDisk(PROCEDURE 12).IsHandled(Variable 1008)".



    //Unsupported feature: Property Modification (TextConstString) on "CustomerProfileSelectionInstrTxt(Variable 1016)".

    //var
    //>>>> ORIGINAL VALUE:
    //CustomerProfileSelectionInstrTxt : ENU="Customers on the selected documents might use different document sending profiles. Choose one of the following options: ";FRA="Les clients sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CustomerProfileSelectionInstrTxt : ENU="Customers on the selected documents use different document sending profiles. Choose one of the following options: ";FRA="Les clients sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "VendorProfileSelectionInstrTxt(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //VendorProfileSelectionInstrTxt : ENU="Vendors on the selected documents might use different document sending profiles. Choose one of the following options: ";FRA="Les fournisseurs sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VendorProfileSelectionInstrTxt : ENU="Vendors on the selected documents use different document sending profiles. Choose one of the following options: ";FRA="Les fournisseurs sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.
}

