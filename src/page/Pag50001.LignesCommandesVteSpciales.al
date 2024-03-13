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

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Sel; rec.Sel)
                {
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
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    Visible = false;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    Editable = false;
                }
                field("No."; rec."No.")
                {
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                }
                field(Amount; rec.Amount)
                {
                }
                field("Outstanding Amount"; rec."Outstanding Amount")
                {
                }
                field("Currency Code"; rec."Currency Code")
                {
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    Editable = false;
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                    Editable = false;
                }
                field("Fournisseur article"; rec."Fournisseur article")
                {
                    Editable = false;
                }
                field("Special Order"; rec."Special Order")
                {
                }
                field("Special Order Purchase No."; rec."Special Order Purchase No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Special Order Purch. Line No."; rec."Special Order Purch. Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

}

