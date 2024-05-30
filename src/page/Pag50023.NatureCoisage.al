namespace BCSYS.AMGALLOIS.Basic;
page 50023 NatureCoisage
{
    PageType = List;
    SourceTable = NatureCoisage;
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Intituler; Rec.Intituler)
                {
                }
            }
        }
    }
}

