codeunit 50001 "AMG_Events"
{
    //Record 18 
    //TODO verifier line 32
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsert', '', false, false)]
    local procedure OnBeforeInsert(var Customer: Record Customer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeLookupContactList', '', false, false)]
    local procedure OnBeforeLookupContactList(var Customer: Record Customer; var IsHandled: Boolean; FieldNumber: Integer)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Cont: Record Contact;
        TempCust: Record Customer temporary;
    begin
        if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Customer, Customer."No.") then
            Cont.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            Cont.SetRange("Company No.", '');

        if Customer."Primary Contact No." <> '' then
            if Cont.Get(Customer."Primary Contact No.") then;
        if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
            TempCust.Copy(Customer);
            Customer.Find();
            Customer.TransferFields(TempCust, false);
            Customer.Validate("Primary Contact No.", Cont."No.");
        end;
        IsHandled := true;
    end;

    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEmail', '', false, false)]
    local procedure OnBeforeValidateEmail(var Customer: Record Customer; var IsHandled: Boolean; xCustomer: Record Customer)
    var
        MailManagement: Codeunit "Mail Management";
    begin
        MailManagement.ValidateEmailAddressField(Customer."E-Mail");
        IsHandled := true;
    end;
    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var Customer: Record Customer; var xCustomer: Record Customer; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Customer, Customer."No.", FieldNumber, ShortcutDimCode);
        Customer.Modify();
    end;
    //TODO verifier line 1626,1650
    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeCheckBlockedCust', '', false, false)]
    local procedure OnBeforeCheckBlockedCust(Customer: Record Customer; Source: Option Journal,Document; DocType: Option; Shipment: Boolean; Transaction: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := false;
    end;
    //TODO check for line 1740 possibly not needed
    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeGetTotalAmountLCYCommon', '', false, false)]
    local procedure OnBeforeGetTotalAmountLCYCommon(var Customer: Record Customer; var AdditionalAmountLCY: Decimal; var IsHandled: Boolean)
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesLine: Record "Sales Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServiceLine: Record "Service Line";
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
        InvoicedPrepmtAmountLCY: Decimal;
        RetRcdNotInvAmountLCY: Decimal;
    begin
        SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment(Customer."No.");
        ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment(Customer."No.");
        InvoicedPrepmtAmountLCY := Customer.GetInvoicedPrepmtAmountLCY();
        RetRcdNotInvAmountLCY := Customer.GetReturnRcdNotInvAmountLCY();
        AdditionalAmountLCY := Customer."Balance (LCY)" + Customer."Outstanding Orders (LCY)" + Customer."Shipped Not Invoiced (LCY)" + Customer."Outstanding Invoices (LCY)" +
        Customer."Outstanding Serv. Orders (LCY)" + Customer."Serv Shipped Not Invoiced(LCY)" + Customer."Outstanding Serv.Invoices(LCY)" -
        SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY - RetRcdNotInvAmountLCY;
        IsHandled := true;
    end;
    //Record 18 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeIsContactUpdateNeeded', '', false, false)]
    local procedure OnBeforeIsContactUpdateNeeded(Customer: Record Customer; xCustomer: Record Customer; var UpdateNeeded: Boolean; ForceUpdateContact: Boolean)
    var
        CustContUpdate: Codeunit "CustCont-Update";
    begin
        if ForceUpdateContact then begin
            UpdateNeeded :=
              (Customer.Name <> xCustomer.Name) or
              (Customer."Search Name" <> xCustomer."Search Name") or
              (Customer."Name 2" <> xCustomer."Name 2") or
              (Customer.Address <> xCustomer.Address) or
              (Customer."Address 2" <> xCustomer."Address 2") or
              (Customer.City <> xCustomer.City) or
              (Customer."Phone No." <> xCustomer."Phone No.") or
              (Customer."Mobile Phone No." <> xCustomer."Mobile Phone No.") or
              (Customer."Telex No." <> xCustomer."Telex No.") or
              (Customer."Territory Code" <> xCustomer."Territory Code") or
              (Customer."Currency Code" <> xCustomer."Currency Code") or
              (Customer."Language Code" <> xCustomer."Language Code") or
              (Customer."Salesperson Code" <> xCustomer."Salesperson Code") or
              (Customer."Country/Region Code" <> xCustomer."Country/Region Code") or
              (Customer."Fax No." <> xCustomer."Fax No.") or
              (Customer."Telex Answer Back" <> xCustomer."Telex Answer Back") or
              (Customer."Registration Number" <> xCustomer."Registration Number") or
              (Customer."VAT Registration No." <> xCustomer."VAT Registration No.") or
              (Customer."Post Code" <> xCustomer."Post Code") or
              (Customer.County <> xCustomer.County) or
              (Customer."E-Mail" <> xCustomer."E-Mail") or
              (Customer."Home Page" <> xCustomer."Home Page") or
              (Customer.Contact <> xCustomer.Contact);

            if not UpdateNeeded and not Customer.IsTemporary then
                UpdateNeeded := CustContUpdate.ContactNameIsBlank(Customer."No.");
        end;
    end;
    //Record 21 
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnBeforeShowDoc', '', false, false)]
    local procedure OnBeforeShowDoc(CustLedgerEntry: Record "Cust. Ledger Entry"; var IsPageOpened: Boolean; var IsHandled: Boolean)
    var
        SalesInvoiceHdr: Record "Sales Invoice Header";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
    begin
        case CustLedgerEntry."Document Type" of
            CustLedgerEntry."Document Type"::Invoice:
                begin
                    if SalesInvoiceHdr.Get(CustLedgerEntry."Document No.") then begin
                        PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHdr);
                        IsPageOpened := true;
                    end;
                    if ServiceInvoiceHeader.Get(CustLedgerEntry."Document No.") then begin
                        PAGE.Run(PAGE::"Posted Service Invoice", ServiceInvoiceHeader);
                        IsPageOpened := true;
                    end;
                end;
            CustLedgerEntry."Document Type"::"Credit Memo":
                begin
                    if SalesCrMemoHdr.Get(CustLedgerEntry."Document No.") then begin
                        PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHdr);
                        IsPageOpened := true;
                    end;
                    if ServiceCrMemoHeader.Get(CustLedgerEntry."Document No.") then begin
                        PAGE.Run(PAGE::"Posted Service Credit Memo", ServiceCrMemoHeader);
                        IsPageOpened := true;
                    end;
                end;
        end;
        IsHandled := true;
    end;
    //Record 23 
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure OnBeforeValidateShortcutDimCodeVendor(var Vendor: Record Vendor; var xVendor: Record Vendor; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Vendor, Vendor."No.", FieldNumber, ShortcutDimCode);
        Vendor.Modify();
        IsHandled := true;
    end;
    //Record 23 
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnGetVendorNoOpenCardOnBeforeVendorFindSet', '', false, false)]
    local procedure OnGetVendorNoOpenCardOnBeforeVendorFindSet(var Vendor: Record Vendor)
    begin
        Vendor.Reset();
    end;
    //Record 27 
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateItemCategoryCode', '', false, false)]
    local procedure OnAfterValidateItemCategoryCode(var Item: Record Item; xItem: Record Item)
    var
        ItemAttributeManagement: Codeunit "Item Attribute Management";
    begin
        if Item.IsTemporary then begin
            ItemAttributeManagement.InheritAttributesFromItemCategory(Item, Item."Item Category Code", xItem."Item Category Code");
            Item.UpdateItemCategoryId();
        end;
    end;
    //Record 27 //TODO verifier line 2215
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateShortcutDimCode', '', false, false)]
    local procedure OnAfterValidateShortcutDimCode(var Item: Record Item; xItem: Record Item; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        if Item.IsTemporary then begin
            DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
            DimMgt.SaveDefaultDim(DATABASE::Item, Item."No.", FieldNumber, ShortcutDimCode);
            Item.Modify();
        end;
    end;
    //Record 36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateShipToCodeFromCust', '', false, false)]
    local procedure OnBeforeUpdateShipToCodeFromCust(var SalesHeader: Record "Sales Header"; var Customer: Record Customer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 36 //TODO verifier line 192
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeUpdateSellToCont', '', false, false)]
    local procedure OnValidateSellToCustomerNoOnBeforeUpdateSellToCont(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; var SkipSellToContact: Boolean)
    begin
        SalesHeader.Validate("Ship-to Code", SellToCustomer."Ship-to Code");
    end;
    //Record 36 //TODO verifier
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCheckShipmentInfo', '', false, false)]
    local procedure OnBeforeCheckShipmentInfo(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; BillTo: Boolean; var IsHandled: Boolean)
    begin
        if BillTo then
            IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateBillToName', '', false, false)]
    local procedure OnBeforeValidateBillToName(var SalesHeader: Record "Sales Header"; var Customer: Record Customer; var IsHandled: Boolean; xSalesHeader: Record "Sales Header")
    begin
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeLookupSelltoContact', '', false, false)]
    local procedure OnBeforeLookupSelltoContact(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Contact: Record Contact;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Quote then
            if SalesHeader."Sell-to Customer No." = '' then
                exit;
        SalesHeader.LookupContact(SalesHeader."Sell-to Customer No.", SalesHeader."Sell-to Contact No.", Contact);
        if PAGE.RunModal(0, Contact) = ACTION::LookupOK then
            SalesHeader.Validate("Sell-to Contact No.", Contact."No.");
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateExternalDocumentNo', '', false, false)]
    local procedure OnBeforeValidateExternalDocumentNo(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 36 //TODO verifier 1 et 2
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignShipmentDate', '', false, false)]
    local procedure OnInitRecordOnBeforeAssignShipmentDate(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Quote] then begin
            SalesHeader."Shipment Date" := WorkDate();
            SalesHeader."Order Date" := WorkDate();
        end;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
            SalesHeader."Order Date" := WorkDate();
        IsHandled := true;
    end;
    //Record 36 //TODO verifier 1 et 2
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignOrderDate', '', false, false)]
    local procedure OnInitRecordOnBeforeAssignOrderDate(var SalesHeader: Record "Sales Header"; var NewOrderDate: Date)
    begin
        NewOrderDate := SalesHeader."Order Date";
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCheckNoAndShowConfirm', '', false, false)]
    local procedure OnBeforeCheckNoAndShowConfirm(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var SalesInvHeaderPrePmt: Record "Sales Invoice Header"; var SalesCrMemoHeaderPrePmt: Record "Sales Cr.Memo Header"; SourceCode: Record "Source Code"; var Result: Boolean; var IsHandled: Boolean)
    var
        LRecHist: Record "Sales Archive";
        ConfirmManagement: Codeunit "Confirm Management";
        Text009: Label 'Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text030: Label 'Deleting this document will cause a gap in the number series for return receipts. An empty return receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text056: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text057: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
    begin
        if SalesShptHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text009, SalesShptHeader."No."), true) then
                exit;
        if SalesInvHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text012, SalesInvHeader."No."), true) then
                exit;
        if SalesCrMemoHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text014, SalesCrMemoHeader."No."), true) then
                exit;
        if ReturnRcptHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text030, ReturnRcptHeader."No."), true) then
                exit;
        if SalesHeader."Prepayment No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text056, SalesInvHeaderPrepmt."No."), true) then
                exit;
        if SalesHeader."Prepmt. Cr. Memo No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text057, SalesCrMemoHeaderPrepmt."No."), true) then
                exit;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            LRecHist.DELDeleteDevis(SalesHeader."No.")
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                LRecHist.DELDeleteCmdVente(SalesHeader."No.");
        Result := true;
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateSellToEmail', '', false, false)]
    local procedure OnBeforeUpdateSellToEmail(var SalesHeader: Record "Sales Header"; Contact: Record Contact; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateSellToCustContact', '', false, false)]
    local procedure OnBeforeUpdateSellToCustContact(var SalesHeader: Record "Sales Header"; Conact: Record Contact; var IsHandled: Boolean)
    var
        Customer: Record Customer;
    begin
        if (Conact.Type = Conact.Type::Company) and Customer.Get(SalesHeader."Sell-to Customer No.") then
            SalesHeader."Sell-to Contact" := Customer.Contact
        else
            SalesHeader."Sell-to Contact" := Conact.Name;
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateBillToCustContact', '', false, false)]
    local procedure OnBeforeUpdateBillToCustContact(var SalesHeader: Record "Sales Header"; Conact: Record Contact; var IsHandled: Boolean)
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SalesHeader."Bill-to Customer No.") and (Conact.Type <> Conact.Type::Person) then
            SalesHeader."Bill-to Contact" := Customer.Contact
        else
            SalesHeader."Bill-to Contact" := Conact.Name;
    end;
    //Record 36 //TODO verifier line 3694
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetSecurityFilterOnRespCenter', '', false, false)]
    local procedure OnBeforeSetSecurityFilterOnRespCenter(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        UserSetupMgt: Codeunit "User Setup Management";
    begin
        if UserSetupMgt.GetSalesFilter() <> '' then begin
            SalesHeader.FilterGroup(2);
            SalesHeader.SetRange("Responsibility Center", UserSetupMgt.GetSalesFilter());
            SalesHeader.FilterGroup(0);
        end;

        SalesHeader.SetRange("Date Filter", 0D, WorkDate() - 1);
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeValidateQuantity', '', false, false)]
    local procedure OnCreateSalesLineOnBeforeValidateQuantity(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; var ShouldValidateQuantity: Boolean)
    begin
        //TODO field spe 
        if ShouldValidateQuantity then begin
            SalesLine.Validate(Quantity, TempSalesLine.Quantity);
            SalesLine.Validate("Qty. to Assemble to Order", TempSalesLine."Qty. to Assemble to Order");
            // SalesLine.Marge := TempSalesLine.Marge;
            SalesLine."Line Discount %" := TempSalesLine."Line Discount %";
            //   SalesLine.Validate(Marque, TempSalesLine.Marque);
            ShouldValidateQuantity := false;
        end;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeSetDropShipment', '', false, false)]
    local procedure OnCreateSalesLineOnBeforeSetDropShipment(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        SalesLine."Drop Shipment" := TempSalesLine."Drop Shipment";
        if SalesLine."Bill-to Customer No." <> TempSalesLine."Bill-to Customer No." then begin
            SalesLine."Purchasing Code" := TempSalesLine."Purchasing Code";
            SalesLine."Special Order Purchase No." := TempSalesLine."Special Order Purchase No.";
            SalesLine."Special Order Purch. Line No." := TempSalesLine."Special Order Purch. Line No.";
        end;
        IsHandled := true;
    end;
    //Record 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean; var SkipSellToContact: Boolean)
    begin
        SalesHeader."Compl. cond. livraison" := SellToCustomer."Compl. cond. livraison";
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeCheckPostingSetups', '', false, false)]
    local procedure OnValidateNoOnBeforeCheckPostingSetups(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', false, false)]
    local procedure OnValidateNoOnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        PostingSetupMgt: Codeunit PostingSetupManagement;
        LRecItem: Record Item;
        LTextParam: Text;
        XMLBufferWriter: Codeunit "XML Buffer Writer";
        XMLBuffer: Record "XML Buffer";
        XMLSpecialInterestNode: Record "XML Buffer";
        NodeNotFoundErr: Text;
        LCodItemNo: Code[20];
        LDecQty: Decimal;
        OutSalesHeader: Record "Sales Header";
        OutCurrency: Record Currency;
    begin
        PostingSetupMgt.CheckGenPostingSetupSalesAccount(SalesLine."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group");
        PostingSetupMgt.CheckGenPostingSetupCOGSAccount(SalesLine."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupSalesAccount(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group");

        //DELPHI AUB AMG.CARBO 01.03.2021
        LCodItemNo := '';
        LDecQty := 0;
        if LRecItem.Get(SalesLine."No.") then begin
            if LRecItem."Type carbo" then
                LTextParam := REPORT.RUNREQUESTPAGE(Report::DELInsertCarboAMG); //r‚cup‚ration des valeurs saisies sur la RequestPage
                                                                                //MESSAGE(LTextParam);
            if (LTextParam <> '') then begin

                XMLBufferWriter.InitializeXMLBufferFromText(XMLBuffer, LTextParam);
                XMLBuffer.SETFILTER(Path, '/ReportParameters/Options/Field/@name');
                XMLBuffer.SetRange(Value, 'ItemNo'); //on r‚cupŠre le code article de l'emballage carbo
                if XMLBuffer.FINDLAST() then
                    if XMLSpecialInterestNode.Get(XMLBuffer."Parent Entry No.") then
                        LCodItemNo := XMLSpecialInterestNode.Value;

                //On r‚cupŠre la quantit‚
                XMLBuffer.SetRange(Value, 'GDecQty');
                if XMLBuffer.FINDLAST() then
                    if XMLSpecialInterestNode.Get(XMLBuffer."Parent Entry No.") then
                        EVALUATE(LDecQty, XMLSpecialInterestNode.Value);

                XMLBuffer.DELETEALL();
                //Insertion de la ligne emballage carbo
                if (LCodItemNo <> '') and (LDecQty > 0) then begin
                    SalesLine.GetSalesHeader(OutSalesHeader, OutCurrency);
                    SalesLine.FAddLinesForCarbo(OutSalesHeader, LCodItemNo, LDecQty)
                end;
            end;
        end;
    end;

    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateDescription', '', false, false)]
    local procedure OnBeforeValidateDescription(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var InHandled: Boolean);
    var
        Item: Record Item;
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        FindRecordMgt: Codeunit "Find Record Management";
        ReturnValue: Text[100];
        DescriptionIsNo: Boolean;
        DefaultCreate: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";
        LookupRequested: Boolean; //TODO verifier not used
        IdentityManagement: Codeunit "Identity Management";
        Confirmed: Boolean;
        CannotFindDescErr: Label 'Cannot find %1 with Description %2.\\Make sure to use the correct type.', Comment = '%1 = Type caption %2 = Description';
        AnotherItemWithSameDescrQst: Label 'We found an item with the description "%2" (No. %1).\Did you mean to change the current item to %1?', Comment = '%1=Item no., %2=item description';

    begin
        if not SalesLine.HasTypeToFillMandatoryFields() then
            exit;

        if SalesLine."No." <> '' then
            exit;

        case SalesLine.Type of
            SalesLine.Type::Item:
                begin
                    // if (StrLen(SalesLine.Description) <= MaxStrLen(Item."No.")) and (SalesLine."No." <> '') then
                    //     DescriptionIsNo := Item.Get(SalesLine.Description)
                    // else
                    //     DescriptionIsNo := false;

                    // if (SalesLine."No." <> '') and (not DescriptionIsNo) and (SalesLine.Description <> '') then begin
                    //     Item.SetRange(Description, SalesLine.Description);
                    //     //TODO IsInvAppId removed
                    //     if Item.FINDFIRST then
                    //         Confirmed := IdentityManagement.IsInvAppId
                    //     else begin
                    //         Item.SETFILTER(Description, '''@' + CONVERTSTR(SalesLine.Description, '''', '?') + '''');
                    //         if not Item.FINDFIRST then
                    //             exit;
                    //     end;

                    //     if Item."No." = SalesLine."No." then
                    //         exit;
                    //     //TODO IsInvAppId removed
                    //     if GUIALLOWED then
                    //         if not IdentityManagement.IsInvAppId then
                    //             Confirmed := CONFIRM(AnotherItemWithSameDescrQst, false, Item."No.", Item.Description);
                    //     if IdentityManagement.IsInvAppId or Confirmed then
                    //         SalesLine.VALIDATE("No.", Item."No.");
                    //     exit;
                    // end;

                    SalesSetup.Get();
                    DefaultCreate := (SalesLine."No." = '') and SalesSetup."Create Item from Description";
                    //     //TODO IsInvAppId removed
                    //         if Item.TryGetItemNoOpenCard(
                    //              ReturnValue, SalesLine.Description, DefaultCreate, not SalesLine.GetHideValidationDialog(), not IdentityManagement.IsInvAppId)
                    //         then
                    //             case ReturnValue of
                    //                 '':
                    //                     begin
                    //                         LookupRequested := true;
                    //                         SalesLine.Description := xSalesLine.Description;
                    //                     end;
                    //                 SalesLine."No.":
                    //                     SalesLine.Description := xSalesLine.Description;
                    //                 else begin
                    //                     CurrentFieldNo := SalesLine.FieldNo("No.");
                    //                     SalesLine.Validate("No.", CopyStr(ReturnValue, 1, MaxStrLen(Item."No.")));
                    //                 end;
                    //             end;
                    //     end;
                    // else
                    //     if SalesLine."No." = '' then begin
                    //         //TODO FindNoByDescription has scope Onprem
                    //         //   ReturnValue := FindRecordMgt.FindNoByDescription(Type.AsInteger(), SalesLine.Description, true);
                    //         if ReturnValue <> '' then begin
                    //             CurrentFieldNo := SalesLine.FieldNo("No.");
                    //             SalesLine.Validate("No.", CopyStr(ReturnValue, 1, MaxStrLen(SalesLine."No.")));
                    //         end;
                end;
        end;
        if (SalesLine."No." = '') and GuiAllowed then
            if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                if SalesLine."Document Type" in
                [SalesLine."Document Type"::Order, SalesLine."Document Type"::Invoice, SalesLine."Document Type"::Quote, SalesLine."Document Type"::"Credit Memo"]
                then
                    Error(CannotFindDescErr, SalesLine.Type, SalesLine.Description);
        InHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateVATProdPostingGroupTrigger', '', false, false)]
    local procedure OnBeforeValidateVATProdPostingGroupTrigger(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CannotChangeVATGroupWithPrepmInvErr: Label 'You cannot change the VAT product posting group because prepayment invoices have been posted.\\You need to post the prepayment credit memo to be able to change the VAT product posting group.';

    begin
        SalesLine.TestStatusOpen();
        if (SalesLine."Prepmt. Amt. Inv." <> 0) and (SalesLine."VAT Prod. Posting Group" <> xSalesLine."VAT Prod. Posting Group") then
            Error(CannotChangeVATGroupWithPrepmInvErr);
        VATPostingSetup.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group");
        SalesLine."VAT Difference" := 0;

        SalesLine.GetSalesHeader(SalesHeader, Currency);
        SalesLine."VAT %" := VATPostingSetup."VAT %";
        SalesLine."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
        SalesLine."VAT Identifier" := VATPostingSetup."VAT Identifier";
        SalesLine."VAT Clause Code" := VATPostingSetup."VAT Clause Code";
        case SalesLine."VAT Calculation Type" of
            SalesLine."VAT Calculation Type"::"Reverse Charge VAT",
            SalesLine."VAT Calculation Type"::"Sales Tax":
                SalesLine."VAT %" := 0;
            SalesLine."VAT Calculation Type"::"Full VAT":
                begin
                    SalesLine.TestField(Type, SalesLine.Type::"G/L Account");
                    SalesLine.TestField("No.", VATPostingSetup.GetSalesAccount(false));
                end;
        end;

        if SalesHeader."Prices Including VAT" and (SalesLine.Type in [SalesLine.Type::Item, SalesLine.Type::Resource]) then
            SalesLine."Unit Price" :=
                Round(
                    SalesLine."Unit Price" * (100 + SalesLine."VAT %") / (100 + xSalesLine."VAT %"),
            Currency."Unit-Amount Rounding Precision");

        SalesLine.UpdateAmounts();
        IsHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemUOM', '', false, false)]
    local procedure OnAfterAssignItemUOM(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    begin
        SalesLine."Units per Parcel" :=
                              Round(Item."Units per Parcel" / SalesLine."Qty. per Unit of Measure", 0.00001);
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeShowUnitPriceChangedMsg', '', false, false)]
    local procedure OnBeforeShowUnitPriceChangedMsg(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateVATAmountsOnAfterSetSalesLineFilters', '', false, false)]
    local procedure OnUpdateVATAmountsOnAfterSetSalesLineFilters(var SalesLine: Record "Sales Line"; var SalesLine2: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesLine2.SetRange("Tax Area Code");
    end;
    //Record 37 //TODO verifier line 3868
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeAddItems', '', false, false)]
    local procedure OnBeforeAddItems(var SalesLine: Record "Sales Line"; SelectionFilter: Text; var IsHandled: Boolean)
    var
        ItemListPage: Page "Item List";
    begin
        SelectionFilter := ItemListPage.SelectActiveItemsForSale();
        if SelectionFilter = '' then
            IsHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeShowItemSub', '', false, false)]
    local procedure OnBeforeShowItemSub(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        ItemSubstitutionMgt: Codeunit "Item Subst.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        SalesLine.TestStatusOpen();
        if ItemSubstitutionMgt.ItemSubstGet(SalesLine) then
            if TransferExtendedText.SalesCheckIfAnyExtText(SalesLine, true) then
                TransferExtendedText.InsertSalesExtText(SalesLine);
        IsHandled := true;
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCheckWarehouseOnBeforeShowDialog', '', false, false)]
    local procedure OnCheckWarehouseOnBeforeShowDialog(var SalesLine: Record "Sales Line"; Location: Record Location; var ShowDialog: Option " ",Message,Error; var DialogText: Text[50])
    var
        Text017: Label '\The entered information may be disregarded by warehouse operations.';
        Text016: Label '%1 is required for %2 = %3.';
    begin
        case ShowDialog of
            ShowDialog::Message:
                Message(Text016 + Text017, DialogText, SalesLine.FieldCaption("Line No."), SalesLine."Line No.");
            ShowDialog::Error:
                Error(Text016, DialogText, SalesLine.FieldCaption("Line No."), SalesLine."Line No.");
        end;
        ShowDialog := ShowDialog::" ";
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeGetLineAmountToHandle', '', false, false)]
    local procedure OnBeforeGetLineAmountToHandle(var QtyToHandle: Decimal; var SalesLine: Record "Sales Line"; Currency: Record Currency; var IsHandled: Boolean)
    var
        LineAmount: Decimal;
        LineDiscAmount: Decimal;
        SalesHeader: Record "Sales Header";
    begin

        if SalesLine."Line Discount %" = 100 then begin
            QtyToHandle := 0;
            IsHandled := true;
            exit;
        end;
        SalesLine.GetSalesHeader(SalesHeader, Currency);

        if SalesLine."Prepmt Amt to Deduct" = 0 then
            LineAmount := Round(QtyToHandle * SalesLine."Unit Price", Currency."Amount Rounding Precision")
        else begin
            LineAmount := Round(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision");
            LineAmount := Round(QtyToHandle * LineAmount / SalesLine.Quantity, Currency."Amount Rounding Precision");
        end;
        if QtyToHandle <> SalesLine.Quantity then
            LineDiscAmount := Round(LineAmount * SalesLine."Line Discount %" / 100, Currency."Amount Rounding Precision")
        else
            LineDiscAmount := SalesLine."Line Discount Amount";
        QtyToHandle := LineAmount - LineDiscAmount;
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyPayToVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyPayToVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    var
        PaymentTerms: Record "Payment Terms";
    begin
        if PurchaseHeader.IsCreditDocType() then begin
            PurchaseHeader."Payment Method Code" := '';
            if PaymentTerms.Get(PurchaseHeader."Payment Terms Code") then
                if PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then
                    PurchaseHeader."Payment Method Code" := Vendor."Payment Method Code"
        end;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidatePricesIncludingVAT', '', false, false)]
    local procedure OnBeforeValidatePricesIncludingVAT(var PurchaseHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    var
        Currency: Record Currency;
        ConfirmManagement: Codeunit "Confirm Management";
        RecalculatePrice: Boolean;
        VatFactor: Decimal;
        LineInvDiscAmt: Decimal;
        InvDiscRounding: Decimal;
        Text025: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
    begin
        PurchaseHeader.TestStatusOpen();

        if PurchaseHeader."Prices Including VAT" <> xPurchaseHeader."Prices Including VAT" then begin
            PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetFilter("Direct Unit Cost", '<>%1', 0);
            PurchLine.SetFilter("VAT %", '<>%1', 0);
            if PurchLine.Find('-') then begin
                RecalculatePrice :=
                  ConfirmManagement.GetResponseOrDefault(
                    StrSubstNo(
                      Text025 +
                      Text027,
                      PurchaseHeader.FieldCaption("Prices Including VAT"), PurchLine.FieldCaption("Direct Unit Cost")),
                    true);
                PurchLine.SetPurchHeader(PurchaseHeader);

                Currency.Initialize(PurchaseHeader."Currency Code");

                PurchLine.FindSet();
                repeat
                    PurchLine.TestField("Quantity Invoiced", 0);
                    PurchLine.TestField("Prepmt. Amt. Inv.", 0);
                    if not RecalculatePrice then begin
                        PurchLine."VAT Difference" := 0;
                        PurchLine.UpdateAmounts();
                    end else begin
                        VatFactor := 1 + PurchLine."VAT %" / 100;
                        if VatFactor = 0 then
                            VatFactor := 1;
                        if not PurchaseHeader."Prices Including VAT" then
                            VatFactor := 1 / VatFactor;
                        PurchLine."Direct Unit Cost" :=
                          Round(PurchLine."Direct Unit Cost" * VatFactor, Currency."Unit-Amount Rounding Precision");
                        PurchLine."Line Discount Amount" :=
                          Round(
                            PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                            Currency."Amount Rounding Precision");
                        LineInvDiscAmt := InvDiscRounding + PurchLine."Inv. Discount Amount" * VatFactor;
                        PurchLine."Inv. Discount Amount" := Round(LineInvDiscAmt, Currency."Amount Rounding Precision");
                        InvDiscRounding := LineInvDiscAmt - PurchLine."Inv. Discount Amount";
                        if PurchaseHeader."Prices Including VAT" then
                            PurchLine."Line Amount" := PurchLine."Amount Including VAT" + PurchLine."Inv. Discount Amount"
                        else
                            PurchLine."Line Amount" := PurchLine.Amount + PurchLine."Inv. Discount Amount";
                        PurchaseHeader.UpdatePrepmtAmounts(PurchLine);
                    end;
                    PurchLine.Modify();
                until PurchLine.Next() = 0;
            end;
        end;
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateBuyFromVendorName', '', false, false)]
    local procedure OnBeforeValidateBuyFromVendorName(var PurchaseHeader: Record "Purchase Header"; var Vendor: Record Vendor; var IsHandled: Boolean)
    var
        LookupStateManager: Codeunit "Lookup State Manager";
        StandardCodesMgt: Codeunit "Standard Codes Mgt.";
    begin
        if LookupStateManager.IsRecordSaved() then begin
            Vendor := LookupStateManager.GetSavedRecord();
            if Vendor."No." <> '' then begin
                LookupStateManager.ClearSavedRecord();
                PurchaseHeader.Validate("Buy-from Vendor No.", Vendor."No.");
                if PurchaseHeader."No." <> '' then
                    StandardCodesMgt.CheckCreatePurchRecurringLines(PurchaseHeader);
                exit;
            end;
        end;
        if PurchaseHeader.ShouldSearchForVendorByName(PurchaseHeader."Pay-to Vendor No.") then
            PurchaseHeader.Validate("Buy-from Vendor No.", Vendor.GetVendorNo(PurchaseHeader."Buy-from Vendor Name"));
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterSetSecurityFilterOnRespCenter', '', false, false)]
    local procedure OnAfterSetSecurityFilterOnRespCenter(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.SetRange("Date Filter");
        PurchaseHeader.SetRange("Date Filter", 0D, WorkDate() - 1);
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeAddSpecialOrderToAddress', '', false, false)]
    local procedure OnBeforeAddSpecialOrderToAddress(var PurchaseHeader: Record "Purchase Header"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; ShowError: Boolean)
    var
        PurchLine3: Record "Purchase Line";
        LocationCode: Record Location;
        Text052: Label 'The %1 field on the purchase order %2 must be the same as on sales order %3.';
    begin
        if ShowError then begin
            PurchLine3.Reset();
            PurchLine3.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
            PurchLine3.SetRange("Document No.", PurchaseHeader."No.");
            if not PurchLine3.IsEmpty then begin
                LocationCode.Get(PurchaseHeader."Location Code");
                if PurchaseHeader."Ship-to Name" <> LocationCode.Name then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Name"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to Name 2" <> LocationCode."Name 2" then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Name 2"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to Address" <> LocationCode.Address then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Address"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to Address 2" <> LocationCode."Address 2" then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Address 2"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to Post Code" <> LocationCode."Post Code" then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Post Code"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to City" <> LocationCode.City then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to City"), PurchaseHeader."No.", SalesHeader."No.");
                if PurchaseHeader."Ship-to Contact" <> LocationCode.Contact then
                    Error(Text052, PurchaseHeader.FieldCaption("Ship-to Contact"), PurchaseHeader."No.", SalesHeader."No.");
            end else
                PurchaseHeader.SetShipToForSpecOrder();
        end;
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeSendRecords', '', false, false)]
    local procedure OnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        ReportSelections: Record "Report Selections";
        Selected: Integer;
        DocTxt: Text[150];
        TextSTR: Label 'Commande achat,Commande achat avec attestation TVA';
        TextDemande: Label 'Choisisez votre impression :';
    begin
        Selected := DIALOG.STRMENU(TextSTR, 1, TextDemande);
        if Selected = 1 then
            DocumentSendingProfile.SendVendorRecords(
              ReportSelections.Usage::"P.Order", PurchaseHeader, DocTxt, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."No.",
              PurchaseHeader.FieldNo("Buy-from Vendor No."), PurchaseHeader.FieldNo("No."))
        else
            //TODO type spe
            // if Selected = 2 Then
            //     DocumentSendingProfile.SendVendorRecords(
            //       ReportSelections.Usage::"P.OrderVAT", PurchaseHeader, DocTxt, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."No.",
            //       PurchaseHeader.FieldNo("Buy-from Vendor No."), PurchaseHeader.FieldNo("No."));
            IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecords(var PurchaseHeader: Record "Purchase Header"; ShowRequestForm: Boolean; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        Selected: Integer;
        TextSTR: Label 'Commande achat,Commande achat avec attestation TVA';
        TextDemande: Label 'Choisisez votre impression :';
    begin
        Selected := DIALOG.STRMENU(TextSTR, 1, TextDemande);
        if Selected = 1 then
            DocumentSendingProfile.TrySendToPrinterVendor(
              DummyReportSelections.Usage::"P.Order", PurchaseHeader, PurchaseHeader.FieldNo("Buy-from Vendor No."), ShowRequestForm)
        else
            //TODO type spe
            // if Selected = 2 Then
            //     DocumentSendingProfile.TrySendToPrinterVendor(
            //      DummyReportSelections.Usage::"P.OrderVAT",
            //      PurchaseHeader, PurchaseHeader.FIELDNO("Buy-from Vendor No."), ShowRequestForm);
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeSetDefaultPurchaser', '', false, false)]
    local procedure OnBeforeSetDefaultPurchaser(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        if not UserSetup.Get(UserId) then
            exit;
        if UserSetup."Salespers./Purch. Code" <> '' then
            if SalespersonPurchaser.Get(UserSetup."Salespers./Purch. Code") then
                if not SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                    PurchaseHeader.Validate("Purchaser Code", UserSetup."Salespers./Purch. Code");
        IsHandled := true;
    end;
    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEmptySellToCustomerAndLocation', '', false, false)]
    local procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.Validate("Sell-to Customer No.", '');
        PurchaseHeader.UpdateLocationCode(Vendor."Location Code");
        IsHandled := true;
    end;
    //Record 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCopyFromItem', '', false, false)]
    local procedure OnBeforeCopyFromItem(var PurchaseLine: Record "Purchase Line"; var Item: Record Item; var IsHandled: Boolean)
    var
        ItemPurchasingBlockedErr: Label 'You cannot purchase Item %1 because the %2 check box is selected on the Item card.', Comment = '%1 - Item No., %2 - Blocked Field Caption';

    begin
        Item.TestField(Blocked, false);
        Item.TestField("Gen. Prod. Posting Group");
        if Item."Purchasing Blocked" then//TODO verifier line 3181
            // if PurchaseLine.IsCreditDocType() then
            //     PurchaseLine.SendBlockedItemNotification()
            // else
            //     Error(ItemPurchasingBlockedErr, Item."No.", Item.FieldCaption("Purchasing Blocked"));
                Error(ItemPurchasingBlockedErr);
        if Item.Type = Item.Type::Inventory then begin
            Item.TestField("Inventory Posting Group");
            PurchaseLine."Posting Group" := Item."Inventory Posting Group";
        end;
        IsHandled := true;
    end;
    //Record 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateAmounts', '', false, false)]
    local procedure OnBeforeUpdateAmounts(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        VATBaseAmount: Decimal;
        NonDeductAmount: Decimal;
        LineAmountChanged: Boolean;
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
        PurchHeader: Record "Purchase Header";
        Currency: Record Currency;
        RemLineAmountToInvoice: Decimal;
        Text037: Label 'cannot be %1.';
        Text038: Label 'cannot be less than %1.';
        Text039: Label 'cannot be more than %1.';
        Text043: Label 'must be positive when %1 is not 0.';
        PrePaymentLineAmountEntered: Boolean; //TODO verifier 
        CannotChangePrepaidServiceChargeErr: Label 'You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.';
    begin
        if PurchaseLine.Type = PurchaseLine.Type::" " then
            exit;

        PurchaseLine.GetPurchHeader(PurchHeader, Currency);

        VATBaseAmount := PurchaseLine."VAT Base Amount";
        NonDeductAmount := NonDeductibleVAT.GetNonDeductibleVATAmount(PurchaseLine);
        PurchaseLine."Recalculate Invoice Disc." := PurchaseLine."Allow Invoice Disc.";

        PurchaseLine.UpdateLineAmount(LineAmountChanged, Currency);

        if not PurchaseLine."Prepayment Line" then begin
            if PurchaseLine."Prepayment %" <> 0 then begin
                if PurchaseLine.Quantity < 0 then
                    PurchaseLine.FIELDERROR(Quantity, STRSUBSTNO(Text043, PurchaseLine.FIELDCAPTION("Prepayment %")));
                if PurchaseLine."Direct Unit Cost" < 0 then
                    PurchaseLine.FIELDERROR("Direct Unit Cost", STRSUBSTNO(Text043, PurchaseLine.FIELDCAPTION("Prepayment %")));
            end;
            if PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice then begin
                PurchaseLine."Prepayment VAT Difference" := 0;
                if not PrePaymentLineAmountEntered then
                    PurchaseLine."Prepmt. Line Amount" := ROUND(PurchaseLine."Line Amount" * PurchaseLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
                if PurchaseLine."Prepmt. Line Amount" < PurchaseLine."Prepmt. Amt. Inv." then begin
                    if PurchaseLine.IsServiceCharge() then
                        ERROR(CannotChangePrepaidServiceChargeErr);
                    PurchaseLine.FIELDERROR(PurchaseLine."Prepmt. Line Amount", STRSUBSTNO(Text037, PurchaseLine."Prepmt. Amt. Inv."));
                end;
                PrePaymentLineAmountEntered := false;
                if PurchaseLine."Prepmt. Line Amount" <> 0 then begin
                    RemLineAmountToInvoice :=
                      ROUND(PurchaseLine."Line Amount" * (PurchaseLine.Quantity - PurchaseLine."Quantity Invoiced") / PurchaseLine.Quantity, Currency."Amount Rounding Precision");
                    if RemLineAmountToInvoice < (PurchaseLine."Prepmt. Line Amount" - PurchaseLine."Prepmt Amt Deducted") then
                        PurchaseLine.FIELDERROR("Prepmt. Line Amount", STRSUBSTNO(Text039, RemLineAmountToInvoice + PurchaseLine."Prepmt Amt Deducted"));
                end;
            end else
                if (CurrentFieldNo <> 0) and (PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount") and
                   (PurchaseLine."Prepmt. Amt. Inv." <> 0) and (PurchaseLine."Prepayment %" = 100)
                then begin
                    if PurchaseLine."Line Amount" < xPurchaseLine."Line Amount" then
                        PurchaseLine.FIELDERROR("Line Amount", STRSUBSTNO(Text038, xPurchaseLine."Line Amount"));
                    PurchaseLine.FIELDERROR("Line Amount", STRSUBSTNO(Text039, xPurchaseLine."Line Amount"));
                end;
        end;
        PurchaseLine.UpdateVATAmounts();
        if VATBaseAmount <> PurchaseLine."VAT Base Amount" then
            LineAmountChanged := true;
        LineAmountChanged := LineAmountChanged or (NonDeductAmount <> NonDeductibleVAT.GetNonDeductibleVATAmount(PurchaseLine));

        if LineAmountChanged then begin
            PurchaseLine.UpdateDeferralAmounts();
            LineAmountChanged := false;
        end;

        PurchaseLine.InitOutstandingAmount();

        if PurchaseLine.Type = PurchaseLine.Type::"Charge (Item)" then
            PurchaseLine.UpdateItemChargeAssgnt();

        PurchaseLine.CalcPrepaymentToDeduct();
        IsHandled := true;
    end;
    //Record 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnUpdateVATAmountsOnAfterSetFilters', '', false, false)]
    local procedure OnUpdateVATAmountsOnAfterSetFilters(var PurchaseLine: Record "Purchase Line"; var PurchaseLine2: Record "Purchase Line")
    begin
        PurchaseLine2.SetRange("Tax Area Code");
    end;
    //TODO verifier line 3758
    //Record 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeAddItems', '', false, false)]
    local procedure OnBeforeAddItemsPL(var PurchaseLine: Record "Purchase Line"; SelectionFilter: Text; var IsHandled: Boolean)
    var
        ItemListPage: Page "Item List";
    begin
        SelectionFilter := ItemListPage.SelectActiveItemsForPurchase();
        if SelectionFilter = '' then
            IsHandled := true;
    end;

    //Record 39 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCheckWarehouseOnBeforeShowDialog', '', false, false)]
    local procedure OnCheckWarehouseOnBeforeShowDialogPL(var PurchLine: Record "Purchase Line"; Location2: Record Location; var ShowDialog: Option " ",Message,Error; var DialogText: Text[50])
    var
        Text017: Label '\The entered information may be disregarded by warehouse operations.';
        Text016: Label '%1 is required for %2 = %3.';
    begin
        case ShowDialog of
            ShowDialog::Message:
                Message(Text016 + Text017, DialogText, PurchLine.FieldCaption("Line No."), PurchLine."Line No.");
            ShowDialog::Error:
                Error(Text016, DialogText, PurchLine.FieldCaption("Line No."), PurchLine."Line No.");
        end;
        ShowDialog := ShowDialog::" ";
    end;
    //Record 60 
    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnSendVendorRecordsOnBeforeLookupProfile', '', false, false)]
    local procedure OnSendVendorRecordsOnBeforeLookupProfile(ReportUsage: Integer; RecordVariant: Variant; VendorNo: Code[20]; var RecRefToSend: RecordRef; SingleVendorSelected: Boolean; var ShowDialog: Boolean)
    begin
        ShowDialog := false;
    end;
    //Record 77 
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeGetEmailAddress', '', false, false)]
    local procedure OnBeforeGetEmailAddress(ReportUsage: Option; RecordVariant: Variant; var TempBodyReportSelections: Record "Report Selections" temporary; var EmailAddress: Text[250]; var IsHandled: Boolean; CustNo: Code[20])
    var
        DataTypeManagement: Codeunit "Data Type Management";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        DocumentNo: Code[20];
        GRecSalesHeader: Record "Sales Header";
        GRecContact: Record Contact;
        GRecSalesInvoiceHeader: Record "Sales Invoice Header";
        GRecPurchaseHeader: Record "Purchase Header";
    begin
        RecordRef.GetTable(RecordVariant);
        if not RecordRef.IsEmpty() then
            if DataTypeManagement.FindfieldByName(RecordRef, FieldRef, 'No.') then begin
                DocumentNo := FieldRef.Value;
                EmailAddress := TempBodyReportSelections.GetEmailAddressForDoc(DocumentNo, ReportUsage);
                if EmailAddress <> '' then begin
                    IsHandled := true;
                    exit;
                end;

            end;

        if not TempBodyReportSelections.IsEmpty() then begin
            EmailAddress :=
              TempBodyReportSelections.FindEmailAddressForEmailLayout(TempBodyReportSelections."Email Body Layout Code", CustNo, ReportUsage, Database::Customer);
            if EmailAddress <> '' then begin
                IsHandled := true;
                exit;
            end;
        end;
        //TODO check i change GetCustEmailAddress by GetEmailAddressForCust
        // r‚cup‚ration de l'adresse mail du contact indiqu‚ dans l'entˆte du document CV/Devis, CA, FV
        GRecSalesHeader.RESET();
        GRecSalesHeader.SETRANGE("No.", DocumentNo);
        GRecSalesInvoiceHeader.RESET();

        if GRecSalesHeader.FINDFIRST() then begin
            if (GRecContact.GET(GRecSalesHeader."Sell-to Contact No.")) and (GRecContact."E-Mail" <> '') then
                EmailAddress := GRecContact."E-Mail"
            else
                EmailAddress := TempBodyReportSelections.GetEmailAddressForCust(CustNo, ReportUsage);
            // EmailAddress := TempBodyReportSelections.GetEmailAddress(CustNo, ReportUsage);
        end else
            if GRecSalesInvoiceHeader.GET(DocumentNo) then begin
                if (GRecContact.GET(GRecSalesInvoiceHeader."Sell-to Contact No.")) and (GRecContact."E-Mail" <> '') then
                    EmailAddress := GRecContact."E-Mail"
                else
                    EmailAddress := TempBodyReportSelections.GetEmailAddressForCust(CustNo, ReportUsage);
                // EmailAddress := TempBodyReportSelections.GetCustEmailAddress(CustNo, ReportUsage);
            end else
                EmailAddress := TempBodyReportSelections.GetEmailAddressForCust(CustNo, ReportUsage);
        // EmailAddress := TempBodyReportSelections.GetCustEmailAddress(CustNo, ReportUsage);
        if EmailAddress <> '' then begin
            IsHandled := true;
            exit;
        end;
        if not RecordRef.IsEmpty() then
            if TempBodyReportSelections.IsSalesDocument(RecordRef) then
                if DataTypeManagement.FindfieldByName(RecordRef, FieldRef, 'Sell-to E-Mail') then begin
                    EmailAddress := FieldRef.Value;
                    if EmailAddress <> '' then begin
                        IsHandled := true;
                        exit;
                    end;
                end;
        IsHandled := true;
    end;
    //Record 77 
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeDoSaveReportAsHTML', '', false, false)]
    local procedure OnBeforeDoSaveReportAsHTML(ReportID: Integer; var FilePath: Text[250]; var RecordVariant: Variant; var IsHandled: Boolean)
    var
        LDelphiText: Text;
        LDelphiReportId: Text[80];
    begin
        LDelphiReportId := FORMAT(ReportID);
        if LDelphiReportId = '1304' then
            LDelphiText := REPORT.RUNREQUESTPAGE(ReportID);
    end;
    //TODO verify modif for quantities to skip standard code 1461....
    //Record 83 
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCalcBaseQty', '', false, false)]
    local procedure OnAfterCalcBaseQty(var ItemJournalLine: Record "Item Journal Line"; xItemJournalLine: Record "Item Journal Line"; FromFieldName: Text; var Result: Decimal)
    begin
        case FromFieldName of
            'Quantity':
                Result := ItemJournalLine.CalcBaseQty(ItemJournalLine.Quantity);
            'Invoiced Quantity':
                Result := ItemJournalLine.CalcBaseQty(ItemJournalLine."Invoiced Quantity");
            'Output Quantity':
                Result := ItemJournalLine.CalcBaseQty(ItemJournalLine."Output Quantity");
            'Scrap Quantity':
                Result := ItemJournalLine.CalcBaseQty(ItemJournalLine."Scrap Quantity");
        end;
    end;
    //Record 246 
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnBeforeInitRecordForOrderPlanning', '', false, false)]
    local procedure OnBeforeInitRecordForOrderPlanning(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    begin
        RequisitionLine.Init();
        RequisitionLine."Line No." := RequisitionLine."Line No." + 10000;
        RequisitionLine."Planning Line Origin" := RequisitionLine."Planning Line Origin"::"Order Planning";
        IsHandled := true;
    end;
    //Page 30
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnCreateItemFromTemplateOnBeforeCurrPageUpdate', '', false, false)]
    local procedure OnCreateItemFromTemplateOnBeforeCurrPageUpdate(var Item: Record Item)
    begin
        item."Price/Profit Calculation" := Item."Price/Profit Calculation"::"Price=Last Direct Cost+Profit";
    end;
    //Page 42
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeQueryClosePage', '', false, false)]
    local procedure OnBeforeQueryClosePage(var DocumentIsScheduledForPosting: Boolean; var SalesHeader: Record "Sales Header"; CloseAction: Action; ShowReleaseNotification: Boolean; DocumentIsPosted: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not DocumentIsScheduledForPosting and ShowReleaseNotification then
            if not InstructionMgt.ShowConfirmUnreleased() then begin
                Result := false;
                IsHandled := true;
                exit;
            end;
        //TODO check return
        //Result := true;
        IsHandled := true;
    end;
    //Page 46
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnBeforeSetDefaultType', '', false, false)]
    local procedure OnBeforeSetDefaultType(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            if xSalesLine."Document No." = '' then
                SalesLine.Type := SalesLine.Type::Item;
        IsHandled := true;
    end;
    //TODO line 1733
    //Page 46
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnBeforeDeltaUpdateTotals', '', false, false)]
    local procedure OnBeforeDeltaUpdateTotals(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; SuppressTotals: Boolean)
    begin
        // DocumentTotals.SalesDeltaUpdateTotals(SalesLine, xSalesLine, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    end;
    //Page 50
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterOnAfterGetRecord', '', false, false)]
    local procedure OnAfterOnAfterGetRecord(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Date" <> 0D then
            PurchaseHeader."Requested Receipt Date" := PurchaseHeader."Document Date";
    end;
    //Page 50
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted', '', false, false)]
    local procedure OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(var PurchaseHeader: Record "Purchase Header"; var ShowConfirmCloseUnposted: Boolean)
    begin
        ShowConfirmCloseUnposted := false;
    end;
    //Page 50
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeCalculateCurrentShippingAndPayToOption', '', false, false)]
    local procedure OnBeforeCalculateCurrentShippingAndPayToOption(var PurchaseHeader: Record "Purchase Header"; var ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address"; var PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address"; var IsHandled: Boolean)
    begin
        case true of
            PurchaseHeader."Sell-to Customer No." <> '':
                ShipToOptions := ShipToOptions::"Customer Address";
            PurchaseHeader."Location Code" <> '':
                ShipToOptions := ShipToOptions::Location;
            else
                if PurchaseHeader.ShipToAddressEqualsCompanyShipToAddress() then
                    ShipToOptions := ShipToOptions::"Default (Company Address)"
                else
                    ShipToOptions := ShipToOptions::"Custom Address";
        end;
        if (PurchaseHeader."Pay-to Vendor No." = PurchaseHeader."Buy-from Vendor No.") then
            PayToOptions := PayToOptions::"Default (Vendor)"
        else
            PayToOptions := PayToOptions::"Another Vendor";
        IsHandled := true;
    end;
    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostItemOnBeforeCheckInventoryPostingGroup', '', false, false)]
    local procedure OnPostItemOnBeforeCheckInventoryPostingGroup(var ItemJnlLine: Record "Item Journal Line"; var CalledFromAdjustment: Boolean; var Item: Record Item; var ItemTrackingCode: Record "Item Tracking Code")
    var
        PurchasingBlockedErr: label 'Vous ne pouvez pas acheter cet article, car la case à cocher Achat bloqué est activée sur la fiche article.';
        SalesBlockedErr: label 'Vous ne pouvez pas vendre cet article, car la case à cocher Vente bloquée est activée sur la fiche article.';
    begin
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Purchase then
            if not CalledFromAdjustment then
                if Item."Purchasing Blocked" then
                    ERROR(PurchasingBlockedErr);
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Sale then
            if not CalledFromAdjustment then
                if Item."Sales Blocked" then
                    ERROR(SalesBlockedErr);
    end;
    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnUpdateUnitCostOnAfterAssignLastDirectCost', '', false, false)]
    local procedure OnUpdateUnitCostOnAfterAssignLastDirectCost(var ValueEntry: Record "Value Entry"; var Item: Record Item; LastDirectCost: Decimal)
    var
        AMGFunctions: codeunit "AMG_Functions";
    begin
        //TODO verifier line 1331
        Item.Validate("Last Direct Cost", LastDirectCost);
        AMGFunctions.SetProperties(false);
    end;
    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnUpdateUnitCostOnBeforeUpdateUnitCost', '', false, false)]
    local procedure OnUpdateUnitCostOnBeforeUpdateUnitCost(ItemJournalLine: Record "Item Journal Line"; ValueEntry: Record "Value Entry"; Item: Record Item; var UpdateSKU: Boolean)
    var
        AMGFunctions: codeunit "AMG_Functions";
    begin
        AMGFunctions.SetProperties(false);
    end;
    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckItemCorrection', '', false, false)]
    local procedure OnBeforeCheckItemCorrection(ItemLedgerEntry: Record "Item Ledger Entry"; var RaiseError: Boolean)
    var
        Text025: Label 'Le lettrage des écritures avec une écriture de correction ne peut pas être annulé.';
    begin
        if RaiseError then
            Error(Text025);
    end;
    //Codeunit 22 //TODO verfier !!!!!!!!!!!!!!!!!!!!!
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeSetOrderAdjmtProperties', '', false, false)]
    local procedure OnBeforeSetOrderAdjmtProperties(ItemLedgEntryType: Option; OrderType: Option; OrderNo: Code[20]; OrderLineNo: Integer; OriginalPostingDate: Date; ValuationDate: Date; var IsHandled: Boolean; ItemJnlLine: Record "Item Journal Line")
    var
        ValueEntry: Record "Value Entry";
        InventoryAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)";
        ProdOrderLine: Record "Prod. Order Line";
        AssemblyHeader: Record "Assembly Header";
        ModifyOrderAdjmt: Boolean;
        AMGFunctions: Codeunit "AMG_Functions";
        ItemJN: Codeunit "Item Jnl.-Post Line";
    begin
        if not (OrderType in [ValueEntry."Order Type"::Production,
                            ValueEntry."Order Type"::Assembly])
      then
            exit;

        if ItemLedgEntryType in [ValueEntry."Item Ledger Entry Type"::Output,
                                 ValueEntry."Item Ledger Entry Type"::"Assembly Output"]
        then
            exit;

        if InventoryAdjmtEntryOrder.Get(OrderType, OrderNo, OrderLineNo) then begin
            if InventoryAdjmtEntryOrder."Allow Online Adjustment" or InventoryAdjmtEntryOrder."Cost is Adjusted" then begin
                InventoryAdjmtEntryOrder.LOCKTABLE();
                if InventoryAdjmtEntryOrder."Cost is Adjusted" then begin
                    InventoryAdjmtEntryOrder."Cost is Adjusted" := false;
                    ModifyOrderAdjmt := true;
                end;
                if InventoryAdjmtEntryOrder."Allow Online Adjustment" then begin
                    InventoryAdjmtEntryOrder."Allow Online Adjustment" := ItemJN.AllowAdjmtOnPosting(OriginalPostingDate);
                    ModifyOrderAdjmt := ModifyOrderAdjmt or not InventoryAdjmtEntryOrder."Allow Online Adjustment";
                end;
                if ModifyOrderAdjmt then
                    InventoryAdjmtEntryOrder.MODIFY();
            end;
        end else
            case OrderType of
                InventoryAdjmtEntryOrder."Order Type"::Production:
                    begin
                        AMGFunctions.GetProdOrderLine(ProdOrderLine, OrderNo, OrderLineNo);
                        InventoryAdjmtEntryOrder.SetProdOrderLine(ProdOrderLine);
                        AMGFunctions.SetOrderAdjmtProperties(ItemLedgEntryType, OrderType, OrderNo, OrderLineNo, OriginalPostingDate, ValuationDate);
                    end;
                InventoryAdjmtEntryOrder."Order Type"::Assembly:
                    begin
                        if OrderLineNo = 0 then begin
                            AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, OrderNo);
                            InventoryAdjmtEntryOrder.SetAsmOrder(AssemblyHeader);
                        end;
                        AMGFunctions.SetOrderAdjmtProperties(ItemLedgEntryType, OrderType, OrderNo, 0, OriginalPostingDate, ValuationDate);
                    end;
            end;
        IsHandled := true;
    end;
    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnCorrectOutputValuationDateOnBeforeValueEntryFindSet', '', false, false)]
    local procedure OnCorrectOutputValuationDateOnBeforeValueEntryFindSet(var ValueEntry: Record "Value Entry")
    var
        ValuationDate: Date;
        AMGFunctions: Codeunit "AMG_Functions";
    begin
        //TODO var global line 4811
        ValueEntry.SetFilter("Valuation Date", '');
        //ValuationDate := AMGFunctions.MaxConsumptionValuationDate(ItemLedgerEntry);
        ValueEntry.SetFilter("Valuation Date", '<%1', ValuationDate);
    end;
    //TODO codeunit 22 line 1215,1544,2247,2277,3082,3761,3980
    //Codeunit 83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeShowCreatedOrder', '', false, false)]
    local procedure OnBeforeShowCreatedOrder(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //Codeunit 83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnAfterSalesQuoteToOrderRun', '', false, false)]
    local procedure OnAfterSalesQuoteToOrderRun(var SalesHeader2: Record "Sales Header"; var SalesHeader: Record "Sales Header")
    var
        OfficeMgt: Codeunit "Office Management";
        SalesOrder: Page "Sales Order";
        OpenPage: Boolean;
        OpenNewInvoiceQst: Label 'The quote has been converted to order %1. Do you want to open the new order?', Comment = '%1 = No. of the new sales order document.';
        LRecHisto: Record "Sales Archive";
    begin
        if GuiAllowed() then
            if OfficeMgt.AttachAvailable() then
                OpenPage := true
            else
                OpenPage := Confirm(StrSubstNo(OpenNewInvoiceQst, SalesHeader2."No."), true);
        if OpenPage then begin
            Clear(SalesOrder);
            SalesOrder.CheckNotificationsOnce();
            SalesHeader2.SetRecFilter();
            SalesOrder.SetTableView(SalesHeader2);
            SalesOrder.Run();
        end;
        LRecHisto.DELDeleteDevis(SalesHeader."No.");
        LRecHisto.DELAddCmdVente(SalesHeader2."No.", SalesHeader2."Document Date");
    end;
    //Codeunit 229
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintSalesHeader', '', false, false)]
    local procedure OnBeforeDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean)
    var
        Selected: Integer;
        ReportSelections: Record "Report Selections";
        DocumentPrint: Codeunit "Document-Print";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin
            Selected := DIALOG.STRMENU('Devis,Proforma', 1, 'Choisissez le modŠle de document');
            if Selected = 2 then
                OnBeforeDoPrintSalesHeader(SalesHeader, ReportSelections.Usage::"S.Proforma", SendAsEmail, IsPrinted)
            else
                OnBeforeDoPrintSalesHeader(SalesHeader, ReportSelections.Usage::"S.Quote", SendAsEmail, IsPrinted);
        end else
            OnBeforeDoPrintSalesHeader(SalesHeader, DocumentPrint.GetSalesDocTypeUsage(SalesHeader), SendAsEmail, IsPrinted); //DEFAULT CODE

        if IsPrinted then
            exit;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) and (Selected = 2) then begin
            if SendAsEmail then
                ReportSelections.SendEmailToCust(
                ReportSelections.Usage::"S.Proforma", SalesHeader, SalesHeader."No.", SalesHeader.GetDocTypeTxt(), true, SalesHeader.GetBillToNo())
            else
                ReportSelections.PrintWithCheckForCust(ReportSelections.Usage::"S.Proforma", SalesHeader, SalesHeader.FIELDNO("Bill-to Customer No."));
        end else
            if SendAsEmail then
                ReportSelections.SendEmailToCust(
                  DocumentPrint.GetSalesDocTypeUsage(SalesHeader), SalesHeader, SalesHeader."No.", SalesHeader.GetDocTypeTxt(), true, SalesHeader.GetBillToNo())
            else
                ReportSelections.PrintWithCheckForCust(DocumentPrint.GetSalesDocTypeUsage(SalesHeader), SalesHeader, SalesHeader.FIELDNO("Bill-to Customer No."));
        IsPrinted := true;
    end;
    //Codeunit 703 //TODO check
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Find Record Management", 'OnAfterGetRecRefAndFieldsNoByType', '', false, false)]
    local procedure OnAfterGetRecRefAndFieldsNoByType(RecRef: RecordRef; Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)"; var SearchFieldNo: array[4] of Integer)
    var
        Item: Record Item;
    begin
        if Type = Type::Item then begin
            RecRef.Open(DATABASE::Item);
            SearchFieldNo[3] := Item.FIELDNO("No. 2");
        end;
    end;
    //TODO codeunit 260 line 363
    //TODO codeunit 703 line 118 not needed
    //Codeunit 5056
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustCont-Update", 'OnAfterOnModify', '', false, false)]
    local procedure OnAfterOnModify(var Contact: Record Contact; var OldContact: Record Contact; var Customer: Record Customer)
    begin
        Contact.VALIDATE("Mobile Phone No.", Customer."Mobile Phone No.");
        Contact.Modify(true);
        Customer.Get(Customer."No."); //TODO check line 54
    end;
    //Codeunit 5804
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ItemCostManagement", 'OnBeforeCheckUpdateLastDirectCost', '', false, false)]
    local procedure OnBeforeCheckUpdateLastDirectCost(var Item: Record Item; LastDirectCost: Decimal; var IsHandled: Boolean)
    begin
        if LastDirectCost <> 0 then
            Item.Validate("Last Direct Cost", LastDirectCost);
        IsHandled := true;
    end;
    //Codeunit 5804
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ItemCostManagement", 'OnBeforeUpdateUnitCostSKU', '', false, false)]
    local procedure OnBeforeUpdateUnitCostSKU(Item: Record Item; var SKU: Record "Stockkeeping Unit"; LastDirectCost: Decimal; NewStdCost: Decimal; MatchSKU: Boolean; CalledByFieldNo: Integer; var UnitCostUpdated: Boolean; var CalledFromAdjustment: Boolean)
    begin
        //TODO line 171
    end;
    //Codeunit 5804
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ItemCostManagement", 'OnBeforeCalcUnitCostFromAverageCost', '', false, false)]
    local procedure OnBeforeCalcUnitCostFromAverageCost(var Item: Record Item; var CostCalcMgt: Codeunit "Cost Calculation Management"; GLSetup: Record "General Ledger Setup"; var IsHandled: Boolean)
    var
        Currency: record Currency;
        AMGFunctions: codeunit "AMG_Functions";
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        RndgSetupRead: Boolean;
    begin
        with Item do begin
            CostCalcMgt.GetRndgSetup(GLSetup, Currency, RndgSetupRead);
            if AMGFunctions.CalculateAverageCost(Item, AverageCost, AverageCostACY) then begin
                if AverageCost <> 0 then
                    "Unit Cost" := Round(AverageCost, GLSetup."Unit-Amount Rounding Precision");
            end else begin
                AMGFunctions.CalcLastAdjEntryAvgCost(Item, AverageCost, AverageCostACY);
                if AverageCost <> 0 then
                    "Unit Cost" := Round(AverageCost, GLSetup."Unit-Amount Rounding Precision");
            end;
        end;
    end;

    //Record 79 //TODO Can't skip Standard Code
    [EventSubscriber(ObjectType::Table, Database::"Company Information", 'OnBeforeCheckIBAN', '', false, false)]
    local procedure OnBeforeCheckIBAN(IBANCode: Code[100])
    var
        CompanyInformation: Record "Company Information";
        OriginalIBANCode: Code[100];
        Modulus97: Integer;
        I: Integer;
    begin
        if IBANCode = '' then
            exit;
        IBANCode := DELCHR(IBANCode);
        Modulus97 := 97;
        if (STRLEN(IBANCode) <= 5) or (STRLEN(IBANCode) > 34) then
            CompanyInformation.IBANError(OriginalIBANCode);
        CompanyInformation.ExtConvertIBAN(IBANCode);
        while STRLEN(IBANCode) > 6 do
            IBANCode := CompanyInformation.CalcModulus(COPYSTR(IBANCode, 1, 6), Modulus97) + COPYSTR(IBANCode, 7);
        EVALUATE(I, IBANCode);
        if (I mod Modulus97) <> 1 then
            CompanyInformation.IBANError(OriginalIBANCode);
        //IBANCode := '';
    end;

    //Record 81
    [EventSubscriber(ObjectType::table, Database::"Gen. Journal Line", 'OnValidateAccountTypeOnBeforeCheckKeepDescription', '', false, false)]
    local procedure OnValidateAccountTypeOnBeforeCheckKeepDescription(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line"; CurrentFieldNo: Integer)
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        if GenJournalLine."Source Code" = SourceCodeSetup."Trans. Bank Rec. to Gen. Jnl." then begin
            if GenJournalLine.Description = '' then GenJournalLine.VALIDATE(Description, '');
        end
        else
            GenJournalLine.VALIDATE(Description, '');
    end;

    //Record 81
    [EventSubscriber(ObjectType::table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    end;

    //Page 39
    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnBeforeSelectTemplate', '', false, false)]
    local procedure OnBeforeSelectTemplate(var GenJournalLine: Record "Gen. Journal Line"; var GenJnlManagement: Codeunit GenJnlManagement; var IsHandled: Boolean)
    var
        JnlSelected: Boolean;
    begin
        if GenJournalLine."Journal Template Name" = '' then begin
            GenJnlManagement.TemplateSelection(PAGE::"General Journal", Enum::"Gen. Journal Template Type"::General, false, GenJournalLine, JnlSelected);
            if not JnlSelected then
                Error('');
        end;
        IsHandled := true;
    end;

    //Codeunit 80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        LRecHisto: Record "Sales Archive";
    begin
        //DELPHI AUB 01.07.2020
        LRecHisto.DELTransfCmdFactV(SalesHeader."No.", SalesInvHdrNo);
        //END DELPHI AUB
    end;


    //Codeunit 80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentLineOnAfterInitQuantityFields', '', false, false)]
    local procedure OnInsertShipmentLineOnAfterInitQuantityFields(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine."Outstandin Qty report" := xSalesLine."Outstanding Quantity" - SalesShptLine.Quantity;
    end;


    //Codeunit365
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderSellTo', '', false, false)]
    local procedure OnBeforeSalesHeaderSellTo(var AddrArray: array[8] of Text[100]; var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    var
        FormatAddress: Codeunit "Format Address";
    begin
        with SalesHeader do
            FormatAddress.FormatAddr(
                AddrArray, "Sell-to Customer Name", "Sell-to Customer Name 2", '', "Sell-to Address", "Sell-to Address 2",
                "Sell-to City", "Sell-to Post Code", "Sell-to County", "Sell-to Country/Region Code");
        Handled := true;
    end;

    //Codeunit365
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvBillTo', '', false, false)]
    local procedure OnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        FormatAddress: Codeunit "Format Address";
    begin
        with SalesInvHeader do
            FormatAddress.FormatAddr(
              AddrArray, "Bill-to Name", "Bill-to Name 2", '', "Bill-to Address", "Bill-to Address 2",
              "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code");
        Handled := true;
    end;

    //Codeunit5703
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Catalog Item Management", 'OnBeforeCreateNewItem', '', false, false)]
    local procedure OnBeforeCreateNewItem(var NonstockItem: Record "Nonstock Item"; var IsHandled: Boolean)
    var
        Item: Record Item;
        CatalogItemManagement: Codeunit "Catalog Item Management";
        ItemTemplMgt: Codeunit "Item Templ. Mgt.";
        ItemTempl: Record "Item Templ.";
    begin
        Item.Init();
        Item."No." := NonstockItem."Item No.";
        Item.Insert();

        ItemTempl.Get(NonstockItem."Item Templ. Code");
        ItemTemplMgt.ApplyItemTemplate(Item, ItemTempl, true);// TODO Verif

        Item."No. Series" := NonstockItem."Item No. Series";
        Item.Description := NonstockItem.Description;
        Item.Validate(Description, Item.Description);
        Item.Validate("Base Unit of Measure", NonstockItem."Unit of Measure");
        Item."Unit Price" := NonstockItem."Unit Price";
        Item."Unit Cost" := NonstockItem."Negotiated Cost";
        Item.VALIDATE("Last Direct Cost", NonstockItem."Negotiated Cost");
        if Item."Costing Method" = Item."Costing Method"::Standard then
            Item."Standard Cost" := NonstockItem."Negotiated Cost";
        Item."Automatic Ext. Texts" := false;
        Item.Validate("Vendor No.", NonstockItem."Vendor No.");
        Item."Vendor Item No." := NonstockItem."Vendor Item No.";
        Item."Net Weight" := NonstockItem."Net Weight";
        Item."Gross Weight" := NonstockItem."Gross Weight";
        Item."Manufacturer Code" := NonstockItem."Manufacturer Code";
        Item."Created From Nonstock Item" := true;
        Item.Modify();

        ItemTemplMgt.InsertDimensions(Item."No.", NonstockItem."Item Templ. Code", Database::Item, Database::"Item Templ.");
        Item.Get(NonstockItem."Item No.");

    end;
}