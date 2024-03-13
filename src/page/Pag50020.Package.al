namespace BCSYS.AMGALLOIS.Basic;
page 50020 Package
{
    PageType = List;
    SourceTable = Package;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package No."; Rec."Package No.")
                {
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                }
                field("Type of package"; Rec."Type of package")
                {
                }
                field("Product Description"; Rec."Product Description")
                {
                }
                field("Length (cm)"; Rec."Length (cm)")
                {
                }
                field("Width (cm)"; Rec."Width (cm)")
                {
                }
                field("Height (cm)"; Rec."Height (cm)")
                {
                }
                field("Volume (m3)"; Rec."Volume (m3)")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Nb of pieces"; Rec."Nb of pieces")
                {
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
                Caption = 'Créer Package';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;

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
        Package: Record 50010;
}

