namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
page 50001 "Lignes Commandes Vte Spéciales"
{
    AutoSplitKey = false;
    Caption = 'Special Order Line';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = true;
    MultipleNewLines = false;
    PageType = ListPlus;
    SaveValues = false;
    ShowFilter = false;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.")
                      order(ascending)
                      where("Document Type" = const(Order),
                            Type = const(Item),
                            "Outstanding Quantity" = filter(> 0));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Sel; rec.Sel)
                {
                    ToolTip = 'Specifies the value of the Sel field.';
                    trigger OnValidate()
                    var
                        GRecSelection: Record "Sales Line";
                    begin
                        GRecSelection := Rec;
                        if (rec.Sel) then
                            GRecSelection.Sel := true
                        else
                            GRecSelection.Sel := false;
                    end;
                }
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Customer Name"; rec."Customer Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("No."; rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.';
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ToolTip = 'Specifies the value of the Quantity Shipped field.';
                }
                field(Amount; rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Outstanding Amount"; rec."Outstanding Amount")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested Delivery Date field.';
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Promised Delivery Date field.';
                }
                field("Item supplier"; rec."Item supplier")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vendor field.';
                }
                field("Special Order"; rec."Special Order")
                {
                    ToolTip = 'Specifies the value of the Special Order field.';
                }
                field("Special Order Purchase No."; rec."Special Order Purchase No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
                }
                field("Special Order Purch. Line No."; rec."Special Order Purch. Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
                }
            }
        }
    }

    actions
    {
    }

}

