namespace BCSYS.AMGALLOIS.Basic;
page 50014 "Lignes DGX"
{
    PageType = ListPart;
    SourceTable = "DGX Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec.LineNo)
                {
                    ToolTip = 'Specifies the value of the LineNo field.';
                }
                field(ItemNo; Rec.ItemNo)
                {
                    ToolTip = 'Specifies the value of the ItemNo field.';
                }
                field(UN; Rec.UN)
                {
                    ToolTip = 'Specifies the value of the UN field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.';
                }
                field("Sub-Class"; Rec."Sub-Class")
                {
                    ToolTip = 'Specifies the value of the Sub-Class field.';
                }
                field("Packaging Group"; Rec."Packaging Group")
                {
                    ToolTip = 'Specifies the value of the Packaging Group field.';
                }
                field(Qty; Rec.Qty)
                {
                    ToolTip = 'Specifies the value of the Qty field.';
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                    ToolTip = 'Specifies the value of the Unit of measure field.';
                }
                field("Type of Packing"; Rec."Type of Packing")
                {
                    ToolTip = 'Specifies the value of the Type of Packing field.';
                }
                field("Flash point"; Rec."Flash point")
                {
                    ToolTip = 'Specifies the value of the Flash point field.';
                }
                field("Limited qty"; Rec."Limited qty")
                {
                    ToolTip = 'Specifies the value of the Limited qty field.';
                }
                field("Gross Mass (kg)"; Rec."Gross Mass (kg)")
                {
                    ToolTip = 'Specifies the value of the Gross Mass (kg) field.';
                }
                field("Net mass (kg)"; Rec."Net mass (kg)")
                {
                    ToolTip = 'Specifies the value of the Net mass (kg) field.';
                }
                field("Packing Inst"; Rec."Packing Inst")
                {
                    ToolTip = 'Specifies the value of the Packing Inst field.';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

