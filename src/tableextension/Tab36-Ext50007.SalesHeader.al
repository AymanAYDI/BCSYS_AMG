namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
tableextension 50007 SalesHeader extends "Sales Header" //36
{
    fields
    {
        field(50000; "Delai de livraison"; Text[80])
        {
            Caption = 'Delai de livraison', Comment = 'FRA="Délai de livraison"';
        }
        field(50001; "Duree de validite"; Text[80])
        {
            Caption = 'Duree de validite', Comment = 'FRA="Durée de validité"';
        }
        field(50060; "Gross Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Gross Weight" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Caption = 'Gross Weight', Comment = 'FRA="Poids brut"';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(50070; "Net Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Net Weight" where("Document Type" = field("Document Type"),
                                                               "Document No." = field("No.")));
            Caption = 'Net Weight', Comment = 'FRA="Poids net"';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Compl. cond. livraison';
        }
    }
}

