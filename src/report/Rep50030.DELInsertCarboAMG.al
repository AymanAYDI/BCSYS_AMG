namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Sales.Setup;
report 50030 DELInsertCarboAMG
{
    Caption = 'Choix de l''emballage Carboglace';
    ProcessingOnly = true;
    UsageCategory = None;
    ApplicationArea = All;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
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
                group(Group1)
                {
                    ShowCaption = false;
                    field("No article"; ItemNo)
                    {
                        Caption = 'N° article';
                        TableRelation = Item."No.";
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            //DELPHI AUB 22.03.2021
                            if PAGE.RUNMODAL(PAGE::DELItemDrillDownCarbo, Item) = ACTION::LookupOK then
                                ItemNo := Item."No.";

                            //END DELPHI AUB
                        end;
                    }
                    field("Quantité"; GDecQty)
                    {
                        Caption = 'Quantité';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if GRecSalesSetup.Get() and (GRecSalesSetup."Code categorie Carbo" <> '') then
                Item.SETFILTER("Item Category Code", GRecSalesSetup."Code categorie Carbo");
            GDecQty := 1; //DELPHI AUB 01.04.2021
        end;
    }

    labels
    {
    }

    var
        GRecSalesSetup: Record "Sales & Receivables Setup";
        GDecQty: Decimal;
        ItemNo: Code[20];
}

