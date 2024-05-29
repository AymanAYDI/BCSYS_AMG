namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
tableextension 50002 Customer extends Customer //18
{
    fields
    {
        field(50010; ICE; Boolean)
        {
            Caption = 'ICE';
        }
        field(50100; History; Boolean)
        {
            CalcFormula = exist("Historique ventes" where("No. client" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Historique ventes";
            Caption = 'History';
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            Caption = 'Compl. cond. livraison';
        }
    }
}

