namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.History;
table 50009 Colis
{

    fields
    {
        field(1; "N°"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Référence Colis"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "N° expédition"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Nature du colis"; Code[10])
        {
            FieldClass = Normal;
            TableRelation = NatureCoisage.No;

            trigger OnValidate()
            begin
                /*
                if xRec."Nature du colis" <> '' Then
                BEGIN
                  CLEAR(GRecColis);
                  GRecColis.SetRange("N° expédition",xRec."N° expédition");
                  GRecColis.SetRange("Nature du colis",xRec."Nature du colis");
                  if GRecColis.COUNT >0 Then
                    if GRecColis.FINDFIRST Then
                      FModiReferenceColis(1,GRecColis); // 1 pour décrémentation
                  CLEAR(GRecColis);
                  GRecColis.SetRange("N° expédition",Rec."N° expédition");
                  GRecColis.SetRange("Nature du colis",Rec."Nature du colis");
                  if GRecColis.COUNT >0 Then
                  BEGIN
                    FModiReferenceColis(0,Rec); // 0 pour incrémentation
                    if GRecColis.FINDFIRST Then
                    BEGIN
                      Rec."Référence Colis" := FORMAT(GRecColis.COUNT+1) + '/'+FORMAT(GRecColis.COUNT+1);
                      //Rec.MODIFY;
                      //COMMIT;
                    END;
                  END
                  else
                  BEGIN
                    Rec."Référence Colis" := '1/1';
                  END;
                END
                else
                BEGIN
                  CLEAR(GRecColis);
                  GRecColis.SetRange("N° expédition",Rec."N° expédition");
                  GRecColis.SetRange("Nature du colis",Rec."Nature du colis");
                  if GRecColis.COUNT >0 Then
                  BEGIN
                    FModiReferenceColis(0,Rec); // 0 pour incrémentation
                    Rec."Référence Colis" := FORMAT(GRecColis.COUNT+1) + '/'+FORMAT(GRecColis.COUNT+1);
                  END
                  else
                  BEGIN
                    Rec."Référence Colis" := '1/1';
                  END;
                END;
                */

            end;
        }
        field(17; "Désignation marchandise"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Longueur (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)") * 0.000001;
            end;
        }
        field(25; "Largeur (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)") * 0.000001;
            end;
        }
        field(30; "Hauteur (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := "Longueur (cm)" * "Largeur (cm)" * "Hauteur (cm)" * 0.000001;
            end;
        }
        field(35; "Volume (m3)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(40; "Poids net"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(45; "Poids brut"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(50; "Nb pièce dans le colis"; Decimal)
        {
            //todo table spe
            // CalcFormula = Sum(Colisage.Quantité WHERE("N°"=FIELD("N°")));
            FieldClass = FlowField;
        }
        field(51; "Intituler Nature du colis"; Text[60])
        {
            CalcFormula = lookup(NatureCoisage.Intituler where(No = field("Nature du colis")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "N°")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "N°", "Référence Colis")
        {
        }
    }

    trigger OnDelete()
    var
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        GRecColis.SetRange("N° expédition", Rec."N° expédition");
        GRecColis.SetRange("Nature du colis", Rec."Nature du colis");
        //todo table spe
        // if GRecColis.FINDLAST then begin
        //  GRecColisage.SetRange("N°", Rec."N°");
        //     if GRecColisage.FINDFIRST then begin
        //         if not CONFIRM('Attention : des lignes de colisage sont rattachées à ce colis, êtes-vous sûr de vouloir les supprimer ?', false) then
        //             Error('Suppression annulée par l''utilisateur');
        //         // supresion de la lsite colisage
        //         CLEAR(GRecColisage);
        //         GRecColisage.SetRange("N°", Rec."N°");
        //         GRecColisage.DELETEALL;

        //         GRecSalesShipingLine.SetRange("Document No.", Rec."N° expédition");
        //         GRecSalesShipingLine.SetRange("N° Colis", Rec."N°");
        //         GRecSalesShipingLine.MODIFYALL("N° Colis", '');
        //         COMMIT;
        //         //DELPHI AUB 05.07.2021
        //         /*LIntI := 1;
        //         LRecColis.Reset();
        //         LRecColis.SETFILTER("N° expédition",Rec."N° expédition");
        //         LIntNbColis := LRecColis.COUNT - 1;

        //         if LRecColis.FIND('-') Then
        //         REPEAT
        //           LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
        //           LRecColis.MODIFY;
        //           //COMMIT();
        //           LIntI += 1;
        //         UNTIL LRecColis.NEXT<=0;
        //         */
        //         //END DELPHI AUB
        //         //FRecalculer(GRecColis,FALSE); //comment by AUB

        //     end;
        // end
        // else
        //     Error('Aucun colis pour cette expédition');

    end;

    trigger OnInsert()
    var
        LRecColis: Record Colis;
        LIntI: Integer;
        LIntNoFinal: Integer;
    begin
        if "N°" = '' then begin
            ParamVente.Get();
            "N°" := GestionNoSouche.DoGetNextNo(ParamVente."Souche N° colis", TODAY, true, false);
        end;

        if Rec.GETFILTER("N° expédition") <> '' then
            "N° expédition" := Rec.GETFILTER("N° expédition");
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
        //todo table spe
        // GRecColisage: Record 50010;
        GRecSalesShipingLine: Record "Sales Shipment Line";
        GRecColis: Record Colis;
        LRecColis: Record Colis;

    procedure FModiReferenceColis(PSigne: Option PLUS,MOINS)
    var
        LRecColis: Record Colis;
    begin
        MESSAGE(Rec."N° expédition");
    end;

    procedure FRecalculer(PRecColis: Record Colis; PBooAjout: Boolean)
    var
        LRecColis: Record Colis;
        LIntNoFinal: Integer;
        LIntI: Integer;
        LRecColis2: Record Colis;
    begin
        LIntI := 1;
        /*LRecColis.SetRange("N° expédition",PRecColis."N° expédition");
        LRecColis.SETFILTER("N°",'<>%1',PRecColis."N°");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST Then
        REPEAT
          if PBooAjout Then
            LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal+1)
          else
            LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
          LRecColis.MODIFY;
          LIntI += 1;
        UNTIL LRecColis.NEXT=0;
        */

        LRecColis.SetRange("N° expédition", PRecColis."N° expédition");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST() then
            repeat
                if PBooAjout then
                    LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal + 1)
                else
                    LRecColis."Référence Colis" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
                LRecColis.MODIFY();
                COMMIT();
                LIntI += 1;
            until LRecColis.NEXT() <= 0;

    end;
}

