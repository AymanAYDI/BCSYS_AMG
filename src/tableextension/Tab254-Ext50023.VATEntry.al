namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.History;
tableextension 50023 VATEntry extends "VAT Entry" //254
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Realized Amount"(Field 81)".


        //Unsupported feature: Deletion (FieldCollection) on ""Realized Base"(Field 82)".


        //Unsupported feature: Deletion (FieldCollection) on ""Add.-Curr. Realized Amount"(Field 83)".


        //Unsupported feature: Deletion (FieldCollection) on ""Add.-Curr. Realized Base"(Field 84)".

        field(50000; "Nom Fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; Adresse; Text[100])
        {
            CalcFormula = Lookup(Vendor.Address WHERE("No." = FIELD("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Code postal"; Code[20])
        {
            CalcFormula = Lookup(Vendor."Post Code" WHERE("No." = FIELD("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Ville; Text[30])
        {
            CalcFormula = Lookup(Vendor.City WHERE("No." = FIELD("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "N° Facture Fourn"; Code[35])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "CopyAmountsFromVATEntry(PROCEDURE 6)".//TODO

    //procedure CopyAmountsFromVATEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if WithOppositeSign Then
      Sign := -1
    else
      Sign := 1;
    Base := Sign * VATEntry.Base;
    Amount := Sign * VATEntry.Amount;
    "Unrealized Amount" := Sign * VATEntry."Unrealized Amount";
    "Unrealized Base" := Sign * VATEntry."Unrealized Base";
    "Remaining Unrealized Amount" := Sign * VATEntry."Remaining Unrealized Amount";
    "Remaining Unrealized Base" := Sign * VATEntry."Remaining Unrealized Base";
    "Additional-Currency Amount" := Sign * VATEntry."Additional-Currency Amount";
    "Additional-Currency Base" := Sign * VATEntry."Additional-Currency Base";
    "Add.-Currency Unrealized Amt." := Sign * VATEntry."Add.-Currency Unrealized Amt.";
    "Add.-Currency Unrealized Base" := Sign * VATEntry."Add.-Currency Unrealized Base";
    "Add.-Curr. Rem. Unreal. Amount" := Sign * VATEntry."Add.-Curr. Rem. Unreal. Amount";
    "Add.-Curr. Rem. Unreal. Base" := Sign * VATEntry."Add.-Curr. Rem. Unreal. Base";
    "VAT Difference" := Sign * VATEntry."VAT Difference";
    "Add.-Curr. VAT Difference" := Sign * VATEntry."Add.-Curr. VAT Difference";
    "Realized Amount" := Sign * "Realized Amount";
    "Realized Base" := Sign * "Realized Base";
    "Add.-Curr. Realized Amount" := Sign * "Add.-Curr. Realized Amount";
    "Add.-Curr. Realized Base" := Sign * "Add.-Curr. Realized Base";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    */
    //end;


    //Unsupported feature: Code Modification on "SetUnrealAmountsToZero(PROCEDURE 7)".//TODO

    //procedure SetUnrealAmountsToZero();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Unrealized Amount" := 0;
    "Unrealized Base" := 0;
    "Remaining Unrealized Amount" := 0;
    "Remaining Unrealized Base" := 0;
    "Add.-Currency Unrealized Amt." := 0;
    "Add.-Currency Unrealized Base" := 0;
    "Add.-Curr. Rem. Unreal. Amount" := 0;
    "Add.-Curr. Rem. Unreal. Base" := 0;
    "Realized Amount" := 0;
    "Realized Base" := 0;
    "Add.-Curr. Realized Amount" := 0;
    "Add.-Curr. Realized Base" := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    */
    //end;
}

