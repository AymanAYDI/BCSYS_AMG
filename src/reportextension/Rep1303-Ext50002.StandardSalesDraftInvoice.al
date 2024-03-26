namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Item;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.VAT.Clause;

reportextension 50002 "StandardSalesDraftInvoice" extends "Standard Sales - Draft Invoice" //1303
{

    dataset
    {
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                // DEB DELPHI XAV Livraison - Transport - Bank
                if ShipmentMethod.GET(Header."Shipment Method Code") then begin
                    if GrecTraductionTransport.GET(ShipmentMethod.Code, Header."Language Code") then
                        GTxtTraductionTransport := GrecTraductionTransport.Description
                    else
                        GTxtTraductionTransport := ShipmentMethod.Description;
                    if ShipmentMethod.Incoterms then
                        ShipmentMethod.Description := GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison" + ' - Incoterms , 2010'
                    else
                        ShipmentMethod.Description := ShipmentMethod.Code + ' ' + GTxtTraductionTransport + ' - ' + Header."Compl. cond. livraison";
                end;
                if GrecTransporteur.GET(Header."Shipping Agent Code") then
                    GTxtTransporteur := GrecTransporteur.Name
                else
                    GTxtTransporteur := Header."Shipping Agent Code";
                CompanyInfo."Bank Name" := CompanyInfo."Bank Name";
                CompanyInfo."Bank Branch No." := CompanyInfo."Bank Branch No.";
                CompanyInfo."Bank Account No." := CompanyInfo."Bank Account No.";
                CompanyInfo.IBAN := CompanyInfo.IBAN;
                CompanyInfo."SWIFT Code" := CompanyInfo."SWIFT Code";

                if GRecCountry.GET(CompanyInfo."Country/Region Code") then
                    GTxtCompanyInfoPays := GRecCountry.Name
                else
                    GTxtCompanyInfoPays := CompanyInfo.County;

                GTxtNumTVAClient := '';
                GTxtNumTVAClient_Lbl := '';
                if GRecCust2.GET("Sell-to Customer No.") then
                    if GRecCust2."VAT Registration No." <> '' then begin
                        GTxtNumTVAClient := GRecCust2."VAT Registration No.";
                        GTxtNumTVAClient_Lbl := VATIdentifier + ' :';
                    end;
                //FIN DELPHI XAV
            end;
        }
        add(Header)
        {
            column(CompanyInfoPays; GTxtCompanyInfoPays)
            {
            }
            column(CompanyNoEORI; CompanyInfo."No. EORI")
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
            // column(EMail_Lbl;GTxtCompanyHomepage)
            // {//TODO Column replaced
            // }
            // column(HomePage_Lbl;GTxtCompanyHomepage)
            // {//TODO Column replaced
            // }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyFaxNo_Lbl; GTxtCompanyFaxNo)
            {
            }
            column(CompanyGesch; GTxtCompanyGesch)
            {
            }
            column(CompanyTrib; GTxtCompanyTrib)
            {
            }
            column(SalesPersonPhone; SalespersonPurchaser."Phone No.")
            {
            }
            column(SalesPersonEmail; SalespersonPurchaser."E-Mail")
            {
            }
            column(ShipAgent; Cust."Shipping Agent Code")
            {
            }
            column(NomTransporteur; GTxtTransporteur)
            {
            }
            column(MentionLegalFR; GTxTMentionLegaleFR)
            {
            }
            column(NumTVAClient_Lbl; GTxtNumTVAClient_Lbl)
            {
            }
            column(NumTVAClient; GTxtNumTVAClient)
            {
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                // DEB DELPHI XAV
                if GRecItem.GET(Line."No.") then
                    GTxtNomenclatureArticle := GRecItem."Tariff No."
                else
                    GTxtNomenclatureArticle := '';

                //DELPHI AUB 18/02/2019
                GTxtItemNo := Line."No.";
                if Line.Type = Line.Type::Item then
                    if Line."Item Reference No." <> '' then
                        GTxtItemNo := Line."Item Reference No.";
                //END DELPHI AUB
            end;
        }
        add(Line)
        {
            column(Description2_Line; Line."Description 2")
            {
            }
            column(NomenclatureArticle; GTxtNomenclatureArticle)
            {
            }
        }
        modify(VATAmountLine)
        {
            trigger OnAfterAfterGetRecord()//TODO So needs Verif 
            var
                VATClause: Record "VAT Clause";
            begin
                // DEB DELPHI XAV
                if VATClause.GET(Line."VAT Clause Code") then begin
                    VATClause.TranslateDescription(Header."Language Code");
                    GTxtVATClause1 += ' ' + VATClause.Description + ' ' + VATClause."Description 2";
                end;
            end;
        }
        add(VATClauseLine)
        {
            column(VATClause1; GTxtVATClause1)
            {
            }
        }
        modify(Totals)
        {
            trigger OnAfterAfterGetRecord()
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
            column(TotalVATDisplay; GTxtDisplayTotalAmountVAT)
            {
            }
            column(TotalTTCDisplay; GTxtDisplayTotalAmountInclVAT)
            {
            }
            column(TotalVATDisplay_Lbl; GTxtTotalTVA_Lbl)
            {
            }
            column(TotalTTCDisplay_Lbl; GTxtVATClause1)
            {
            }
        }
    }
    var
        GRecCountry: Record "Country/Region";
        GRecCust2: Record Customer;
        GrecTransporteur: Record "Shipping Agent";
        GRecItem: Record Item;
        GRecBank: Record "Bank Account";
        GrecTraductionTransport: Record "Shipment Method Translation";
        GTxtCondLivraisonEtendues: Text[150];
        GTxtTransporteur: Text[80];
        GTxtNomenclatureArticle: Text[20];
        GTxtBankName: Text[50];
        GTxtBankBranchNo: Text[20];
        GTxtBankAcountNo: Text[30];
        GTxtBankIBAN: Text[50];
        GTxtBankSwift: Text[20];
        GTxtVATClause1: Text[1024];
        GTxtTraductionTransport: Text[80];
        GTxtCompanyInfoPays: Text[50];
        GTxtBrand: Text[50];
        GTxtColor: Text[50];
        GTxTGrade: Text[50];
        GTxtNumTVAClient: Text[60];
        GTxtNumTVAClient_Lbl: Text[60];
        GTxtSelltoAddr: array[8] of Text[50];
        GTxtItemNo: Text[20];
        GTxtCompanyBankBranch: Label 'Bk Code';
        GTxtCompanyPhoneNo: Label 'Phone';
        GTxtCompanyFaxNo: Label 'Fax.';
        GTxtCompanyHomepage: Label 'Website';
        GTxtCompanyemail: Label 'E-Mail';
        GTxtCompanyVAT: Label 'VAT Id. Num.';
        GTxtCompanyGesch: Label 'Director';
        GTxtCompanySitz: Label 'H.Q.';
        GTxtCompanyBankNr: Label 'Bk Num.';
        GTxtCompanyTrib: Label 'Trial court';
        GTxtCompanyBankSWIFT: Label 'SWIFT';
        GTxtCompanySalespers: Label 'Agent';
        GTxtCustomerNum: Label 'Customer num.';
        GTxtQuantity_Line_Lbl: Label 'Qty';
        GTxtUnitOfMeasure_Lbl: Label 'Unit';
        GTxtUnitPrice_Lbl: Label 'Unit Price';
        GTxtItemNo_Line_Lbl: Label 'Item No.';
        GTxtDocumentTitle: Label 'Proforma Invoice';
        GTxTMentionLegaleFR: Label 'Late payments are subject to a monthly interest of 1.5%. No discount for earlyment.';
        VATIdentifier: Label 'VAT Identifier';
        GTxtDisplayTotalAmountVAT: Text[50];
        GTxtDisplayTotalAmountInclVAT: Text[50];
        GTxtTotalTTC_Lbl: Text[50];
        GTxtTotalTVA_Lbl: Text[50];
}
