namespace BCSYS.AMGALLOIS.Basic;
page 50015 "Liste ONU"
{
    ApplicationArea = All;
    Caption = 'Liste ONU', Comment = 'FRA="Liste ONU"';
    PageType = List;
    SourceTable = "ONU table";
    SourceTableView = sorting(Code, Version)
                      order(ascending);
    UsageCategory = None;

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
                field(Classe; Rec.Classe)
                {
                }
                field("Sous-classe"; Rec."Sous-classe")
                {
                }
                field("Groupe emballage"; Rec."Groupe emballage")
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
}

