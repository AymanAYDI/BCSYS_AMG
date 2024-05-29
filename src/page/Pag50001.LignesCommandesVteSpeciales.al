namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
page 50001 "Lignes Commandes Vte Speciales"
{
    AutoSplitKey = false;
    Caption = 'Special Order Line', Comment = 'FRA="Lignes Commandes Vte Spéciales"';
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
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Sel; Rec.Sel)
                {

                    trigger OnValidate()
                    begin
                        GRecSelection := Rec;
                        if (Rec.Sel) then
                            GRecSelection.Sel := true
                        else
                            GRecSelection.Sel := false;
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Visible = false;
                }
                field("Nom Client"; Rec."Nom Client")
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Editable = false;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Editable = false;
                }
                field("Fournisseur article"; Rec."Fournisseur article")
                {
                    Editable = false;
                }
                field("Special Order"; Rec."Special Order")
                {
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }


    var
        GRecSelection: Record "Sales Line";
}

