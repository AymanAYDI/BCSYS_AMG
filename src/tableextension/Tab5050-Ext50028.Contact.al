namespace BCSYS.AMGALLOIS.Basic;
tableextension 50028 Contact extends Contact //5050
{
    fields
    {
        modify("Company Name")
        {
            TableRelation = Contact where(Type = const(Company));
        }

        //Unsupported feature: Code Modification on "City(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        OnAfterValidateCity(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;


        //Unsupported feature: Code Modification on ""Post Code"(Field 91).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);

        OnAfterValidatePostCode(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;


        //Unsupported feature: Code Modification on ""E-Mail"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "E-Mail" = '' Then
          EXIT;
        MailManagement.CheckValidEmailAddresses("E-Mail");
        if ("Search E-Mail" = UPPERCASE(xRec."E-Mail")) OR ("Search E-Mail" = '') Then
          "Search E-Mail" := "E-Mail";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        MailManagement.ValidateEmailAddressField("E-Mail");
        if ("Search E-Mail" = UPPERCASE(xRec."E-Mail")) OR ("Search E-Mail" = '') Then
          "Search E-Mail" := "E-Mail";
        */
        //end;
        field(50000; "Holding Company"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'AECTRA';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RMSetup.Get;

    if "No." = '' Then BEGIN
      RMSetup.TESTFIELD("Contact Nos.");
      NoSeriesMgt.InitSeries(RMSetup."Contact Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;

    if NOT SkipDefaults Then BEGIN
      if "Salesperson Code" = '' Then BEGIN
        "Salesperson Code" := RMSetup."Default Salesperson Code";
        SetDefaultSalesperson;
      END;
      if "Territory Code" = '' Then
        "Territory Code" := RMSetup."Default Territory Code";
      if "Country/Region Code" = '' Then
        "Country/Region Code" := RMSetup."Default Country/Region Code";
      if "Language Code" = '' Then
        "Language Code" := RMSetup."Default Language Code";
      if "Correspondence Type" = "Correspondence Type"::" " Then
        "Correspondence Type" := RMSetup."Default Correspondence Type";
      if "Salutation Code" = '' Then
        if Type = Type::Company Then
          "Salutation Code" := RMSetup."Def. Company Salutation Code"
        else
          "Salutation Code" := RMSetup."Default Person Salutation Code";
      OnAfterSetDefaults(Rec,RMSetup);
    END;

    TypeChange;
    SetLastDateTimeModified;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..25
    #27..30
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify(PROCEDURE 4)".

    //procedure OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetLastDateTimeModified;

    if "No." <> '' Then
      if IsUpdateNeeded Then
        UpdateCustVendBank.RUN(Rec);

    if Type = Type::Company Then BEGIN
      RMSetup.Get;
      Cont.Reset;
      Cont.SETCURRENTKEY("Company No.");
      Cont.SetRange("Company No.","No.");
      Cont.SetRange(Type,Type::Person);
      Cont.SETFILTER("No.",'<>%1',"No.");
      if Cont.FIND('-') Then
        REPEAT
          ContChanged := FALSE;
          OldCont := Cont;
          if Name <> xRec.Name Then BEGIN
            Cont."Company Name" := Name;
            ContChanged := TRUE;
          END;
          if RMSetup."Inherit Salesperson Code" AND
             (xRec."Salesperson Code" <> "Salesperson Code") AND
             (xRec."Salesperson Code" = Cont."Salesperson Code")
          Then BEGIN
            Cont."Salesperson Code" := "Salesperson Code";
            ContChanged := TRUE;
          END;
          if RMSetup."Inherit Territory Code" AND
             (xRec."Territory Code" <> "Territory Code") AND
             (xRec."Territory Code" = Cont."Territory Code")
          Then BEGIN
            Cont."Territory Code" := "Territory Code";
            ContChanged := TRUE;
          END;
          if RMSetup."Inherit Country/Region Code" AND
             (xRec."Country/Region Code" <> "Country/Region Code") AND
             (xRec."Country/Region Code" = Cont."Country/Region Code")
          Then BEGIN
            Cont."Country/Region Code" := "Country/Region Code";
            ContChanged := TRUE;
          END;
          if RMSetup."Inherit Language Code" AND
             (xRec."Language Code" <> "Language Code") AND
             (xRec."Language Code" = Cont."Language Code")
          Then BEGIN
            Cont."Language Code" := "Language Code";
            ContChanged := TRUE;
          END;
          if RMSetup."Inherit Address Details" Then
            if xRec.IdenticalAddress(Cont) Then BEGIN
              if xRec.Address <> Address Then BEGIN
                Cont.Address := Address;
                ContChanged := TRUE;
              END;
              if xRec."Address 2" <> "Address 2" Then BEGIN
                Cont."Address 2" := "Address 2";
                ContChanged := TRUE;
              END;
              if xRec."Post Code" <> "Post Code" Then BEGIN
                Cont."Post Code" := "Post Code";
                ContChanged := TRUE;
              END;
              if xRec.City <> City Then BEGIN
                Cont.City := City;
                ContChanged := TRUE;
              END;
              if xRec.County <> County Then BEGIN
                Cont.County := County;
                ContChanged := TRUE;
              END;
              OnAfterSyncAddress(Cont,Rec,ContChanged);
            END;
          if RMSetup."Inherit Communication Details" Then BEGIN
            if (xRec."Phone No." <> "Phone No.") AND (xRec."Phone No." = Cont."Phone No.") Then BEGIN
              Cont."Phone No." := "Phone No.";
              ContChanged := TRUE;
            END;
            if (xRec."Telex No." <> "Telex No.") AND (xRec."Telex No." = Cont."Telex No.") Then BEGIN
              Cont."Telex No." := "Telex No.";
              ContChanged := TRUE;
            END;
            if (xRec."Fax No." <> "Fax No.") AND (xRec."Fax No." = Cont."Fax No.") Then BEGIN
              Cont."Fax No." := "Fax No.";
              ContChanged := TRUE;
            END;
            if (xRec."Telex Answer Back" <> "Telex Answer Back") AND (xRec."Telex Answer Back" = Cont."Telex Answer Back") Then BEGIN
              Cont."Telex Answer Back" := "Telex Answer Back";
              ContChanged := TRUE;
            END;
            if (xRec."E-Mail" <> "E-Mail") AND (xRec."E-Mail" = Cont."E-Mail") Then BEGIN
              Cont.VALIDATE("E-Mail","E-Mail");
              ContChanged := TRUE;
            END;
            if (xRec."Home Page" <> "Home Page") AND (xRec."Home Page" = Cont."Home Page") Then BEGIN
              Cont."Home Page" := "Home Page";
              ContChanged := TRUE;
            END;
            if (xRec."Extension No." <> "Extension No.") AND (xRec."Extension No." = Cont."Extension No.") Then BEGIN
              Cont."Extension No." := "Extension No.";
              ContChanged := TRUE;
            END;
            if (xRec."Mobile Phone No." <> "Mobile Phone No.") AND (xRec."Mobile Phone No." = Cont."Mobile Phone No.") Then BEGIN
              Cont."Mobile Phone No." := "Mobile Phone No.";
              ContChanged := TRUE;
            END;
            if (xRec.Pager <> Pager) AND (xRec.Pager = Cont.Pager) Then BEGIN
              Cont.Pager := Pager;
              ContChanged := TRUE;
            END;
          END;

          OnBeforeApplyCompanyChangeToPerson(Cont,Rec,xRec,ContChanged);
          if ContChanged Then BEGIN
            Cont.OnModify(OldCont);
            Cont.MODIFY;
          END;
        UNTIL Cont.NEXT = 0;

      IsDuplicateCheckNeeded :=
        (Name <> xRec.Name) OR
        ("Name 2" <> xRec."Name 2") OR
        (Address <> xRec.Address) OR
        ("Address 2" <> xRec."Address 2") OR
        (City <> xRec.City) OR
        ("Post Code" <> xRec."Post Code") OR
        ("VAT Registration No." <> xRec."VAT Registration No.") OR
        ("Phone No." <> xRec."Phone No.");

      OnBeforeDuplicateCheck(Rec,xRec,IsDuplicateCheckNeeded);

      if IsDuplicateCheckNeeded Then
        CheckDupl;
    END;

    OnAfterOnModify(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..71
    #73..134
    */
    //end;


    //Unsupported feature: Code Modification on "TypeChange(PROCEDURE 1)".

    //procedure TypeChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RMSetup.Get;

    if Type <> xRec.Type Then BEGIN
      InteractLogEntry.LOCKTABLE;
      Cont.LOCKTABLE;
      InteractLogEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
      InteractLogEntry.SetRange("Contact Company No.","Company No.");
      InteractLogEntry.SetRange("Contact No.","No.");
      if InteractLogEntry.FINDFIRST Then
        Error(Text003,FieldCaption(Type));
      Task.SetRange("Contact Company No.","Company No.");
      Task.SetRange("Contact No.","No.");
      if NOT Task.IsEmpty Then
        Error(CannotChangeWithOpenTasksErr,FieldCaption(Type));
      Opp.SetRange("Contact Company No.","Company No.");
      Opp.SetRange("Contact No.","No.");
      if NOT Opp.IsEmpty Then
        Error(Text006,FieldCaption(Type));
    END;

    CASE Type OF
      Type::Company:
        BEGIN
          if Type <> xRec.Type Then BEGIN
            TESTFIELD("Organizational Level Code",'');
            TESTFIELD("No. of Job Responsibilities",0);
          END;
          "First Name" := '';
          "Middle Name" := '';
          Surname := '';
          "Job Title" := '';
          "Company No." := "No.";
          "Company Name" := Name;
          "Salutation Code" := RMSetup."Def. Company Salutation Code";
        END;
      Type::Person:
        BEGIN
          CampaignTargetGrMgt.DeleteContfromTargetGr(InteractLogEntry);
          Cont.Reset;
          Cont.SETCURRENTKEY("Company No.");
          Cont.SetRange("Company No.","No.");
          Cont.SetRange(Type,Type::Person);
          if Cont.FINDFIRST Then
            Error(Text007,FieldCaption(Type));
          if Type <> xRec.Type Then BEGIN
            CALCFIELDS("No. of Business Relations","No. of Industry Groups");
            TESTFIELD("No. of Business Relations",0);
            TESTFIELD("No. of Industry Groups",0);
            TESTFIELD("Currency Code",'');
            TESTFIELD("VAT Registration No.",'');
          END;
          if "Company No." = "No." Then BEGIN
            "Company No." := '';
            "Company Name" := '';
            "Salutation Code" := RMSetup."Default Person Salutation Code";
            NameBreakdown;
          END;
        END;
    END;
    OnAfterSetTypeForContact(Rec);
    VALIDATE("Lookup Contact No.");

    if Cont.Get("No.") Then BEGIN
      if Type = Type::Company Then
        CheckDupl
      else
        DuplMgt.RemoveContIndex(Rec,FALSE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..59
    #61..68
    */
    //end;


    //Unsupported feature: Code Modification on "CreateCustomer(PROCEDURE 3)".

    //procedure CreateCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    CheckIfPrivacyBlockedGeneric;
    RMSetup.Get;
    RMSetup.TESTFIELD("Bus. Rel. Code for Customers");

    if CustomerTemplate <> '' Then
      if CustTemplate.Get(CustomerTemplate) Then;

    CLEAR(Cust);
    Cust.SetInsertFromContact(TRUE);
    Cust."Contact Type" := Type;
    OnBeforeCustomerInsert(Cust,CustomerTemplate,Rec);
    Cust.INSERT(TRUE);
    Cust.SetInsertFromContact(FALSE);

    ContBusRel."Contact No." := "No.";
    ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Customers";
    ContBusRel."Link to Table" := ContBusRel."Link to Table"::Customer;
    ContBusRel."No." := Cust."No.";
    ContBusRel.INSERT(TRUE);

    UpdateCustVendBank.UpdateCustomer(Rec,ContBusRel);

    Cust.Get(ContBusRel."No.");
    if Type = Type::Company Then
      Cust.VALIDATE(Name,"Company Name");

    OnCreateCustomerOnBeforeCustomerModify(Cust,Rec);
    Cust.MODIFY;

    if CustTemplate.Code <> '' Then BEGIN
      if "Territory Code" = '' Then
        Cust."Territory Code" := CustTemplate."Territory Code"
      else
        Cust."Territory Code" := "Territory Code";
      if "Currency Code" = '' Then
        Cust."Currency Code" := CustTemplate."Currency Code"
      else
        Cust."Currency Code" := "Currency Code";
      if "Country/Region Code" = '' Then
        Cust."Country/Region Code" := CustTemplate."Country/Region Code"
      else
        Cust."Country/Region Code" := "Country/Region Code";
      Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
      Cust."Customer Price Group" := CustTemplate."Customer Price Group";
      if CustTemplate."Invoice Disc. Code" <> '' Then
        Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
      Cust."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
      Cust."Allow Line Disc." := CustTemplate."Allow Line Disc.";
      Cust."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
      Cust."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
      Cust."Payment Terms Code" := CustTemplate."Payment Terms Code";
      Cust."Payment Method Code" := CustTemplate."Payment Method Code";
      Cust."Prices Including VAT" := CustTemplate."Prices Including VAT";
      Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
      Cust.UpdateReferencedIds;
      OnCreateCustomerOnTransferFieldsFromTemplate(Cust,CustTemplate);
      Cust.MODIFY;

      DefaultDim.SetRange("Table ID",DATABASE::"Customer Template");
      DefaultDim.SetRange("No.",CustTemplate.Code);
      if DefaultDim.FIND('-') Then
        REPEAT
          CLEAR(DefaultDim2);
          DefaultDim2.INIT;
          DefaultDim2.VALIDATE("Table ID",DATABASE::Customer);
          DefaultDim2."No." := Cust."No.";
          DefaultDim2.VALIDATE("Dimension Code",DefaultDim."Dimension Code");
          DefaultDim2.VALIDATE("Dimension Value Code",DefaultDim."Dimension Value Code");
          DefaultDim2."Value Posting" := DefaultDim."Value Posting";
          DefaultDim2.INSERT(TRUE);
        UNTIL DefaultDim.NEXT = 0;
    END;

    OnCreateCustomerOnBeforeUpdateQuotes(Cust,Rec);

    UpdateQuotes(Cust,CustomerTemplate);
    CampaignMgt.ConverttoCustomer(Rec,Cust);
    if OfficeMgt.IsAvailable Then
      PAGE.RUN(PAGE::"Customer Card",Cust)
    else
      if NOT HideValidationDialog Then
        MESSAGE(RelatedRecordIsCreatedMsg,Cust.TABLECAPTION);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    OnBeforeCustomerInsert(Cust,CustomerTemplate);
    #13..74
    UpdateQuotes(Cust);
    #78..83
    */
    //end;


    //Unsupported feature: Code Modification on "CreateVendor(PROCEDURE 7)".

    //procedure CreateVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Vendor);
    CheckIfPrivacyBlockedGeneric;
    CheckCompanyNo;
    RMSetup.Get;
    RMSetup.TESTFIELD("Bus. Rel. Code for Vendors");

    CLEAR(Vend);
    Vend.SetInsertFromContact(TRUE);
    OnBeforeVendorInsert(Vend);
    Vend.INSERT(TRUE);
    Vend.SetInsertFromContact(FALSE);

    if Type = Type::Company Then
      ContComp := Rec
    else
      ContComp.Get("Company No.");

    ContBusRel."Contact No." := ContComp."No.";
    ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Vendors";
    ContBusRel."Link to Table" := ContBusRel."Link to Table"::Vendor;
    ContBusRel."No." := Vend."No.";
    ContBusRel.INSERT(TRUE);

    OnAfterVendorInsert(Vend,Rec);

    UpdateCustVendBank.UpdateVendor(ContComp,ContBusRel);

    if OfficeMgt.IsAvailable Then
      PAGE.RUN(PAGE::"Vendor Card",Vend)
    else
      if NOT HideValidationDialog Then
        MESSAGE(RelatedRecordIsCreatedMsg,Vend.TABLECAPTION);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Vendor);
    CheckIfPrivacyBlockedGeneric;
    TESTFIELD("Company No.");
    #4..32
    */
    //end;


    //Unsupported feature: Code Modification on "CreateCustomerLink(PROCEDURE 5)".

    //procedure CreateCustomerLink();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    CheckIfPrivacyBlockedGeneric;
    RMSetup.Get;
    RMSetup.TESTFIELD("Bus. Rel. Code for Customers");
    CreateLink(
      PAGE::"Customer Link",
      RMSetup."Bus. Rel. Code for Customers",
      ContBusRel."Link to Table"::Customer);

    ContBusRel.SETCURRENTKEY("Link to Table","No.");
    ContBusRel.SetRange("Link to Table",ContBusRel."Link to Table"::Customer);
    ContBusRel.SetRange("Contact No.","Company No.");
    if ContBusRel.FINDFIRST Then
      if Cust.Get(ContBusRel."No.") Then
        UpdateQuotes(Cust,'');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
        UpdateQuotes(Cust);
    */
    //end;


    //Unsupported feature: Code Modification on "IdenticalAddress(PROCEDURE 16)".

    //procedure IdenticalAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsIdentical :=
      (Address = Cont.Address) AND
      ("Address 2" = Cont."Address 2") AND
      ("Post Code" = Cont."Post Code") AND
      (City = Cont.City);

    OnAfterIdenticalAddress(Cont,Rec,IsIdentical);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EXIT(
    #2..4
      (City = Cont.City))
    */
    //end;


    //Unsupported feature: Code Modification on "CalculatedName(PROCEDURE 14)".

    //procedure CalculatedName();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "First Name" <> '' Then
      NewName92 := "First Name";
    if "Middle Name" <> '' Then
      NewName92 := NewName92 + ' ' + "Middle Name";
    if Surname <> '' Then
      NewName92 := NewName92 + ' ' + Surname;

    NewName92 := DELCHR(NewName92,'<',' ');

    OnAfterCalculatedName(Rec,NewName92);
    NewName := COPYSTR(NewName92,1,MAXSTRLEN(NewName));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    NewName := COPYSTR(NewName92,1,MAXSTRLEN(NewName));
    */
    //end;


    //Unsupported feature: Code Modification on "FindCustomerTemplate(PROCEDURE 23)".

    //procedure FindCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeFindCustomerTemplate(Rec,CustTemplateCode,IsHandled);
    if IsHandled Then
      EXIT(CustTemplateCode);

    CustTemplate.Reset;
    CustTemplate.SetRange("Territory Code","Territory Code");
    CustTemplate.SetRange("Country/Region Code","Country/Region Code");
    CustTemplate.SetRange("Contact Type",Type);
    if ContCompany.Get("Company No.") Then
      CustTemplate.SetRange("Currency Code",ContCompany."Currency Code");

    if CustTemplate.COUNT = 1 Then BEGIN
      CustTemplate.FINDFIRST;
      EXIT(CustTemplate.Code);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..16
    */
    //end;


    //Unsupported feature: Code Modification on "ChooseCustomerTemplate(PROCEDURE 27)".

    //procedure ChooseCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeChooseCustomerTemplate(Rec,CustTemplateCode,IsHandled);
    if IsHandled Then
      EXIT(CustTemplateCode);

    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    ContBusRel.Reset;
    ContBusRel.SetRange("Contact No.","No.");
    ContBusRel.SetRange("Link to Table",ContBusRel."Link to Table"::Customer);
    if ContBusRel.FINDFIRST Then
      Error(
        Text019,
        TABLECAPTION,"No.",ContBusRel.TABLECAPTION,ContBusRel."Link to Table",ContBusRel."No.");

    if CONFIRM(CreateCustomerFromContactQst,TRUE) Then BEGIN
      CustTemplate.SetRange("Contact Type",Type);
      if PAGE.RUNMODAL(0,CustTemplate) = ACTION::LookupOK Then
        EXIT(CustTemplate.Code);

      Error(Text022);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..21
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateQuotes(PROCEDURE 29)".

    //procedure UpdateQuotes();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Company No." <> '' Then
      Cont.SetRange("Company No.","Company No.")
    else
      Cont.SetRange("No.","No.");

    if Cont.FINDSET Then
      REPEAT
        SalesHeader.Reset;
        SalesHeader.SetRange("Sell-to Customer No.",'');
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::Quote);
        SalesHeader.SetRange("Sell-to Contact No.",Cont."No.");
        if SalesHeader.FINDSET Then
          REPEAT
            SalesHeader2.Get(SalesHeader."Document Type",SalesHeader."No.");
            SalesHeader2."Sell-to Customer No." := Customer."No.";
            SalesHeader2."Sell-to Customer Name" := Customer.Name;
            CheckCustomerTemplate(SalesHeader2,TempErrorMessage,CustomerTemplate);
            SalesHeader2."Sell-to Customer Template Code" := '';
            if SalesHeader2."Sell-to Contact No." = SalesHeader2."Bill-to Contact No." Then BEGIN
              SalesHeader2."Bill-to Customer No." := Customer."No.";
              SalesHeader2."Bill-to Name" := Customer.Name;
              SalesHeader2."Bill-to Customer Template Code" := '';
              SalesHeader2."Salesperson Code" := Customer."Salesperson Code";
            END;
            SalesHeader2.MODIFY;
            SalesLine.SetRange("Document Type",SalesHeader2."Document Type");
            SalesLine.SetRange("Document No.",SalesHeader2."No.");
            SalesLine.MODIFYALL("Sell-to Customer No.",SalesHeader2."Sell-to Customer No.");
            if SalesHeader2."Sell-to Contact No." = SalesHeader2."Bill-to Contact No." Then
              SalesLine.MODIFYALL("Bill-to Customer No.",SalesHeader2."Bill-to Customer No.");
            OnAfterModifySellToCustomerNo(SalesHeader2,SalesLine);
          UNTIL SalesHeader.NEXT = 0;

        SalesHeader.Reset;
        SalesHeader.SetRange("Bill-to Customer No.",'');
        SalesHeader.SetRange("Document Type",SalesHeader."Document Type"::Quote);
        SalesHeader.SetRange("Bill-to Contact No.",Cont."No.");
        if SalesHeader.FINDSET Then
          REPEAT
            SalesHeader2.Get(SalesHeader."Document Type",SalesHeader."No.");
            SalesHeader2."Bill-to Customer No." := Customer."No.";
            SalesHeader2."Bill-to Customer Template Code" := '';
            SalesHeader2."Salesperson Code" := Customer."Salesperson Code";
            SalesHeader2.MODIFY;
            SalesLine.SetRange("Document Type",SalesHeader2."Document Type");
            SalesLine.SetRange("Document No.",SalesHeader2."No.");
            SalesLine.MODIFYALL("Bill-to Customer No.",SalesHeader2."Bill-to Customer No.");
            OnAfterModifyBillToCustomerNo(SalesHeader2,SalesLine);
          UNTIL SalesHeader.NEXT = 0;
        OnAfterUpdateQuotesForContact(Cont,Customer);
      UNTIL Cont.NEXT = 0;

    if NOT TempErrorMessage.IsEmpty Then
      if ConfirmManagement.ConfirmProcessUI(
           STRSUBSTNO(MultipleCustomerTemplatesConfirmQst,CustomerTemplate,Customer."No."),TRUE)
      Then
        TempErrorMessage.ShowErrorMessages(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    #18..51
    */
    //end;


    //Unsupported feature: Code Modification on "GetSalutation(PROCEDURE 18)".

    //procedure GetSalutation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if NOT SalutationFormula.Get("Salutation Code",LanguageCode,SalutationType) Then
      Error(Text021,LanguageCode,"No.");
    SalutationFormula.TESTFIELD(Salutation);

    CASE SalutationFormula."Name 1" OF
      SalutationFormula."Name 1"::"Job Title":
        NamePart[1] := "Job Title";
      SalutationFormula."Name 1"::"First Name":
        NamePart[1] := "First Name";
      SalutationFormula."Name 1"::"Middle Name":
        NamePart[1] := "Middle Name";
      SalutationFormula."Name 1"::Surname:
        NamePart[1] := Surname;
      SalutationFormula."Name 1"::Initials:
        NamePart[1] := Initials;
      SalutationFormula."Name 1"::"Company Name":
        NamePart[1] := "Company Name";
    END;

    CASE SalutationFormula."Name 2" OF
      SalutationFormula."Name 2"::"Job Title":
        NamePart[2] := "Job Title";
      SalutationFormula."Name 2"::"First Name":
        NamePart[2] := "First Name";
      SalutationFormula."Name 2"::"Middle Name":
        NamePart[2] := "Middle Name";
      SalutationFormula."Name 2"::Surname:
        NamePart[2] := Surname;
      SalutationFormula."Name 2"::Initials:
        NamePart[2] := Initials;
      SalutationFormula."Name 2"::"Company Name":
        NamePart[2] := "Company Name";
    END;

    CASE SalutationFormula."Name 3" OF
      SalutationFormula."Name 3"::"Job Title":
        NamePart[3] := "Job Title";
      SalutationFormula."Name 3"::"First Name":
        NamePart[3] := "First Name";
      SalutationFormula."Name 3"::"Middle Name":
        NamePart[3] := "Middle Name";
      SalutationFormula."Name 3"::Surname:
        NamePart[3] := Surname;
      SalutationFormula."Name 3"::Initials:
        NamePart[3] := Initials;
      SalutationFormula."Name 3"::"Company Name":
        NamePart[3] := "Company Name";
    END;

    CASE SalutationFormula."Name 4" OF
      SalutationFormula."Name 4"::"Job Title":
        NamePart[4] := "Job Title";
      SalutationFormula."Name 4"::"First Name":
        NamePart[4] := "First Name";
      SalutationFormula."Name 4"::"Middle Name":
        NamePart[4] := "Middle Name";
      SalutationFormula."Name 4"::Surname:
        NamePart[4] := Surname;
      SalutationFormula."Name 4"::Initials:
        NamePart[4] := Initials;
      SalutationFormula."Name 4"::"Company Name":
        NamePart[4] := "Company Name";
    END;

    CASE SalutationFormula."Name 5" OF
      SalutationFormula."Name 5"::"Job Title":
        NamePart[5] := "Job Title";
      SalutationFormula."Name 5"::"First Name":
        NamePart[5] := "First Name";
      SalutationFormula."Name 5"::"Middle Name":
        NamePart[5] := "Middle Name";
      SalutationFormula."Name 5"::Surname:
        NamePart[5] := Surname;
      SalutationFormula."Name 5"::Initials:
        NamePart[5] := Initials;
      SalutationFormula."Name 5"::"Company Name":
        NamePart[5] := "Company Name";
    END;

    OnAfterGetSalutation(SalutationType,LanguageCode,NamePart,Rec);

    FOR i := 1 TO 5 DO
      if NamePart[i] = '' Then BEGIN
        SubStr := '%' + FORMAT(i) + ' ';
        if STRPOS(SalutationFormula.Salutation,SubStr) > 0 Then
          SalutationFormula.Salutation :=
            DELSTR(SalutationFormula.Salutation,STRPOS(SalutationFormula.Salutation,SubStr),3);
      END;

    EXIT(STRSUBSTNO(SalutationFormula.Salutation,NamePart[1],NamePart[2],NamePart[3],NamePart[4],NamePart[5]))
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..79
    OnAfterGetSalutation(SalutationType,LanguageCode,NamePart);
    #81..90
    */
    //end;


    //Unsupported feature: Code Modification on "LookupCustomerTemplate(PROCEDURE 53)".

    //procedure LookupCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustomerTemplate.FILTERGROUP(2);
    CustomerTemplate.SetRange("Contact Type",Type);
    CustomerTemplate.FILTERGROUP(0);
    CustomerTemplateList.LOOKUPMODE := TRUE;
    OnLookupCustomerTemplateOnBeforeSetTableView(Rec,CustomerTemplate);
    CustomerTemplateList.SETTABLEVIEW(CustomerTemplate);
    if CustomerTemplateList.RUNMODAL = ACTION::LookupOK Then BEGIN
      CustomerTemplateList.GETRECORD(CustomerTemplate);
      EXIT(CustomerTemplate.Code);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #6..10
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DateFilterCalc) (VariableCollection) on "SetLastDateTimeModified(PROCEDURE 28)".



    //Unsupported feature: Code Modification on "SetLastDateTimeModified(PROCEDURE 28)".

    //procedure SetLastDateTimeModified();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UtcNow := CURRENTDATETIME;
    UserTimeZoneOffset := GetTimeZoneOffset;
    UtcNow := UtcNow - UserTimeZoneOffset;
    "Last Date Modified" := DT2DATE(UtcNow);
    "Last Time Modified" := DT2TIME(UtcNow);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UtcNow := DateFilterCalc.ConvertToUtcDateTime(CURRENTDATETIME);
    "Last Date Modified" := DT2DATE(UtcNow);
    "Last Time Modified" := DT2TIME(UtcNow);
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DateFilterCalc) (VariableCollection) on "SetLastDateTimeFilter(PROCEDURE 30)".



    //Unsupported feature: Code Modification on "SetLastDateTimeFilter(PROCEDURE 30)".

    //procedure SetLastDateTimeFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SyncDateTimeUtc := DateFilter;
    SyncDateTimeUtc := SyncDateTimeUtc - GetTimeZoneOffset;
    CurrentFilterGroup := FILTERGROUP;
    SETFILTER("Last Date Modified",'>=%1',DT2DATE(SyncDateTimeUtc));
    FILTERGROUP(-1);
    SETFILTER("Last Date Modified",'>%1',DT2DATE(SyncDateTimeUtc));
    SETFILTER("Last Time Modified",'>%1',DT2TIME(SyncDateTimeUtc));
    FILTERGROUP(CurrentFilterGroup);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SyncDateTimeUtc := DateFilterCalc.ConvertToUtcDateTime(DateFilter);
    #3..8
    */
    //end;


    //Unsupported feature: Code Modification on "VATRegistrationValidation(PROCEDURE 41)".

    //procedure VATRegistrationValidation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeVATRegistrationValidation(Rec,IsHandled);
    if IsHandled Then
      EXIT;

    if NOT VATRegistrationNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Contact) Then
      EXIT;

    VATRegistrationLogMgt.LogContact(Rec);

    if ("Country/Region Code" = '') AND (VATRegistrationNoFormat."Country/Region Code" = '') Then
      EXIT;
    ApplicableCountryCode := "Country/Region Code";
    if ApplicableCountryCode = '' Then
      ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";

    if VATRegNoSrvConfig.VATRegNoSrvIsEnabled Then BEGIN
      VATRegistrationLogMgt.ValidateVATRegNoWithVIES(ResultRecordRef,Rec,"No.",
        VATRegistrationLog."Account Type"::Contact,ApplicableCountryCode);
      ResultRecordRef.SETTABLE(Rec);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..21
    */
    //end;

    //Unsupported feature: Property Insertion (AsVar) on "IdenticalAddress(PROCEDURE 16).Cont(Parameter 1000)".


    //Unsupported feature: Property Deletion (Name) on "IdenticalAddress(PROCEDURE 16).IsIdentical(ReturnValue)".


    //Unsupported feature: Deletion (VariableCollection) on "FindCustomerTemplate(PROCEDURE 23).CustTemplateCode(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "FindCustomerTemplate(PROCEDURE 23).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ChooseCustomerTemplate(PROCEDURE 27).CustTemplateCode(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "ChooseCustomerTemplate(PROCEDURE 27).IsHandled(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "UpdateQuotes(PROCEDURE 29).CustomerTemplate(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateQuotes(PROCEDURE 29).TempErrorMessage(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateQuotes(PROCEDURE 29).ConfirmManagement(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "SetLastDateTimeModified(PROCEDURE 28).UserTimeZoneOffset(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterGetSalutation(PROCEDURE 54).Contact(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeCustomerInsert(PROCEDURE 42).Contact(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "VATRegistrationValidation(PROCEDURE 41).IsHandled(Variable 1006)".

}

