namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
tableextension 50026 ItemTemplate extends "Item Template" //1301
{
    fields
    {
        modify("Price/Profit Calculation")
        {
            OptionCaption = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship,Last Direct Cost+Profit';
            //Unsupported feature: Property Modification (OptionString) on ""Price/Profit Calculation"(Field 19)".

        }
        field(50001; Fournisseur; Code[20])
        {
            TableRelation = Vendor."No.";
            DataClassification = ToBeClassified;
            Description = 'Spe AMG';
        }//TODO 
    }


    //Unsupported feature: Code Modification on "CreateFieldRefArray(PROCEDURE 12)".

    //procedure CreateFieldRefArray();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    I := 1;

    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo(Type)));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Base Unit of Measure")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Automatic Ext. Texts")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Gen. Prod. Posting Group")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("VAT Prod. Posting Group")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Inventory Posting Group")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Costing Method")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Indirect Cost %")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Price Includes VAT")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Profit %")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Price/Profit Calculation")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Allow Invoice Disc.")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Item Disc. Group")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Tax Group Code")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Warehouse Class Code")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Item Category Code")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FieldNo("Service Item Group")));

    OnAfterCreateFieldRefArray(FieldRefArray,RecRef,I);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    OnAfterCreateFieldRefArray(FieldRefArray,RecRef);
    */
    //end;


    //Unsupported feature: Code Modification on "CreateConfigTemplateFromExistingItem(PROCEDURE 5)".

    //procedure CreateConfigTemplateFromExistingItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecRef.GETTABLE(Item);
    CreateFieldRefArray(FieldRefArray,RecRef);

    ConfigTemplateManagement.CreateConfigTemplateAndLines(NewTemplateCode,'',DATABASE::Item,FieldRefArray);
    DimensionsTemplate.CreateTemplatesFromExistingMasterRecord(Item."No.",NewTemplateCode,DATABASE::Item);
    ConfigTemplateHeader.Get(NewTemplateCode);
    OnCreateConfigTemplateFromExistingItemOnBeforeInitTempRec(Item,TempItemTemplate,ConfigTemplateHeader);
    InitializeTempRecordFromConfigTemplate(TempItemTemplate,ConfigTemplateHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    InitializeTempRecordFromConfigTemplate(TempItemTemplate,ConfigTemplateHeader);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateItemFromTemplate(PROCEDURE 8)".

    //procedure UpdateItemFromTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if NOT GUIALLOWED Then
      EXIT;

    ConfigTemplateHeader.SetRange("Tablùe ID",DATABASE::Item);
    ConfigTemplateHeader.SetRange(Enabled,TRUE);
    ConfigTemplates.SETTABLEVIEW(ConfigTemplateHeader);
    ConfigTemplates.LOOKUPMODE(TRUE);
    if ConfigTemplates.RUNMODAL = ACTION::LookupOK Then BEGIN
      ConfigTemplates.GETRECORD(ConfigTemplateHeader);
      ItemRecRef.GETTABLE(Item);
      ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader,ItemRecRef);
      DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader,Item."No.",DATABASE::Item);
      ItemRecRef.SETTABLE(Item);
      Item.FIND;
    END;

    OnAfterUpdateItemFromTemplate(Rec,Item,ConfigTemplateHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    OnAfterUpdateItemFromTemplate(Rec,Item);
    */
    //end;


    //Unsupported feature: Code Modification on "InsertItemFromTemplate(PROCEDURE 16)".

    //procedure InsertItemFromTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitItemNo(Item,ConfigTemplateHeader);
    Item.INSERT(TRUE);
    RecRef.GETTABLE(Item);
    ConfigTemplateMgt.UpdateRecord(ConfigTemplateHeader,RecRef);
    RecRef.SETTABLE(Item);
    if Item."Base Unit of Measure" = '' Then BEGIN
      UnitOfMeasure.SetRange("International Standard Code",'EA'); // 'Each' ~= 'PCS'
      if NOT UnitOfMeasure.FINDFIRST Then BEGIN
        UnitOfMeasure.SetRange("International Standard Code");
        if UnitOfMeasure.FINDFIRST Then;
      END;
      Item.VALIDATE("Base Unit of Measure",UnitOfMeasure.Code);
      Item.MODIFY(TRUE);
    END;
    DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader,Item."No.",DATABASE::Item);
    Item.FIND;

    OnAfterInsertItemFromTemplate(Rec,Item,ConfigTemplateHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    OnAfterInsertItemFromTemplate(Rec,Item);
    */
    //end;


    //Unsupported feature: Code Modification on "InitItemNo(PROCEDURE 9)".

    //procedure InitItemNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeInitItemNo(Item,ConfigTemplateHeader,IsHandled);
    if IsHandled Then
      EXIT;

    if ConfigTemplateHeader."Instance No. Series" = '' Then
      EXIT;
    NoSeriesMgt.InitSeries(ConfigTemplateHeader."Instance No. Series",'',0D,Item."No.",Item."No. Series");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #6..8
    */
    //end;

    //Unsupported feature: Property Modification (Dimensions) on "CreateFieldRefArray(PROCEDURE 12).FieldRefArray(Parameter 1000)".


    //Unsupported feature: Property Modification (Dimensions) on "AddToArray(PROCEDURE 4).FieldRefArray(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "InitItemNo(PROCEDURE 9).IsHandled(Variable 1001)".


    //Unsupported feature: Property Modification (Dimensions) on "OnAfterCreateFieldRefArray(PROCEDURE 10).FieldRefArray(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterCreateFieldRefArray(PROCEDURE 10).I(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterInsertItemFromTemplate(PROCEDURE 14).ConfigTemplateHeader(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterUpdateItemFromTemplate(PROCEDURE 11).ConfigTemplateHeader(Parameter 1002)".

}

