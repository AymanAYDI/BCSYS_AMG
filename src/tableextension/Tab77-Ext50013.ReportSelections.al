namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Reporting;
tableextension 50013 ReportSelections extends "Report Selections" //77
{
    //todo GetEmailBodyInPdf not used
    // procedure GetEmailBodyInPdf(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var CustEmailAddress: Text[250]): Boolean
    // var
    //     TempBodyReportSelections: Record "77" temporary;
    // begin
    //     ServerEmailBodyFilePath := '';

    //     CustEmailAddress := GetEmailAddressIgnoringLayout(ReportUsage, RecordVariant, CustNo);

    //     if not FindEmailBodyUsage(ReportUsage, CustNo, TempBodyReportSelections) then
    //         exit(false);

    //     ServerEmailBodyFilePath :=
    //       SaveReportAsPDF(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Email Body Layout Code");

    //     CustEmailAddress := GetEmailAddress(ReportUsage, RecordVariant, CustNo, TempBodyReportSelections);

    //     exit(true);
    // end;

    procedure FindEmailAddressForEmailLayout(LayoutCode: Code[20]; AccountNo: Code[20]; ReportUsage: Enum "Report Selection Usage"; TableNo: Integer): Text[200]
    var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        // Search for a potential email address from Custom Report Selections
        GetCustomReportSelectionByUsageOption(CustomReportSelection, AccountNo, ReportUsage, TableNo);
        CustomReportSelection.UpdateSendtoEmail(false);
        CustomReportSelection.SetFilter("Send To Email", '<>%1', '');
        CustomReportSelection.SetRange("Email Body Layout Code", LayoutCode);
        if CustomReportSelection.FindFirst() then
            exit(CustomReportSelection."Send To Email");

        // Relax the filter and search for an email address
        CustomReportSelection.SetFilter("Use for Email Body", '');
        CustomReportSelection.SetRange("Email Body Layout Code", '');
        if CustomReportSelection.FindFirst() then
            exit(CustomReportSelection."Send To Email");
        exit('');
    end;



    //todo check prod GetHtmlReport 
    //todo prod SendEmailToCust
    //todo prod SendEmailTovendor
    //todo prod  SendEmailToVendorDirectly
}

