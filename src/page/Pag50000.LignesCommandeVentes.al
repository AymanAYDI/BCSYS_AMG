namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;

page 50000 "Lignes Commande Ventes"
{
    PageType = ListPlus;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Order),
                            Type = CONST(Item),
                            "Outstanding Quantity" = FILTER(> 0));

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
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Special Order"; Rec."Special Order")
                {
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF EVALUATE(GIntAnnee, COPYSTR(Rec."Document No.", 3, 2)) THEN;
        IF EVALUATE(GIntNoCV, COPYSTR(Rec."Document No.", 6, 8)) THEN;
        GIntNoCVComplet := GIntAnnee * 100000 + GIntNoCV;
        //MESSAGE(FORMAT(GIntNoCVComplet));
    end;

    var
        GIntNoCV: Integer;
        GIntAnnee: Integer;
        GIntNoCVComplet: Integer;
}

