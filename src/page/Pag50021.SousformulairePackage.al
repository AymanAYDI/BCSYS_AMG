namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
page 50021 "Sous-formulaire Package"
{
    Caption = 'Expéditions - Package';
    PageType = ListPart;
    RefreshOnActivate = false;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = Package;
    SourceTableView = sorting("Package No.")
                      order(ascending);
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
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    TableRelation = "Sales Shipment Header"."No.";
                }
                field("Type of package"; Rec."Type of package")
                {

                }
                field("Package Reference"; Rec."Package Reference")
                {
                    Editable = false;
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
                    Editable = false;
                    Enabled = false;
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

                trigger OnAction()
                var
                    LRecColis: Record 50009;
                    LRecColisages: Record 50010;
                    LPagColisage: Page 50022;
                begin
                    CurrPage.SETSELECTIONFILTER(LRecColis);

                    if LRecColis.FINDFIRST() then begin
                        LRecColisages.SETRANGE("Package No.", LRecColis."Package No.");
                        PAGE.RUNMODAL(50022, LRecColisages);
                    end;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        LRecColis: Record 50009;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("Shipping No.", Rec."Shipping No.");
        LIntNbColis := LRecColis.COUNT - 1;
        CurrPage.UPDATE(true);
        if LRecColis.FINDFIRST() then
            repeat
                if LRecColis."Package No." <> Rec."Package No." then begin
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;
        CurrPage.UPDATE(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LRecColis: Record 50009;
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        CLEAR(GRecColis);
        GRecColis.SETRANGE("Shipping No.", Rec."Shipping No.");
        Rec."Package Reference" := FORMAT(GRecColis.COUNT + 1) + '/' + FORMAT(GRecColis.COUNT + 1);
        LIntI := 1;
        LRecColis.RESET();
        LRecColis.SETFILTER("Shipping No.", Rec."Shipping No.");
        LIntNbColis := LRecColis.COUNT + 1;
        if LRecColis.FINDFIRST() then
            repeat
                if LRecColis."Package No." <> Rec."Package No." then begin
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
                    LRecColis.MODIFY();
                    COMMIT();
                    LIntI += 1;
                end;
            until LRecColis.NEXT() <= 0;
    end;

    var
        GRecColis: Record 50009;
}

