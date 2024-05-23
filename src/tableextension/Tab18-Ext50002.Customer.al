namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Document;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Finance.Dimension;
tableextension 50002 Customer extends Customer //18
{
    fields
    {
        modify("No. of Blanket Orders")
        {
            Caption = 'No. of Blanket Orders', Comment = 'FRA="Nbre de commandes ouvertes"';
        }
        modify("Bill-To No. of Blanket Orders")
        {
            Caption = 'Bill-To No. of Blanket Orders', Comment = 'FRA="Facturation - Nbre de commandes ouvertes"';
        }
        //TODO i can't find solution line 301
        // modify("Phone No.")
        // {
        //     trigger OnBeforeValidate()
        //     var
        //         myInt: Integer;
        //     begin

        //     end;
        // }
        field(50010; ICE; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'ICE';
        }
        field(50100; History; Boolean)
        {
            CalcFormula = exist("Sales Archive" where("Customer No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Archive";
            Caption = 'History';
        }
        field(51010; "Compl. cond. livraison"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Additional terms of delivery'; //TODO translation
        }
    }
    keys
    {

    }
    trigger OnAfterInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        InsertFromTemplate: Boolean;
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";
        InsertFromContact := GetInsertFromContact();
        InsertFromTemplate := GetInsertFromTemplate();
        if (not (InsertFromContact or (InsertFromTemplate and (Contact <> '')) or IsTemporary)) then
            UpdateContFromCust.OnInsert(Rec);

        if "Salesperson Code" = '' then
            SetDefaultSalesperson();

        DimMgt.UpdateDefaultDim(
          DATABASE::Customer, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        UpdateReferencedIds();
        SetLastModifiedDateTime();
    end;

}

