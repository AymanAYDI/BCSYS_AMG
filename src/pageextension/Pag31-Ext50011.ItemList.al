namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
pageextension 50011 ItemList extends "Item List" //31
{
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
            }
        }
        addafter("Unit Price")
        {
            field(Historique; Rec.Historique)
            {
                TableRelation = "Sales Archive".Reference;

                trigger OnLookup(var Text: Text): Boolean
                var
                    LRecHisto: Record "Sales Archive";
                begin
                    //DELPHI AUB 30.06.2020
                    LRecHisto.SETRANGE(Reference, Rec."No.");

                    PAGE.RUNMODAL(PAGE::"Historique ventes article", LRecHisto);
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


        //Unsupported feature: Code Modification on "FilterByAttributes(Action 138).OnAction".

        //trigger OnAction() //TODO
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FilterPageID := PAGE::"Filter Items by Attribute";
        IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone THEN
          FilterPageID := PAGE::"Filter Items by Att. Phone";

        CloseAction := PAGE.RUNMODAL(FilterPageID,TempFilterItemAttributesBuffer);
        IF (ClientTypeManagement.GetCurrentClientType <> CLIENTTYPE::Phone) AND (CloseAction <> ACTION::LookupOK) THEN
          EXIT;

        IF TempFilterItemAttributesBuffer.ISEMPTY THEN BEGIN
          ClearAttributesFilter;
          EXIT;
        END;
        TempItemFilteredFromAttributes.RESET;
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
          RESET;
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
            }
        }
    }



    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    begin
        Rec.VALIDATE("Unit Price");  //TODO Verif
    end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableControls;
    VALIDATE("Unit Price");
    //MODIFY;
    */
    //end;
}

