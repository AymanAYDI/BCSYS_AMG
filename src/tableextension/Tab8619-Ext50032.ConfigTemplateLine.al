namespace BCSYS.AMGALLOIS.Basic;
tableextension 50032 ConfigTemplateLine extends "Config. Template Line" //8619
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Line No."(Field 2)".


        //Unsupported feature: Code Modification on ""Template Code"(Field 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type = Type::Field Then
          EXIT;

        ConfigTemplateList.LOOKUPMODE := TRUE;
        ConfigTemplateList.EDITABLE := FALSE;
        if ConfigTemplateList.RUNMODAL = ACTION::LookupOK Then BEGIN
          ConfigTemplateList.GETRECORD(ConfigTemplateHeader);
          if ConfigTemplateHeader.Code = "Data Template Code" Then
            Error(Text000);
          CALCFIELDS("Template Description");
          VALIDATE("Template Code",ConfigTemplateHeader.Code);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        ConfigTemplateHeader.Get("Data Template Code");
        if ConfigTemplateHeader."Table ID" = 0 Then
          EXIT;

        ConfigTemplateHeader.SetRange("Table ID",ConfigTemplateHeader."Table ID");
        ConfigTemplateList.SETTABLEVIEW(ConfigTemplateHeader);
        #4..12
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Template Code"(Field 8).OnValidate".

        //trigger (Variable: ConfigTemplateHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Template Code"(Field 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Type = Type::Field Then
          Error(Text005);

        if "Template Code" = "Data Template Code" Then
          Error(Text000);

        ConfigTemplateMgt.TestHierarchy(Rec);

        ConfigTemplateLine.SetRange("Data Template Code","Data Template Code");
        ConfigTemplateLine.SetRange("Template Code","Template Code");
        if NOT ConfigTemplateLine.IsEmpty Then
          Error(Text003,"Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        if ConfigTemplateHeader.Get("Template Code") Then
          if ConfigTemplateHeader2.Get("Data Template Code") Then
            if ConfigTemplateHeader."Table ID" <> ConfigTemplateHeader2."Table ID" Then
              Error(Text002,ConfigTemplateHeader.Code,ConfigTemplateHeader2."Table ID");

        #7..12
        */
        //end;
    }

    var
        ConfigTemplateHeader: Record "8618";
        ConfigTemplateHeader2: Record "8618";

    var
        Text002: Label 'The template %1 does not relate to table %2.';
}

