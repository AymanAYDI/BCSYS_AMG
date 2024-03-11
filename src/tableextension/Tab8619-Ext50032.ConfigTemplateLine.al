namespace BCSYS.AMGALLOIS.Basic;

using System.IO;
tableextension 50032 ConfigTemplateLine extends "Config. Template Line" //8619
{
    fields
    {
        //todo property editable cannot be customized Line No.
        modify("Template Code")
        {
            //todo check
            trigger OnBeforeValidate()
            var
                ConfigTemplateHeader: Record "Config. Template Header";
                ConfigTemplateHeader2: Record "Config. Template Header";
                Text002: Label 'The template %1 does not relate to table %2.';
            begin
                if ConfigTemplateHeader.GET("Template Code") then
                    if ConfigTemplateHeader2.GET("Data Template Code") then
                        if ConfigTemplateHeader."Table ID" <> ConfigTemplateHeader2."Table ID" then
                            ERROR(Text002, ConfigTemplateHeader.Code, ConfigTemplateHeader2."Table ID");
            end;
            //todo Onlookup !!!!!!!!!!!!!!!
        }
    }

}

