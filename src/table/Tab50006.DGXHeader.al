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
        field(1; "No DGX"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Type DGX"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Multimodal,Aérien cargo,Aérien passager';
            OptionMembers = "Multi-modal","Aerien cargo","Aerien passager";
        }
        field(10; Destinataire; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(11; "Destinataire nom"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Destinataire adresse 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Destinataire adresse 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Destinataire code postal"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Destinataire ville"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Destinataire pays EN"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Type de transport"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = cargo,passager;
        }
        field(30; "Aéroport de départ"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Radioactif; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Date document"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "No Bon Livraison"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No.";

            trigger OnValidate()
            var
                LRecBLHeader: Record "Sales Shipment Header";
                LRecPays: Record "Country/Region";
            begin
                if LRecBLHeader.Get("No Bon Livraison") then begin
                    Destinataire := LRecBLHeader."Sell-to Customer No.";
                    "Destinataire adresse 1" := LRecBLHeader."Ship-to Address";
                    "Destinataire adresse 2" := LRecBLHeader."Ship-to Address 2";
                    "Destinataire code postal" := LRecBLHeader."Ship-to Post Code";
                    "Destinataire nom" := LRecBLHeader."Ship-to Name";
                    "Destinataire ville" := LRecBLHeader."Ship-to City";
                    "Date document" := LRecBLHeader."Document Date";
                    if LRecPays.Get(LRecBLHeader."Sell-to Country/Region Code") then "Destinataire pays EN" := LRecPays."County Name";
                end;
            end;
        }
        field(70; "Masse brute totale"; Decimal)
        {
            CalcFormula = sum("DGX Lines"."Masse brute (kg)" where(DGXNo = field("No DGX")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No DGX")
        {
            Clustered = true;
        }
        key(Key2; "No Bon Livraison")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No DGX" = '' then begin
            ParamVente.Get();
            //todo not migrated yet
            //"No DGX" := GestionNoSouche.DoGetNextNo(ParamVente."Souche N° DGX", TODAY, true, false);
        end;
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
}

