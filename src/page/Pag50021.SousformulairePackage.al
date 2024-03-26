namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
page 50021 "Sous-formulaire Package"
{
    Caption = 'Expeditions - Package';
    PageType = ListPart;
    RefreshOnActivate = false;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = Package;
    SourceTableView = sorting("Package No.")
                      order(ascending);
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package No."; Rec."Package No.")
                {
                    DrillDownPageID = ListeColisage;
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Package No. field.';
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    TableRelation = "Sales Shipment Header"."No.";
                    ToolTip = 'Specifies the value of the Shipping No. field.';
                }
                field("Type of package"; Rec."Type of package")
                {
                    ToolTip = 'Specifies the value of the Type of package field.';
                }
                field("Package Reference"; Rec."Package Reference")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Package Reference field.';
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
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Nb of pieces field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(VoirArticle)
            {
                Caption = 'Visualiser les article du colis';
                Image = CreateWarehousePick;
                ToolTip = 'Executes the Visualiser les article du colis action.';
                trigger OnAction()
                var
                    LRecColis: Record Package;
                    LRecColisages: Record Packaging;
                    LPagColisage: Page ListeColisage;
                begin
                    CurrPage.SETSELECTIONFILTER(LRecColis);

                    if LRecColis.FINDFIRST() then begin
                        LRecColisages.SetRange("Package No.", LRecColis."Package No.");
                        PAGE.RunModal(Page::ListeColisage, LRecColisages);
                    end;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        LRecColis: Record Package;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        LIntI := 1;
        LRecColis.Reset();
        LRecColis.SETFILTER("Shipping No.", Rec."Shipping No.");
        LIntNbColis := LRecColis.COUNT - 1;
        CurrPage.Update(true);
        if LRecColis.FINDFIRST() then
            repeat
                if LRecColis."Package No." <> Rec."Package No." then begin
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.Modify();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.Next() <= 0;
        CurrPage.Update(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LRecColis: Record Package;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        Clear(GRecColis);
        GRecColis.SetRange("Shipping No.", Rec."Shipping No.");
        Rec."Package Reference" := FORMAT(GRecColis.COUNT + 1) + '/' + FORMAT(GRecColis.COUNT + 1);
        LIntI := 1;
        LRecColis.Reset();
        LRecColis.SETFILTER("Shipping No.", Rec."Shipping No.");
        LIntNbColis := LRecColis.COUNT + 1;
        if LRecColis.FINDFIRST() then
            repeat
                if LRecColis."Package No." <> Rec."Package No." then begin
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.Modify();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.Next() <= 0;
    end;

    var
        GRecColis: Record Package;
}

