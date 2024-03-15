namespace BCSYS.AMGALLOIS.Basic;
page 50023 NatureColisage
{
    PageType = List;
    SourceTable = NatureColisage;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Intituler; Rec.Intituler)
                {
                    ToolTip = 'Specifies the value of the Intituler field.';
                }
            }
        }
    }

    actions
    {
    }
}

