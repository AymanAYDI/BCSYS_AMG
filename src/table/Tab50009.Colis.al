namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.History;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
table 50009 Colis
{
    Permissions = TableData "Sales Shipment Header" = rimd,
                  TableData "Sales Shipment Line" = rimd;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'N°';
        }
        field(2; "Reference Colis"; Code[11])
        {
            Caption = 'Référence Colis';
        }
        field(15; "No. expedition"; Code[20])
        {
            Caption = 'N° expédition';
        }
        field(16; "Nature du colis"; Code[10])
        {
            FieldClass = Normal;
            TableRelation = NatureCoisage.No;
            Caption = 'Nature du colis';
        }
        field(17; "Designation marchandise"; Text[50])
        {
            Caption = 'Désignation marchandise';
        }
        field(20; "Longueur (cm)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Longueur (cm)';

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)") * 0.000001;
            end;
        }
        field(25; "Largeur (cm)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Largeur (cm)';

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)") * 0.000001;
            end;
        }
        field(30; "Hauteur (cm)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Hauteur (cm)';

            trigger OnValidate()
            begin
                "Volume (m3)" := "Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)" * 0.000001;
            end;
        }
        field(35; "Volume (m3)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Volume (m3)';
        }
        field(40; "Poids net"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Poids net';
        }
        field(45; "Poids brut"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Caption = 'Poids brut';
        }
        field(50; "Nb piece dans le colis"; Decimal)
        {
            CalcFormula = sum(Colisage."Quantite" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Nb pièce dans le colis';
        }
        field(51; "Intituler Nature du colis"; Text[60])
        {
            CalcFormula = lookup(NatureCoisage.Intituler where("No" = field("Nature du colis")));
            FieldClass = FlowField;
            Caption = 'Intituler Nature du colis';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Reference Colis")
        {
        }
    }

    trigger OnDelete()
    begin
        GRecColis.SETRANGE("No. expedition", Rec."No. expedition");
        GRecColis.SETRANGE("Nature du colis", Rec."Nature du colis");
        if GRecColis.FINDLAST() then begin
            GRecColisage.SETRANGE("No.", Rec."No.");
            if GRecColisage.FINDFIRST() then begin
                if not CONFIRM('Attention : des lignes de colisage sont rattachées à ce colis, êtes-vous sûr de vouloir les supprimer ?', false) then
                    ERROR('Suppression annulée par l''utilisateur');
                // supresion de la lsite colisage
                CLEAR(GRecColisage);
                GRecColisage.SETRANGE("No.", Rec."No.");
                GRecColisage.DELETEALL();

                GRecSalesShipingLine.SETRANGE("Document No.", Rec."No. expedition");
                GRecSalesShipingLine.SETRANGE("No. Colis", Rec."No.");
                GRecSalesShipingLine.MODIFYALL("No. Colis", '');
                COMMIT();
            end;
        end
        else
            ERROR('Aucun colis pour cette expédition');

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            ParamVente.GET();
            "No." := GestionNoSouche.GetNextNo(ParamVente."Souche No. colis", TODAY);
        end;

        if Rec.GETFILTER("No. expedition") <> '' then
            "No. expedition" := Rec.GETFILTER("No. expedition");
    end;

    var
        GRecColis: Record Colis;
        GRecColisage: Record Colisage;
        ParamVente: Record "Sales & Receivables Setup";
        GRecSalesShipingLine: Record "Sales Shipment Line";
        GestionNoSouche: Codeunit "No. Series";

    procedure FModiReferenceColis(PSigne: Option PLUS,MOINS)
    begin
        MESSAGE(Rec."No. expedition");
    end;

    procedure FRecalculer(PRecColis: Record Colis; PBooAjout: Boolean)
    var
        LRecColis: Record Colis;
        LIntI: Integer;
        LIntNoFinal: Integer;
    begin
        LIntI := 1;

        LRecColis.SETRANGE("No. expedition", PRecColis."No. expedition");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST() then
            repeat
                if PBooAjout then
                    LRecColis."Reference Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal + 1)
                else
                    LRecColis."Reference Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
                LRecColis.MODIFY();
                COMMIT();
                LIntI += 1;
            until LRecColis.NEXT() <= 0;

    end;
}

