namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
page 50030 DELItemDrillDownCarbo
{
    Caption = 'Choix de l''emballage Carbo';
    PageType = List;
    SourceTable = Item;
    SourceTableView = sorting("No.")
                      order(ascending);
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
            }
        }
    }
}

