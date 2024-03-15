namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;

page 50000 "Lignes Commande Ventes"
{
    PageType = ListPlus;
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
                IndentationColumn = GIntNoCVComplet;
                IndentationControls = NoCV;
                ShowAsTree = true;
                field(NoCV; GIntNoCVComplet)
                {
                    ToolTip = 'Specifies the value of the GIntNoCVComplet field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.';
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ToolTip = 'Specifies the value of the Qty. to Ship field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ToolTip = 'Specifies the value of the Quantity Shipped field.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Purch. Order Line No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Special Order"; Rec."Special Order")
                {
                    ToolTip = 'Specifies the value of the Special Order field.';
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Requested Delivery Date field.';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Promised Delivery Date field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if EVALUATE(GIntAnnee, COPYSTR(Rec."Document No.", 3, 2)) then;
        if EVALUATE(GIntNoCV, COPYSTR(Rec."Document No.", 6, 8)) then;
        GIntNoCVComplet := GIntAnnee * 100000 + GIntNoCV;
        //MESSAGE(FORMAT(GIntNoCVComplet));
    end;

    var
        GIntAnnee: Integer;
        GIntNoCV: Integer;
        GIntNoCVComplet: Integer;
}

