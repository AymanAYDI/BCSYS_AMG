namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.History;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
table 50006 "DGX Header"
{

    fields
    {
        field(1; "DGX No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "DGX Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Multimodal,Aérien cargo,Aérien passager';
            OptionMembers = "Multi-modal","Aerien cargo","Aerien passager";
        }
        field(10; Recipient; Code[20])
        {
            Caption = 'Recipient', Comment = 'FRA="Destinataire"';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(11; "Recipient Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Recipient Adress 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Recipient Adress 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Recipient Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Recipient City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Recipient Country EN"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Type of transport"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = cargo,passager;
        }
        field(30; "Airport of departure"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Radioactive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Delivery slip no."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No.";

            trigger OnValidate()
            var
                LRecPays: Record "Country/Region";
                LRecBLHeader: Record "Sales Shipment Header";
            begin
                if LRecBLHeader.Get("Delivery slip no.") then begin
                    Recipient := LRecBLHeader."Sell-to Customer No.";
                    "Recipient Adress 1" := LRecBLHeader."Ship-to Address";
                    "Recipient Adress 2" := LRecBLHeader."Ship-to Address 2";
                    "Recipient Post Code" := LRecBLHeader."Ship-to Post Code";
                    "Recipient Name" := LRecBLHeader."Ship-to Name";
                    "Recipient City" := LRecBLHeader."Ship-to City";
                    "Document Date" := LRecBLHeader."Document Date";
                    if LRecPays.Get(LRecBLHeader."Sell-to Country/Region Code") then "Recipient Country EN" := LRecPays."County Name";
                end;
            end;
        }
        field(70; "Total Gross Mass"; Decimal)
        {
            CalcFormula = sum("DGX Lines"."Gross Mass (kg)" where(DGXNo = field("DGX No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "DGX No.")
        {
            Clustered = true;
        }
        key(Key2; "Delivery slip no.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "DGX No." = '' then
            ParamVente.Get();
        //todo not migrated yet
        "DGX No." := GestionNoSouche.DoGetNextNo(ParamVente."Souche N° DGX", TODAY, true, false);
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
}

