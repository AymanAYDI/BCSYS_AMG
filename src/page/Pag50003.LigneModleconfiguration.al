namespace BCSYS.AMGALLOIS.Basic;

using System.IO;
page 50003 "Ligne Modèle configuration"
{
    PageType = Worksheet;
    SourceTable = "Config. Template Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Data Template Code"; rec."Data Template Code")
                {
                    ToolTip = 'Specifies the value of the Data Template Code field.';
                }
                field("Line No."; rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Type; rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Field ID"; rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';
                }
                field("Field Name"; rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Table ID"; rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Name"; rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                }
                field("Template Code"; rec."Template Code")
                {
                    ToolTip = 'Specifies the value of the Template Code field.';
                }
                field("Template Description"; rec."Template Description")
                {
                    ToolTip = 'Specifies the value of the Template Description field.';
                }
                field(Mandatory; rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
                field(Reference; rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                }
                field("Default Value"; rec."Default Value")
                {
                    ToolTip = 'Specifies the value of the Default Value field.';
                }
                field("Table Caption"; rec."Table Caption")
                {
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field("Field Caption"; rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.';
                }
                field("Skip Relation Check"; rec."Skip Relation Check")
                {
                    ToolTip = 'Specifies the value of the Skip Relation Check field.';
                }
                field("Language ID"; rec."Language ID")
                {
                    ToolTip = 'Specifies the value of the Language ID field.';
                }
            }
        }
    }

    actions
    {
    }
}

