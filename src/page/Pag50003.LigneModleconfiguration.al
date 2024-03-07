namespace BCSYS.AMGALLOIS.Basic;

using System.IO;
page 50003 "Ligne Modèle configuration"
{
    PageType = Worksheet;
    SourceTable = "Config. Template Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Data Template Code"; rec."Data Template Code")
                {
                }
                field("Line No."; rec."Line No.")
                {
                }
                field(Type; rec.Type)
                {
                }
                field("Field ID"; rec."Field ID")
                {
                }
                field("Field Name"; rec."Field Name")
                {
                }
                field("Table ID"; rec."Table ID")
                {
                }
                field("Table Name"; rec."Table Name")
                {
                }
                field("Template Code"; rec."Template Code")
                {
                }
                field("Template Description"; rec."Template Description")
                {
                }
                field(Mandatory; rec.Mandatory)
                {
                }
                field(Reference; rec.Reference)
                {
                }
                field("Default Value"; rec."Default Value")
                {
                }
                field("Table Caption"; rec."Table Caption")
                {
                }
                field("Field Caption"; rec."Field Caption")
                {
                }
                field("Skip Relation Check"; rec."Skip Relation Check")
                {
                }
                field("Language ID"; rec."Language ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

