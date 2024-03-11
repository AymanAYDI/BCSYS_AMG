namespace BCSYS.AMGALLOIS.Basic;
page 50014 "Lignes DGX"
{
    PageType = ListPart;
    SourceTable = "DGX Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec.LineNo)
                {
                }
                field(ItemNo; Rec.ItemNo)
                {
                }
                field(UN; Rec.UN)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Class; Rec.Class)
                {
                }
                field("Sub-Class"; Rec."Sub-Class")
                {
                }
                field("Packaging Group"; Rec."Packaging Group")
                {
                }
                field(Qty; Rec.Qty)
                {
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                }
                field("Type of Packing"; Rec."Type of Packing")
                {
                }
                field("Flash point"; Rec."Flash point")
                {
                }
                field("Limited qty"; Rec."Limited qty")
                {
                }
                field("Gross Mass (kg)"; Rec."Gross Mass (kg)")
                {
                }
                field("Net mass (kg)"; Rec."Net mass (kg)")
                {
                }
                field("Packing Inst"; Rec."Packing Inst")
                {
                }
                field("Package No."; Rec."Package No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

