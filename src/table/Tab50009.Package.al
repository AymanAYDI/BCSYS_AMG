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
        }
        field(2; "Package Reference"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Shipping No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Type of package"; Code[10])
        {
            FieldClass = Normal;
            TableRelation = NatureColisage.No;

            trigger OnValidate()
            begin
                /*
                if xRec."Type of package" <> '' Then
                BEGIN
                  CLEAR(GRecColis);
                  GRecColis.SetRange("Shipping No.",xRec."Shipping No.");
                  GRecColis.SetRange("Type of package",xRec."Type of package");
                  if GRecColis.COUNT >0 Then
                    if GRecColis.FINDFIRST Then
                      FModiReferenceColis(1,GRecColis); // 1 pour décrémentation
                  CLEAR(GRecColis);
                  GRecColis.SetRange("Shipping No.",Rec."Shipping No.");
                  GRecColis.SetRange("Type of package",Rec."Type of package");
                  if GRecColis.COUNT >0 Then
                  BEGIN
                    FModiReferenceColis(0,Rec); // 0 pour incrémentation
                    if GRecColis.FINDFIRST Then
                    BEGIN
                      Rec."Package Reference" := FORMAT(GRecColis.COUNT+1) + '/'+FORMAT(GRecColis.COUNT+1);
                      //Rec.MODIFY;
                      //COMMIT;
                    END;
                  END
                  else
                  BEGIN
                    Rec."Package Reference" := '1/1';
                  END;
                END
                else
                BEGIN
                  CLEAR(GRecColis);
                  GRecColis.SetRange("Shipping No.",Rec."Shipping No.");
                  GRecColis.SetRange("Type of package",Rec."Type of package");
                  if GRecColis.COUNT >0 Then
                  BEGIN
                    FModiReferenceColis(0,Rec); // 0 pour incrémentation
                    Rec."Package Reference" := FORMAT(GRecColis.COUNT+1) + '/'+FORMAT(GRecColis.COUNT+1);
                  END
                  else
                  BEGIN
                    Rec."Package Reference" := '1/1';
                  END;
                END;
                */

            end;
        }
        field(17; "Product Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Length (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Length (cm)" * "Width (cm)" * "Height (cm)") * 0.000001;
            end;
        }
        field(25; "Width (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := ("Length (cm)" * "Width (cm)" * "Height (cm)") * 0.000001;
            end;
        }
        field(30; "Height (cm)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Volume (m3)" := "Length (cm)" * "Width (cm)" * "Height (cm)" * 0.000001;
            end;
        }
        field(35; "Volume (m3)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(40; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(45; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(50; "Nb of pieces"; Decimal)
        {
            //todo table spe
            // CalcFormula = Sum(Packaging.Quantité WHERE("Package No."=FIELD("Package No.")));
            FieldClass = FlowField;
        }
        field(51; "Title type of package"; Text[60])
        {
            CalcFormula = lookup(NatureColisage.Intituler where(No = field("Type of package")));
            FieldClass = FlowField;
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
    var
        LIntI: Integer;
        LIntNbColis: Integer;
    begin
        GRecColis.SetRange("Shipping No.", Rec."Shipping No.");
        GRecColis.SetRange("Type of package", Rec."Type of package");
        //todo table spe
        // if GRecColis.FINDLAST then begin
        //  GRecColisage.SetRange("Package No.", Rec."Package No.");
        //     if GRecColisage.FINDFIRST then begin
        //         if not CONFIRM('Attention : des lignes de colisage sont rattachées à ce colis, êtes-vous sûr de vouloir les supprimer ?', false) then
        //             Error('Suppression annulée par l''utilisateur');
        //         // supresion de la lsite colisage
        //         CLEAR(GRecColisage);
        //         GRecColisage.SetRange("Package No.", Rec."Package No.");
        //         GRecColisage.DELETEALL;

        //         GRecSalesShipingLine.SetRange("Document No.", Rec."Shipping No.");
        //         GRecSalesShipingLine.SetRange("N° Package", Rec."Package No.");
        //         GRecSalesShipingLine.MODIFYALL("N° Package", '');
        //         COMMIT;
        //         //DELPHI AUB 05.07.2021
        //         /*LIntI := 1;
        //         LRecColis.Reset();
        //         LRecColis.SETFILTER("Shipping No.",Rec."Shipping No.");
        //         LIntNbColis := LRecColis.COUNT - 1;

        //         if LRecColis.FIND('-') Then
        //         REPEAT
        //           LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNbColis);
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
        LRecColis: Record Package;
        LIntI: Integer;
        LIntNoFinal: Integer;
    begin
        if "Package No." = '' then begin
            ParamVente.Get();
            //todo not migrated yet
            //  "Package No." := GestionNoSouche.DoGetNextNo(ParamVente."Souche N° colis", TODAY, true, false);
        end;

        if Rec.GETFILTER("Shipping No.") <> '' then
            "Shipping No." := Rec.GETFILTER("Shipping No.");
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
        //todo table spe
        // GRecColisage: Record 50010;
        GRecSalesShipingLine: Record "Sales Shipment Line";
        GRecColis: Record Package;
        LRecColis: Record Package;

    procedure FModiReferenceColis(PSigne: Option PLUS,MOINS)
    var
        LRecColis: Record Package;
    begin
        MESSAGE(Rec."Shipping No.");
    end;

    procedure FRecalculer(PRecColis: Record Package; PBooAjout: Boolean)
    var
        LRecColis: Record Package;
        LIntNoFinal: Integer;
        LIntI: Integer;
        LRecColis2: Record Package;
    begin
        LIntI := 1;
        /*LRecColis.SetRange("Shipping No.",PRecColis."Shipping No.");
        LRecColis.SETFILTER("Package No.",'<>%1',PRecColis."Package No.");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST Then
        REPEAT
          if PBooAjout Then
            LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal+1)
          else
            LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
          LRecColis.MODIFY;
          LIntI += 1;
        UNTIL LRecColis.NEXT=0;
        */

        LRecColis.SetRange("Shipping No.", PRecColis."Shipping No.");
        LIntNoFinal := LRecColis.COUNT();
        if LRecColis.FINDFIRST() then
            repeat
                if PBooAjout then
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal + 1)
                else
                    LRecColis."Package Reference" := FORMAT(LIntI) + '/' + FORMAT(LIntNoFinal);
                LRecColis.MODIFY();
                COMMIT();
                LIntI += 1;
            until LRecColis.NEXT() <= 0;

    end;
}

