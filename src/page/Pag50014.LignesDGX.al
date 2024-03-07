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
                field(Classe; Rec.Classe)
                {
                }
                field("Sous-classe"; Rec."Sous-classe")
                {
                }
                field("Groupe Emballage"; Rec."Groupe Emballage")
                {
                }
                field(Qty; Rec.Qty)
                {
                }
                field("Unité de mesure"; Rec."Unité de mesure")
                {
                }
                field("Type of Packing"; Rec."Type of Packing")
                {
                }
                field("Point éclair"; Rec."Point éclair")
                {
                }
                field("Limited qty"; Rec."Limited qty")
                {
                }
                field("Masse brute (kg)"; Rec."Masse brute (kg)")
                {
                }
                field("Masse nette (kg)"; Rec."Masse nette (kg)")
                {
                }
                field("Packing Inst"; Rec."Packing Inst")
                {
                }
                field("No Colis"; Rec."No Colis")
                {
                }
            }
        }
    }

    actions
    {
    }
}

