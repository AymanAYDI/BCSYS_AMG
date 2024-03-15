namespace BCSYS.AMGALLOIS.Basic;
page 50015 "Liste ONU"
{
    ApplicationArea = All;
    Caption = 'Liste ONU';
    PageType = List;
    SourceTable = "ONU table";
    SourceTableView = sorting(Code, Version)
                      order(ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Version; Rec.Version)
                {
                    ToolTip = 'Specifies the value of the Version field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Désignation field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.';
                }
                field("Sub-Class"; Rec."Sub-Class")
                {
                    ToolTip = 'Specifies the value of the Sub-Class field.';
                }
                field("Packaging group"; Rec."Packaging group")
                {
                    ToolTip = 'Specifies the value of the Grp field.';
                }
                field("Packing instr passager"; Rec."Packing instr passager")
                {
                    ToolTip = 'Specifies the value of the Packing instruction Avion passager field.';
                }
                field("Packing instr cargo"; Rec."Packing instr cargo")
                {
                    ToolTip = 'Specifies the value of the Packing instruction Avion cargo field.';
                }
                field("Flash Point"; Rec."Flash Point")
                {
                    ToolTip = 'Specifies the value of the Flash Point field.';
                }
                field("Limited quantity"; Rec."Limited quantity")
                {
                    ToolTip = 'Specifies the value of the Limited quantity field.';
                }
            }
        }
    }

    actions
    {
    }
}

