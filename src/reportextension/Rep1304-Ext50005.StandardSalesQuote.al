namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Shipping;
using Microsoft.Bank.BankAccount;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;

reportextension 50005 "StandardSalesQuote" extends "Standard Sales - Quote" //1304
{
    dataset
    {
        modify(Header)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                //DEB DELPHI XAV
                Header.CALCFIELDS("Net Weight", "Gross Weight");
                //FIN DELPHI XAV
                //DELPHI AUB 16.07.2019 edited 14.10.2019
                if GBooProforma then begin
                    GtxtDocumentTitle_Lbl := 'Facture Pro-forma Nø ';
                    GTxtDocumentNo := Header."No.";
                    GTxtDocumentNo := CONVERTSTR(GTxtDocumentNo, 'DV', 'PF');
                end else begin
                    GtxtDocumentTitle_Lbl := 'Devis';
                    GTxtDocumentNo := Header."No.";
                end;
                //END DELPHI
            end;

            trigger OnAfterAfterGetRecord()
            begin
                // DELPHI AUB 15.07.2019
                GTxtCompanyVAT := 'No. TVA';
                if Customer.ICE then
                    GTxtCompanyVAT := 'No. ICE';
                if Customer."VAT Registration No." = '' then
                    GTxtCompanyVAT := '';


                // DEB DELPHI XAV Livraison
                if ShipmentMethod.GET(Header."Shipment Method Code") then
                    if GrecTraductionTransport.GET(ShipmentMethod.Code, Header."Language Code") then
                        GTxtTraductionTransport := GrecTraductionTransport.Description
                    else
                        GTxtTraductionTransport := ShipmentMethod.Description;
                if ShipmentMethod.Incoterms then
                    GTxtCondLivraisonEtendues := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison" + ' - Incoterms ¸ 2010'
                else
                    GTxtCondLivraisonEtendues := ShipmentMethod.Code + ' ' + GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison";
                GTxtBankName := CompanyInfo."Bank Name";
                GTxtBankBranchNo := CompanyInfo."Bank Branch No.";
                GTxtBankAcountNo := CompanyInfo."Bank Account No.";
                GTxtBankIBAN := CompanyInfo.IBAN;
                GTxtBankSwift := CompanyInfo."SWIFT Code";

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;

                if GRecCust2.GET("Sell-to Customer No.") then
                    GTxtNumTVAClient := GRecCust2."VAT Registration No.";
            end;
        }
        add(header)
        {
            column(CompanyInfoPays; GTxtCompanyInfoPays)
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
            {
            }
            column(CompanyRCS_Lbl; GTxtCompanyTrib)
            {
            }
            column(CompanySiŠge_Lbl; GTxtCompanySitz)
            {
            }
            column(CompanyDirector_Lbl; GTxtCompanyGesch)
            {
            }
            column(CompanyNoEORI_Lbl; CompanyInfo.FIELDCAPTION("No. EORI"))
            {
            }
            column(SelltoAddress1; GTxtSelltoAddr[1])
            {
            }
            column(SelltoAddress2; GTxtSelltoAddr[2])
            {
            }
            column(SelltoAddress3; GTxtSelltoAddr[3])
            {
            }
            column(SelltoAddress4; GTxtSelltoAddr[4])
            {
            }
            column(SelltoAddress5; GTxtSelltoAddr[5])
            {
            }
            column(SelltoAddress6; GTxtSelltoAddr[6])
            {
            }
            column(SelltoAddress7; GTxtSelltoAddr[7])
            {
            }
            column(SelltoAddress8; GTxtSelltoAddr[8])
            {
            }
            // Column(EMail_Lbl; GTxtCompanyemail)
            // {//TODO 
            // }
            // Column(HomePage_Lbl; GTxtCompanyHomepage)
            // {
            // }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            { }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            { }
            column(Terms_Lbl; GTxtTerms_Lbl)
            { }
            column(Delivery_Lbl; GTxtDelivery_Lbl)
            { }
            column(Paymentterms_Lbl; GTxtPaymentterms_Lbl)
            { }
            column(Warranty_Lbl; GTxtWarranty_Lbl)
            { }
            column(Prices_Lbl; GTxtPrices_Lbl)
            { }
            column(Validity_Lbl; GTxtValidity_Lbl)
            { }
            column(TextLbl; GTxTextLbl)
            { }
            column(NetWeight; Header."Net Weight")
            { }
            column(GrossWeight; Header."Gross Weight")
            { }
            column(MentionLegalFR; GTxTMentionLegaleFR)
            { }
            column(NumTVAClient; GTxtNumTVAClient)
            { }
            column(ReferenceText; ReferenceText)
            { }
            column(PageCaption; STRSUBSTNO(Text005, ''))
            { }
            column(Delivery_time_Header; Header."Delivery time")
            { }
            column(Header_validity_period; Header."Validity period")
            { }
            column(DelaiLiv_Lbl; GTxtDelaiLiv_Lbl)
            { }
            column(DureeValid_Lbl; GTxtDureeValid_Lbl)
            { }
            column(DocumentNoFormat_Header; GTxtDocumentNo)
            { }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                LRecCountry: Record "Country/Region";
            begin
                // DEB DELPHI XAV
                if GRecItem.GET(Line."No.") then begin
                    //DEB DELPHI AUB 10.10.2019
                    if (GRecItem."Tariff No." <> '') and GBooAffichageOrigine then
                        GTxtNomenclatureArticle := 'TD :' + GRecItem."Tariff No."
                    else
                        GTxtNomenclatureArticle := '';
                    if (GRecItem."Country/Region of Origin Code" <> '') and GBooAffichageOrigine then begin
                        if LRecCountry.GET(GRecItem."Country/Region of Origin Code") then
                            GTxtCodeRegionOrigine := ' Origine: ' + LRecCountry.Name
                    end else
                        GTxtCodeRegionOrigine := '';
                    //END DELPHI AUB
                    GTxtBrand := GRecItem.Brand;
                    GTxTGrade := GRecItem.Grade;
                    GTxtColor := GRecItem.Color;
                end
                else begin
                    GTxtNomenclatureArticle := '';
                    GTxtBrand := '';
                    GTxTGrade := '';
                    GTxtColor := '';
                    GTxtCodeRegionOrigine := ''; //DELPHI AUB
                end;

                // FIN DELPHI XAV
                //DELPHI AUB 18/02/2019
                GTxtItemNo := Line."No.";
                if Line.Type = Line.Type::Item then
                    if Line."Item Reference No." <> '' then
                        GTxtItemNo := Line."Item Reference No.";

                if (Line.Quantity = 0) then begin
                    GTxtQty := '';
                    GTxtPrixUnitaire := '';
                    GTxtMontantLigne := '';
                end else begin
                    GTxtQty := FORMAT(Line.Quantity);
                    GTxtMontantLigne := FORMAT(Line.Amount);
                    GTxtPrixUnitaire := FORMAT(Line."Unit Price");
                end;
                //END DELPHI AUB
            end;
        }
        add(Line)
        {
            column(Description2_Line; "Description 2")
            { }
            column(LineDiscountAmount_Line; Line."Line Discount Amount")
            { }
            column(ItemNoOrRef_Line; GTxtItemNo)
            { }
            column(Reference_Externe; Line."Item Reference No.")
            { }
            column(NomenclatureArticle; GTxtNomenclatureArticle)
            { }
            column(CodeRegionOrigine; GTxtCodeRegionOrigine)
            { }
            column(Qty_Line; GTxtQty)
            { }
            column(UnitPrice_Line; GTxtPrixUnitaire)
            { }
            column(Amount_Line; GTxtMontantLigne)
            { }
        }
        modify(Totals)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                //DEB DELPHI AUB 15.10.2019
                GTxtDisplayTotalAmountVAT := '';
                GTxtDisplayTotalAmountInclVAT := '';
                GTxtTotalTVA_Lbl := '';
                GTxtTotalTTC_Lbl := '';
                if TotalAmountVAT > 0 then begin
                    GTxtDisplayTotalAmountVAT := FORMAT(TotalAmountVAT, 0, '<Integer Thousand><Decimals,3>');
                    GTxtDisplayTotalAmountInclVAT := FORMAT(TotalAmountInclVAT, 0, '<Integer Thousand><Decimals,3>');
                    GTxtTotalTVA_Lbl := 'Total EUR TVA';
                    GTxtTotalTTC_Lbl := 'Total EUR TTC';
                end;
                //END DELPHI AUB 15.10.2019
            end;
        }
        add(Totals)
        {
            column(TotalExcludingVATLbl; GTxtTotalHT_Lbl)
            { }
            column(TotalVATDisplay; GTxtDisplayTotalAmountVAT)
            { }
            column(TotalTTCDisplay; GTxtDisplayTotalAmountInclVAT)
            { }
            column(TotalVATDisplay_Lbl; GTxtTotalTVA_Lbl)
            { }
            column(TotalTTCDisplay_Lbl; GTxtTotalTTC_Lbl)
            { }
        }

    }
    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(GBooProforma; GBooProforma)
                {
                    Caption = 'Proforma invoice';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proforma invoice field.';
                }
                field(AffichageOrigine; GBooAffichageOrigine)
                {
                    Caption = 'Origin Display';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Origin Display field.';
                }
            }
        }
    }

    var
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        GRecItem: Record Item;
        GRecBank: Record "Bank Account";
        GrecTraductionTransport: Record "Shipment Method Translation";
        Customer: Record Customer;
        GBooAffichageOrigine: Boolean;
        GBooProforma: Boolean;
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanyemail: Label 'E-Mail';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyGesch: Label 'Director';
        GTxtCompanyHomepage: Label 'Website';
        GTxtCompanyPhoneNo: Label 'Phone';
        GTxtCompanySalespers: Label 'Agent';
        GTxtCompanySitz: Label 'H.Q.';
        GTxtCompanyTrib: Label 'Trial court';
        GTxtCustomerNum: Label 'DCustomer num.';
        GTxtDelaiLiv_Lbl: Label 'delivery time';
        GTxtDelivery_Lbl: Label 'Delivery';
        GTxtDureeValid_Lbl: Label 'Period of validity';
        GTxTextLbl: Label 'Free text typing';
        GTxtItemNo_Line_Lbl: Label 'Item No.';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.';
        GTxtPaymentterms_Lbl: Label 'Payment terms';
        GTxtPrices_Lbl: Label 'Prices';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtTerms_Lbl: Label 'Terms of delivery and payement';
        GTxtTotalHT_Lbl: Label 'FRA=Total EUR HT';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        GTxtValidity_Lbl: Label 'Validity';
        GTxtWarranty_Lbl: Label 'Warranty';
        ReferenceText: Label 'Your reference';
        Text005: Label 'Page %1';
        GTxtBankBranchNo: Text[20];
        GTxtBankSwift: Text[20];
        GTxtItemNo: Text[20];
        GTxtNomenclatureArticle: Text[20];
        GTxtBankAcountNo: Text[50];
        GTxtBankIBAN: Text[50];
        GTxtBankName: Text[50];
        GTxtBrand: Text[50];
        GTxtCodeRegionOrigine: Text[50];
        GTxtColor: Text[50];
        GTxtCompanyInfoPays: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDocumentNo: Text[50];
        GTxTGrade: Text[50];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
        GTxtNumTVAClient: Text[60];
        GTxtCompanyVAT: Text[80];
        GtxtDocumentTitle_Lbl: Text[80];
        GTxtMontantLigne: Text[80];
        GTxtPrixUnitaire: Text[80];
        GTxtQty: Text[80];
        GTxtTraductionTransport: Text[80];
        GTxtCondLivraisonEtendues: Text[120];
        GTxtDesignationComplete: Text[250];

    local procedure ZeroIsBlanckDecimal(Decimale: Decimal) Return: Text[150];
    begin
        if Decimale <> 0 then
            Return := FORMAT(Decimale, 10, '<Standard Format,0>')
        else
            Return := '';
    end;

    local procedure ZeroIsBlanckInteger(Integer: Integer) Return: Text[150];
    begin
        if Integer <> 0 then
            Return := FORMAT(Integer)
        else
            Return := '';
    end;
}
