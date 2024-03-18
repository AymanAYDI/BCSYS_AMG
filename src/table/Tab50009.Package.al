namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.History;
table 50009 Package
{

    fields
    {
        field(1; "Package No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Package No.';
        }
        field(2; "Package Reference"; Code[11])
        {
            DataClassification = ToBeClassified;
            Caption = 'Package Reference';
        }
        field(15; "Shipping No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipping No.';
        }
        field(16; "Type of package"; Code[10])
        {
            FieldClass = Normal;
            TableRelation = NatureColisage.No;
            Caption = 'Type of package';
        }
        field(17; "Product Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Product Description';
        }
        field(20; "Length (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Length (cm)';
            trigger OnValidate()
            begin
                "Volume (m3)" := ("Length (cm)" * "Width (cm)" * "Height (cm)") * 0.000001;
            end;
        }
        field(25; "Width (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Width (cm)';
            trigger OnValidate()
            begin
                "Volume (m3)" := ("Length (cm)" * "Width (cm)" * "Height (cm)") * 0.000001;
            end;
        }
        field(30; "Height (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Height (cm)';
            trigger OnValidate()
            begin
                "Volume (m3)" := "Length (cm)" * "Width (cm)" * "Height (cm)" * 0.000001;
            end;
        }
        field(35; "Volume (m3)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Volume (m3)';
        }
        field(40; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Net Weight';
        }
        field(45; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Gross Weight';
        }
        field(50; "Nb of pieces"; Decimal)
        {
            CalcFormula = sum(Packaging.Quantity where("Package No." = field("Package No.")));
            FieldClass = FlowField;
            Caption = 'Nb of pieces';
        }
        field(51; "Title type of package"; Text[60])
        {
            CalcFormula = lookup(NatureColisage.Intituler where(No = field("Type of package")));
            FieldClass = FlowField;
            Caption = 'Title type of package';
        }
    }

    keys
    {
        key(Key1; "Package No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Package No.", "Package Reference")
        {
        }
    }

    trigger OnDelete()
    begin
        GRecColis.SetRange("Shipping No.", Rec."Shipping No.");
        GRecColis.SetRange("Type of package", Rec."Type of package");
        if GRecColis.FINDLAST() then begin
            GRecColisage.SetRange("Package No.", Rec."Package No.");
            if GRecColisage.FINDFIRST() then begin
                if not CONFIRM('Attention : des lignes de colisage sont rattachées à ce colis, êtes-vous sûr de vouloir les supprimer ?', false) then
                    Error('Suppression annulée par l''utilisateur');
                // supresion de la lsite colisage
                Clear(GRecColisage);
                GRecColisage.SetRange("Package No.", Rec."Package No.");
                GRecColisage.DELETEALL();
                GRecSalesShipingLine.SetRange("Document No.", Rec."Shipping No.");
                GRecSalesShipingLine.SetRange("Package No.", Rec."Package No.");
                GRecSalesShipingLine.MODIFYALL("Package No.", '');
                COMMIT();
            end;
        end
        else
            Error('Aucun colis pour cette expédition');

    end;

    trigger OnInsert()
    begin
        if "Package No." = '' then
            ParamVente.Get();

        "Package No." := GestionNoSouche.DoGetNextNo(ParamVente."Package Serie No.", TODAY, true, false);

        if Rec.GETFILTER("Shipping No.") <> '' then
            "Shipping No." := Rec.GETFILTER("Shipping No.");
    end;

    var
        GRecColis: Record Package;
        GRecColisage: Record Packaging;
        ParamVente: Record "Sales & Receivables Setup";
        GRecSalesShipingLine: Record "Sales Shipment Line";
        GestionNoSouche: Codeunit NoSeriesManagement;

    procedure FModiReferenceColis(PSigne: Option PLUS,MOINS)
    begin
        MESSAGE(Rec."Shipping No.");
    end;

    procedure FRecalculer(PRecColis: Record Package; PBooAjout: Boolean)
    var
        LRecColis: Record Package;
        LIntI: Integer;
        LIntNoFinal: Integer;
    begin
        LIntI := 1;
        LRecColis.SetRange("Shipping No.", PRecColis."Shipping No.");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST() then
            repeat
                if PBooAjout then
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal + 1)
                else
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
                LRecColis.Modify();
                COMMIT();
                LIntI += 1;
            until LRecColis.Next() <= 0;

    end;
}

