namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Inventory.Item;
page 50030 DELItemDrillDownCarbo
{
    Caption = 'Choix de l''emballage Carbo';
    PageType = List;
    SourceTable = Item;
    SourceTableView = sorting("No.")
                      order(ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
            }
        }
    }

    actions
    {
    }
}

