namespace BCSYS.AMGALLOIS.Basic;
page 50020 Package
{
    PageType = List;
    SourceTable = Package;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.';
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ToolTip = 'Specifies the value of the Shipping No. field.';
                }
                field("Type of package"; Rec."Type of package")
                {
                    ToolTip = 'Specifies the value of the Type of package field.';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ToolTip = 'Specifies the value of the Product Description field.';
                }
                field("Length (cm)"; Rec."Length (cm)")
                {
                    ToolTip = 'Specifies the value of the Length (cm) field.';
                }
                field("Width (cm)"; Rec."Width (cm)")
                {
                    ToolTip = 'Specifies the value of the Width (cm) field.';
                }
                field("Height (cm)"; Rec."Height (cm)")
                {
                    ToolTip = 'Specifies the value of the Height (cm) field.';
                }
                field("Volume (m3)"; Rec."Volume (m3)")
                {
                    ToolTip = 'Specifies the value of the Volume (m3) field.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the value of the Net Weight field.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the value of the Gross Weight field.';
                }
                field("Nb of pieces"; Rec."Nb of pieces")
                {
                    ToolTip = 'Specifies the value of the Nb of pieces field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ActCreerColis)
            {
                Caption = 'Create Package';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Execute the Create Package action.';
                trigger OnAction()
                begin
                    Package.INIT();
                    Package."Line No." := 1;
                    if Rec.GETFILTER("Shipping No.") <> '' then begin
                        Package."Shipping No." := CopyStr(Rec.GETFILTER("Shipping No."), 1, MaxStrLen(Package."Shipping No."));
                        Package.INSERT(true);
                    end;
                end;
            }
        }
    }

    var
        Package: Record Packaging;
}

