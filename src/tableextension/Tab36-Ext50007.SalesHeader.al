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
            Caption = 'On Hold', Comment = 'On Hold';
        }
        modify("Sell-to Customer Name")
        {
            TableRelation = Customer;
        }
        //TODO AccessByPermission cannot be customized
        // modify("Requested Delivery Date")
        // {
        //     AccessByPermission = TableData 99000880 = R;
        // }
        field(50000; "Delivery time"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Delivery time', Comment = 'Delivery time';
        }
        field(50001; "Validity period"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Validity period', Comment = 'Validity period';
        }
        field(50060; "Gross Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Gross Weight" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(50070; "Net Weight"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Net Weight" where("Document Type" = field("Document Type"),
                                                               "Document No." = field("No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compl. cond. livraison'; //TODO Translation 
        }
    }
    //TODO Onlookup Bill-to Contact line 357
    //TODO Verifier line 639
    //TODO i can't find solution for line  702 & 712
    //TODO i can't find solution for Onlookup of "Sell-to Customer Name"
    //TODO i can't find solution for OnValidate of "Sell-to E-Mail"
    //TODO field group dropdown 2145
    //TODO verifier 2681
    //TODO line 2800
    //TODO verifier line 3948
    //TODO verifier line 3958
    //TODO verifier line 4028
    //TODO check ValidateTaxAreaCode
}

