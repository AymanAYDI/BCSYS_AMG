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
                }
                field(Version; Rec.Version)
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
                field("Packaging group"; Rec."Packaging group")
                {
                }
                field("Packing instr passager"; Rec."Packing instr passager")
                {
                }
                field("Packing instr cargo"; Rec."Packing instr cargo")
                {
                }
                field("Flash Point"; Rec."Flash Point")
                {
                }
                field("Limited quantity"; Rec."Limited quantity")
                {
                }
            }
        }
    }

    actions
    {
    }
}

