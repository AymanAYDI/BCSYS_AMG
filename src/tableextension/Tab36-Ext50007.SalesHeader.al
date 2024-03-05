namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
tableextension 50007 SalesHeader extends "Sales Header" //36
{
    fields
    {
        modify("Bill-to Name")
        {
            TableRelation = Customer;
        }
        modify("On Hold")
        {
            Caption = 'On Hold', Comment = 'FRA="En attente"';
        }
        modify("Sell-to Customer Name")
        {
            TableRelation = Customer;
        }
        //todo AccessByPermission cannot be customized
        // modify("Requested Delivery Date")
        // {
        //     AccessByPermission = TableData 99000880 = R;
        // }
        field(50000; "Délai de livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Durée de validité"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Gross Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Gross Weight" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Description = 'EURIS_EDIT';
            FieldClass = FlowField;
        }
        field(50070; "Net Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Net Weight" where("Document Type" = field("Document Type"),
                                                               "Document No." = field("No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Description = 'EURIS_EDIT';
            FieldClass = FlowField;
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
    //todo Onlookup Bill-to Contact line 357
    //todo Verifier line 639
    //todo i can't find solution for line  702 & 712
    //todo i can't find solution for Onlookup of "Sell-to Customer Name"
    //todo i can't find solution for OnValidate of "Sell-to E-Mail"
    //todo field group dropdown 2145
    //todo verifier 2681
    //todo line 2800
    //todo verifier line 3948
    //todo verifier line 3958
    //todo verifier line 4028
    //todo check ValidateTaxAreaCode
}

