report 50399 "Update Report Selection"
{
    Caption = 'Update Report Selection';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {

        dataitem("Custom Report Selection"; "Custom Report Selection")
        {
            trigger OnAfterGetRecord()
            begin
                case "Report ID" of
                    1303:
                        "Report ID" := 50303;
                    1304:
                        "Report ID" := 50304;
                    1305:
                        "Report ID" := 50305;
                    1306:
                        "Report ID" := 50306;
                    1307:
                        "Report ID" := 50307;
                end;
                Modify();
            end;
        }
        dataitem("Custom Report Layout"; "Custom Report Layout")
        {
            trigger OnAfterGetRecord()
            begin
                case "Report ID" of
                    1303:
                        "Report ID" := 50303;
                    1304:
                        "Report ID" := 50304;
                    1305:
                        "Report ID" := 50305;
                    1306:
                        "Report ID" := 50306;
                    1307:
                        "Report ID" := 50307;
                end;
                Modify();
            end;
        }
        dataitem("Report Layout Selection"; "Report Layout Selection")
        {
            trigger OnAfterGetRecord()
            begin
                case "Report ID" of
                    1303:
                        "Report ID" := 50303;
                    1304:
                        "Report ID" := 50304;
                    1305:
                        "Report ID" := 50305;
                    1306:
                        "Report ID" := 50306;
                    1307:
                        "Report ID" := 50307;
                end;
                Modify();
            end;
        }

        dataitem("Report Layout Update Log"; "Report Layout Update Log")
        {
            trigger OnAfterGetRecord()
            begin
                case "Report ID" of
                    1303:
                        "Report ID" := 50303;
                    1304:
                        "Report ID" := 50304;
                    1305:
                        "Report ID" := 50305;
                    1306:
                        "Report ID" := 50306;
                    1307:
                        "Report ID" := 50307;
                end;
                Modify();
            end;
        }
        dataitem("Report Selections"; "Report Selections")
        {
            trigger OnAfterGetRecord()
            begin
                case "Report ID" of
                    1303:
                        "Report ID" := 50303;
                    1304:
                        "Report ID" := 50304;
                    1305:
                        "Report ID" := 50305;
                    1306:
                        "Report ID" := 50306;
                    1307:
                        "Report ID" := 50307;
                end;
                Modify();
            end;
        }

    }
    trigger OnPreReport()
    begin
        Window.Open('Traitement en cours...');
    end;

    trigger OnPostReport()
    begin
        Window.Close();
        Message('Traitement terminé!');
    end;

    var
        Window: Dialog;
}
