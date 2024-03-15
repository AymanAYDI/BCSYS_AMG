namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Inventory.Item;
using Microsoft.Sales.Setup;
using BCSYS.AMGALLOIS.Basic;
report 50030 DELInsertCarboAMG
{
    Caption = 'Choix de l''emballage Carboglace';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            var
                LRecSalesSetup: Record "Sales & Receivables Setup";
            begin
            end;
        }
    }

    requestpage
    {
        ShowFilter = false;

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("Item No."; ItemNo)
                    {
                        Caption = 'Item No.';
                        TableRelation = Item."No.";
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Item No. field.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if PAGE.RUNMODAL(PAGE::DELItemDrillDownCarbo, Item) = ACTION::LookupOK then
                                ItemNo := Item."No.";
                        end;
                    }
                    field("Quantity"; GDecQty)
                    {
                        Caption = 'Quantity';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Quantity field.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if GRecSalesSetup.FINDFIRST() and (GRecSalesSetup."Category Code Carbo" <> '') then
                Item.SETFILTER("Item Category Code", GRecSalesSetup."Category Code Carbo");
            GDecQty := 1;
        end;
    }

    labels
    {
    }

    var
        GRecSalesSetup: Record "Sales & Receivables Setup";
        ItemNo: Code[20];
        GDecQty: Decimal;
}

