namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.History;
tableextension 50023 VATEntry extends "VAT Entry" //254
{
    fields
    {
        field(50000; "Supplier Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Supplier Name', Comment = 'Supplier Name';
        }
        field(50001; Adress; Text[100])
        {
            CalcFormula = lookup(Vendor.Address where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Adress', Comment = 'Adress';
        }
        field(50002; "Postal code"; Code[20])
        {
            CalcFormula = lookup(Vendor."Post Code" where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Postal code', Comment = 'Postal code';
        }
        field(50003; City; Text[30])
        {
            CalcFormula = lookup(Vendor.City where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'City', Comment = 'City';
        }
        field(50004; "Supp Invoice No."; Code[35])
        {
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Invoice No." where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Supp Invoice No.', Comment = 'Supplied Invoice No.';
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

