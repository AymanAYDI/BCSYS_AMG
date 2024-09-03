namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.Reporting;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Receivables;
using Microsoft.Utilities;
using System.Utilities;
using System.IO;
using Microsoft.Finance.Currency;
using System.Reflection;
using Microsoft.CRM.Contact;

codeunit 50001 "AMG_Events"
{
    //Record 36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCheckShipmentInfo, '', false, false)]
    local procedure OnBeforeCheckShipmentInfo(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; BillTo: Boolean; var IsHandled: Boolean)
    begin
        if BillTo then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCheckNoAndShowConfirm, '', false, false)]
    local procedure OnBeforeCheckNoAndShowConfirm(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var SalesInvHeaderPrePmt: Record "Sales Invoice Header"; var SalesCrMemoHeaderPrePmt: Record "Sales Cr.Memo Header"; SourceCode: Record "Source Code"; var Result: Boolean; var IsHandled: Boolean)
    var
        LRecHist: Record "Historique ventes";
        ConfirmManagement: Codeunit "Confirm Management";
        Text009: Label 'Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche expédition. Une expédition vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
        Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
        Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche d''avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
        Text030: Label 'Deleting this document will cause a gap in the number series for return receipts. An empty return receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche des réceptions retour. Une réception retour vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
        Text056: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche des factures d''acompte. Une facture d''acompte vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
        Text057: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = 'FRA="La suppression de ce document va engendrer une discontinuité dans la souche des avoirs acompte. Un avoir acompte vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?"';
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

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCreateSalesLineOnBeforeValidateQuantity, '', false, false)]
    local procedure OnCreateSalesLineOnBeforeValidateQuantity(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; var ShouldValidateQuantity: Boolean)
    begin
        if ShouldValidateQuantity then begin
            SalesLine.Validate(Quantity, TempSalesLine.Quantity);
            SalesLine.Validate("Qty. to Assemble to Order", TempSalesLine."Qty. to Assemble to Order");
            SalesLine.Marge := TempSalesLine.Marge;
            SalesLine."Line Discount %" := TempSalesLine."Line Discount %";
            SalesLine.Validate(Marque, TempSalesLine.Marque);
            ShouldValidateQuantity := false;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCreateSalesLineOnBeforeSetDropShipment, '', false, false)]
    local procedure OnCreateSalesLineOnBeforeSetDropShipment(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        if SalesLine."Bill-to Customer No." <> TempSalesLine."Bill-to Customer No." then begin
            SalesLine."Purchasing Code" := TempSalesLine."Purchasing Code";
            SalesLine."Special Order Purchase No." := TempSalesLine."Special Order Purchase No.";
            SalesLine."Special Order Purch. Line No." := TempSalesLine."Special Order Purch. Line No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterCopySellToCustomerAddressFieldsFromCustomer, '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean; var SkipSellToContact: Boolean)
    begin
        SalesHeader."Compl. cond. livraison" := SellToCustomer."Compl. cond. livraison";
    end;
    //Record 37 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateNoOnAfterUpdateUnitPrice, '', false, false)]
    local procedure OnValidateNoOnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        OutCurrency: Record Currency;
        LRecItem: Record Item;
        OutSalesHeader: Record "Sales Header";
        XMLBuffer: Record "XML Buffer";
        XMLSpecialInterestNode: Record "XML Buffer";
        XMLBufferWriter: Codeunit "XML Buffer Writer";
        LCodItemNo: Code[20];
        LDecQty: Decimal;
        LTextParam: Text;
    begin
        //DELPHI AUB AMG.CARBO 01.03.2021
        LCodItemNo := '';
        LDecQty := 0;
        if LRecItem.Get(SalesLine."No.") then begin
            if LRecItem."Type carbo" then
                LTextParam := REPORT.RUNREQUESTPAGE(Report::DELInsertCarboAMG); //récupération des valeurs saisies sur la RequestPage
                                                                                //MESSAGE(LTextParam);
            if (LTextParam <> '') then begin

                XMLBufferWriter.InitializeXMLBufferFromText(XMLBuffer, LTextParam);
                XMLBuffer.SETFILTER(Path, '/ReportParameters/Options/Field/@name');
                XMLBuffer.SetRange(Value, 'ItemNo'); //on récupére le code article de l'emballage carbo
                if XMLBuffer.FINDLAST() then
                    if XMLSpecialInterestNode.Get(XMLBuffer."Parent Entry No.") then
                        LCodItemNo := CopyStr(XMLSpecialInterestNode.Value, 1, MaxStrLen(LCodItemNo));

                //On récupére la quantité
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

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, Quantity, false, false)]
    local procedure SalesLine_OnAfterValidateEvent_Quantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        Rec.FCalculeMarge();
        Rec.FCalculeMarque();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Unit Price", false, false)]
    local procedure SalesLine_OnAfterValidateEvent_UnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        Rec.FCalculeMarge();
        Rec.FCalculeMarque();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeValidateEvent, "Line Discount %", false, false)]
    local procedure SalesLine_OnBeforeValidateEvent_LineDiscount(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        Rec.FCalculateMargeOnLineDiscountChange();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Line Discount %", false, false)]
    local procedure SalesLine_OnAfterValidateEvent_LineDiscount(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        Rec.FCalculeMarge();
        Rec.FCalculeMarque();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Line Discount Amount", false, false)]
    local procedure SalesLine_OnAfterValidateEvent_LineDiscountAmount(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        Rec.FCalculeMarge();
        Rec.FCalculeMarque();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Unit of Measure Code", false, false)]
    local procedure SalesLine_OnAfterValidateEvent_Unit(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //>>> BC6 NC 18042024 AMG-6 Delete Code From page and add it to Table
        Rec.FCalculeMarge();
        Rec.FCalculeMarque();
    end;

    //Record 38 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeSendRecords, '', false, false)]
    local procedure OnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        ReportSelections: Record "Report Selections";
        Selected: Integer;
        PurchQuoteTxt: label 'Purchase - Quote', Comment = 'FRA="Demande de prix"';
        TextDemande: Label 'Choisisez votre impression :';
        TextSTR: Label 'Commande achat,Commande achat avec attestation TVA';
        DocTxt: Text[150];
    begin
        Selected := DIALOG.STRMENU(TextSTR, 1, TextDemande);
        if Selected = 1 then
            DocumentSendingProfile.SendVendorRecords(
              ReportSelections.Usage::"P.Order".AsInteger(), PurchaseHeader, DocTxt, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."No.",
              PurchaseHeader.FieldNo("Buy-from Vendor No."), PurchaseHeader.FieldNo("No."))
        else
            if Selected = 2 then
                DocumentSendingProfile.SendVendorRecords(
                  ReportSelections.Usage::"P.OrderVAT".AsInteger(), PurchaseHeader, DocTxt, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."No.",
                  PurchaseHeader.FieldNo("Buy-from Vendor No."), PurchaseHeader.FieldNo("No."));

        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Quote then
            DocumentSendingProfile.SendVendorRecords(
                ReportSelections.Usage::"P.Quote".AsInteger(), PurchaseHeader, PurchQuoteTxt, PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."No.",
                PurchaseHeader.FIELDNO("Buy-from Vendor No."), PurchaseHeader.FieldNo("No."));
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforePrintRecords, '', false, false)]
    local procedure OnBeforePrintRecords(var PurchaseHeader: Record "Purchase Header"; ShowRequestForm: Boolean; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        Selected: Integer;
        TextDemande: Label 'Choisisez votre impression :';
        TextSTR: Label 'Commande achat,Commande achat avec attestation TVA';
    begin
        Selected := DIALOG.STRMENU(TextSTR, 1, TextDemande);
        if Selected = 1 then
            DocumentSendingProfile.TrySendToPrinterVendor(
              DummyReportSelections.Usage::"P.Order".AsInteger(), PurchaseHeader, PurchaseHeader.FieldNo("Buy-from Vendor No."), ShowRequestForm)
        else
            if Selected = 2 then
                DocumentSendingProfile.TrySendToPrinterVendor(
                 DummyReportSelections.Usage::"P.OrderVAT".AsInteger(),
                 PurchaseHeader, PurchaseHeader.FIELDNO("Buy-from Vendor No."), ShowRequestForm);
        IsHandled := true;
    end;

    //Record 60 
    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", OnSendVendorRecordsOnBeforeLookupProfile, '', false, false)]
    local procedure OnSendVendorRecordsOnBeforeLookupProfile(ReportUsage: Integer; RecordVariant: Variant; VendorNo: Code[20]; var RecRefToSend: RecordRef; SingleVendorSelected: Boolean; var ShowDialog: Boolean)
    begin
        ShowDialog := false;
    end;

    //Record 77 
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnGetEmailAddressOnAfterGetEmailAddressForCust, '', false, false)]
    local procedure OnGetEmailAddressOnAfterGetEmailAddressForCust(ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var TempBodyReportSelections: Record "Report Selections" temporary; var EmailAddress: Text[250]; CustNo: Code[20])
    var
        GRecContact: Record Contact;
        GRecSalesHeader: Record "Sales Header";
        GRecSalesInvoiceHeader: Record "Sales Invoice Header";
        DataTypeManagement: Codeunit "Data Type Management";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        DocumentNo: Code[20];
    begin
        RecordRef.GetTable(RecordVariant);
        if not RecordRef.IsEmpty() then
            if DataTypeManagement.FindfieldByName(RecordRef, FieldRef, 'No.') then
                DocumentNo := FieldRef.Value();

        // récupération de l'adresse mail du contact indiqué dans l'entˆte du document CV/Devis, CA, FV
        GRecSalesHeader.Reset();
        GRecSalesHeader.SetRange("No.", DocumentNo);
        GRecSalesInvoiceHeader.Reset();

        if GRecSalesHeader.FINDFIRST() then begin
            if (GRecContact.GET(GRecSalesHeader."Sell-to Contact No.")) and (GRecContact."E-Mail" <> '') then
                EmailAddress := GRecContact."E-Mail"
            else
                EmailAddress := TempBodyReportSelections.GetEmailAddressForCust(CustNo, ReportUsage);
        end else
            if GRecSalesInvoiceHeader.GET(DocumentNo) then
                if (GRecContact.GET(GRecSalesInvoiceHeader."Sell-to Contact No.")) and (GRecContact."E-Mail" <> '') then
                    EmailAddress := GRecContact."E-Mail"
                else
                    EmailAddress := TempBodyReportSelections.GetEmailAddressForCust(CustNo, ReportUsage);
    end;

    //Record 81
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnValidateAccountTypeOnBeforeCheckKeepDescription, '', false, false)]
    local procedure OnValidateAccountTypeOnBeforeCheckKeepDescription(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line"; CurrentFieldNo: Integer)
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        if SourceCodeSetup.Get() then;
        if GenJournalLine."Source Code" = SourceCodeSetup."Trans. Bank Rec. to Gen. Jnl." then begin
            if GenJournalLine.Description = '' then
                GenJournalLine.Validate(Description, '')
            else
                GenJournalLine."Keep Description" := true;
        end
        else
            GenJournalLine.Validate(Description, '');
    end;
    //Page 30
    [EventSubscriber(ObjectType::Page, Page::"Item Card", OnCreateItemFromTemplateOnBeforeCurrPageUpdate, '', false, false)]
    local procedure OnCreateItemFromTemplateOnBeforeCurrPageUpdate(var Item: Record Item)
    begin
        Item."Price/Profit Calculation" := Item."Price/Profit Calculation"::"Price=Last Direct Cost+Profit";
    end;
    //Page 50
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted, '', false, false)]
    local procedure OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(var PurchaseHeader: Record "Purchase Header"; var ShowConfirmCloseUnposted: Boolean)
    begin
        ShowConfirmCloseUnposted := false;
    end;
    //Page 347
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Purchase", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Purchase")
    begin
        if ReportUsage2 = ReportUsage2::"P.OrderVAT" then
            Rec.SETRANGE(Usage, Rec.Usage::"P.OrderVAT");
    end;

    //Codeunit 22
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnUpdateUnitCostOnAfterAssignLastDirectCost, '', false, false)]
    local procedure OnUpdateUnitCostOnAfterAssignLastDirectCost(var ValueEntry: Record "Value Entry"; var Item: Record Item; LastDirectCost: Decimal)
    begin
        Item.Validate("Last Direct Cost", LastDirectCost);
    end;

    //Codeunit 80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        LRecHisto: Record "Historique ventes";
    begin
        LRecHisto.DELTransfCmdFactV(SalesHeader."No.", SalesInvHdrNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnInsertShipmentLineOnAfterInitQuantityFields, '', false, false)]
    local procedure OnInsertShipmentLineOnAfterInitQuantityFields(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine."Outstandin Qty report" := xSalesLine."Outstanding Quantity" - SalesShptLine.Quantity;
    end;
    //Codeunit 83
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", OnAfterSalesQuoteToOrderRun, '', false, false)]
    local procedure OnAfterSalesQuoteToOrderRun(var SalesHeader2: Record "Sales Header"; var SalesHeader: Record "Sales Header")
    var
        LRecHisto: Record "Historique ventes";
    begin
        LRecHisto.DELDeleteDevis(SalesHeader."No.");
        LRecHisto.DELAddCmdVente(SalesHeader2."No.", SalesHeader2."Document Date");
    end;
    //Codeunit 229
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", OnBeforeDoPrintSalesHeader, '', false, false)]
    local procedure OnBeforeDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean)
    var
        ReportSelections: Record "Report Selections";
        Selected: Integer;
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin
            Selected := DIALOG.STRMENU('Devis,Proforma', 1, 'Choisissez le modèle de document');
            if Selected = 0 then
                Error('');
            if Selected = 2 then begin
                if SendAsEmail then
                    ReportSelections.SendEmailToCust(
                        ReportSelections.Usage::"S.Proforma".AsInteger(), SalesHeader, SalesHeader."No.", SalesHeader.GetDocTypeTxt(), true, SalesHeader.GetBillToNo())
                else
                    ReportSelections.PrintForCust(ReportSelections.Usage::"S.Proforma", SalesHeader, SalesHeader.FieldNo("Bill-to Customer No."));
                IsPrinted := true;
            end;
        end;
    end;
    //Codeunit 365
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", OnBeforeSalesHeaderSellTo, '', false, false)]
    local procedure OnBeforeSalesHeaderSellTo(var AddrArray: array[8] of Text[100]; var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
            AddrArray, SalesHeader."Sell-to Customer Name", SalesHeader."Sell-to Customer Name 2", '', SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2",
            SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", OnBeforeSalesInvBillTo, '', false, false)]
    local procedure OnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
            AddrArray, SalesInvHeader."Bill-to Name", SalesInvHeader."Bill-to Name 2", '', SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2",
            SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code", SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
        Handled := true;
    end;
    //Codeunit 703
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Find Record Management", OnAfterGetRecRefAndFieldsNoByType, '', false, false)]
    local procedure OnAfterGetRecRefAndFieldsNoByType(RecRef: RecordRef; Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)"; var SearchFieldNo: array[4] of Integer)
    var
        Item: Record Item;
    begin
        if Type = Type::Item then
            SearchFieldNo[3] := Item.FIELDNO("No. 2");
    end;
    //Codeunit 5703
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Catalog Item Management", OnCreateNewItemOnBeforeItemModify, '', false, false)]
    local procedure OnCreateNewItemOnBeforeItemModify(var Item: Record Item; NonstockItem: Record "Nonstock Item")
    begin
        Item.Validate("Last Direct Cost", NonstockItem."Negotiated Cost");
    end;
    //Codeunit 5703
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", OnAfterValidateSalesReferenceNo, '', false, false)]
    local procedure OnAfterValidateSalesReferenceNo(var SalesLine: Record "Sales Line"; ItemReference: Record "Item Reference"; ReturnedItemReference: Record "Item Reference")
    var
        Item: Record Item;
    begin
        if SalesLine.Type <> SalesLine.Type::Item then
            exit;
        if SalesLine."No." = '' then
            exit;
        SalesLine.GetItem(Item);
        if ReturnedItemReference."Description 2" = '' then
            SalesLine."Description 2" := Item."Description 2";
    end;

    //Codeunit 5804
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ItemCostManagement", OnBeforeCheckUpdateLastDirectCost, '', false, false)]
    local procedure OnBeforeCheckUpdateLastDirectCost(var Item: Record Item; LastDirectCost: Decimal; var IsHandled: Boolean)
    begin
        if LastDirectCost <> 0 then
            Item.Validate("Last Direct Cost", LastDirectCost);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, OnAfterSubstituteReport, '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; RunMode: Option Normal,ParametersOnly,Execute,Print,SaveAs,RunModal; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        if ReportId = Report::Microsoft.Finance.GeneralLedger.Reports."G/L Detail Trial Balance" then
            NewReportId := Report::"G/L Detail Trial Balance";
        if ReportId = Report::Microsoft.Sales.Reports."Customer Detail Trial Balance" then
            NewReportId := Report::"Customer Detail Trial Balance";
        if ReportId = Report::Microsoft.Purchases.Reports."Vendor Detail Trial Balance FR" then
            NewReportId := Report::"Vendor Detail Trial Balance";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", OnAfterRecordChanged, '', false, false)]
    local procedure OnAfterRecordChanged(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean)
    begin
        IsChanged := IsChanged or
          (SalesShipmentHeader."Your Reference" <> xSalesShipmentHeader."Your Reference") or
            (SalesShipmentHeader."Compl. cond. livraison" <> xSalesShipmentHeader."Compl. cond. livraison");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."Your Reference" := FromSalesShptHeader."Your Reference";
        SalesShptHeader."Compl. cond. livraison" := FromSalesShptHeader."Compl. cond. livraison";
    end;
}