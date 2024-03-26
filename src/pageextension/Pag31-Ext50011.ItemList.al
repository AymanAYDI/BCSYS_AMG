namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Attribute;
using System.Reflection;
using System.Environment;
pageextension 50011 ItemList extends "Item List" //31
{
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
        }
        addafter("Unit Price")
        {
            field(Historique; Rec.History)
            {
                TableRelation = "Sales Archive".Reference;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Historique field.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    //DELPHI AUB 30.06.2020
                    LRecHisto.SetRange(Reference, Rec."No.");

                    PAGE.RunModal(PAGE::"Historique ventes article", LRecHisto);
                    //END DELPHI AUB
                end;
            }
        }
    }
    actions
    {
        modify(PricesDiscountsOverview)
        {
            ApplicationArea = Advanced;
        }
        modify("Sales_Prices")
        {
            ApplicationArea = Advanced;
        }
        modify("Sales_LineDiscounts")
        {
            ApplicationArea = Advanced;
        }

        //************* 
        //TODO Verif
        modify(FilterByAttributes)
        {
            visible = false;
        }
        addafter(FilterByAttributes)
        {
            action(Filter_By_Attributes)
            {
                AccessByPermission = TableData "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Filter by Attributes';
                Image = EditFilter;
                ToolTip = 'Find items that match specific attributes. To make sure you include recent changes made by other users, clear the filter and then reset it.';

                trigger OnAction()
                var
                    ClientTypeManagement: Codeunit "Client Type Management";
                    ItemAttributeManagement: Codeunit "Item Attribute Management";
                    TypeHelper: Codeunit "Type Helper";
                    CloseAction: Action;
                    FilterText: Text;
                    FilterPageID: Integer;
                    ParameterCount: Integer;
                begin
                    FilterPageID := PAGE::"Filter Items by Attribute";
                    if ClientTypeManagement.GetCurrentClientType() = CLIENTTYPE::Phone then
                        FilterPageID := PAGE::"Filter Items by Att. Phone";

                    CloseAction := PAGE.RunModal(FilterPageID, TempFilterItemAttributesBuffer);
                    if (ClientTypeManagement.GetCurrentClientType() <> CLIENTTYPE::Phone) and (CloseAction <> ACTION::LookupOK) then
                        exit;

                    if TempFilterItemAttributesBuffer.IsEmpty() then begin
                        ClearAttributesFilter();
                        exit;
                    end;
                    ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempItemFilteredFromAttributes);
                    FilterText := ItemAttributeManagement.GetItemNoFilterText(TempItemFilteredFromAttributes, ParameterCount);

                    if ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery() - 100 then begin
                        Rec.FilterGroup(0);
                        Rec.MarkedOnly(false);
                        Rec.SetFilter("No.", FilterText);
                    end else begin
                        RunOnTempRec := true;
                        Rec.ClearMarks();
                        Rec.Reset();
                    end;
                end;
            }
        }
        //Unsupported feature: Code Modification on "FilterByAttributes(Action 138).OnAction".

        //trigger OnAction() //TODO
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FilterPageID := PAGE::"Filter Items by Attribute";
        IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone THEN
          FilterPageID := PAGE::"Filter Items by Att. Phone";

        CloseAction := PAGE.RunModal(FilterPageID,TempFilterItemAttributesBuffer);
        IF (ClientTypeManagement.GetCurrentClientType <> CLIENTTYPE::Phone) AND (CloseAction <> ACTION::LookupOK) THEN
          EXIT;

        IF TempFilterItemAttributesBuffer.ISEMPTY THEN BEGIN
          ClearAttributesFilter;
          EXIT;
        END;
        TempItemFilteredFromAttributes.Reset;
        TempItemFilteredFromAttributes.DELETEALL;
        ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer,TempItemFilteredFromAttributes);
        FilterText := ItemAttributeManagement.GetItemNoFilterText(TempItemFilteredFromAttributes,ParameterCount);

        IF ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery - 100 THEN BEGIN
          FILTERGROUP(0);
          MARKEDONLY(FALSE);
          SETFILTER("No.",FilterText);
        END ELSE BEGIN
          RunOnTempRec := TRUE;
          CLEARMARKS;
          Reset;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12

        #15..26
        */
        //end;
        modify(CopyItem)
        {
            Visible = false;
        }
        addafter(Translations)
        {
            action(ONU)
            {
                Caption = 'ONU';
                Image = "Table";
                Promoted = true; //TODO Verif
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = Category13;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                PromotedIsBig = true;
                //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                PromotedOnly = true;
                RunObject = Page "Liste ONU";
                ApplicationArea = All;
                ToolTip = 'Executes the ONU action.';
            }
        }
    }



    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    begin
        Rec.Validate("Unit Price");  //TODO Verif
    end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableControls;
    Validate("Unit Price");
    //Modify;
    */
    //end;

    //***********************
    local procedure ClearAttributesFilter()
    begin
        Rec.ClearMarks();
        Rec.MarkedOnly(false);
        TempFilterItemAttributesBuffer.Reset();
        TempFilterItemAttributesBuffer.DeleteAll();
        Rec.FilterGroup(0);
        Rec.SetRange("No.");
    end;

    var
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        TempItemFilteredFromAttributes: Record Item temporary;
}

