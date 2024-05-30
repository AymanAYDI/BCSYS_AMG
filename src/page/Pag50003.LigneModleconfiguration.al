namespace BCSYS.AMGALLOIS.Basic;

using System.IO;
page 50003 "Ligne Modèle configuration"
{
    PageType = Worksheet;
    SourceTable = "Config. Template Line";
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Data Template Code"; Rec."Data Template Code")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Field ID"; Rec."Field ID")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Template Code"; Rec."Template Code")
                {
                }
                field("Template Description"; Rec."Template Description")
                {
                }
                field(Mandatory; Rec.Mandatory)
                {
                }
                field(Reference; Rec.Reference)
                {
                }
                field("Default Value"; Rec."Default Value")
                {
                }
                field("Table Caption"; Rec."Table Caption")
                {
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field("Skip Relation Check"; Rec."Skip Relation Check")
                {
                }
                field("Language ID"; Rec."Language ID")
                {
                }
            }
        }
    }
}

