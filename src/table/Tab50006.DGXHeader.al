namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.Foundation.Address;
using Microsoft.Sales.History;
table 50006 "DGX Header"
{

    fields
    {
        field(1; "No DGX"; Code[20])
        {
            Caption = 'No DGX';
        }
        field(2; "Type DGX"; Enum "Type DGX")
        {
            Caption = 'Type DGX';
        }
        field(10; Destinataire; Code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'Destinataire';
        }
        field(11; "Destinataire nom"; Text[100])
        {
            Caption = 'Destinataire nom';
        }
        field(12; "Destinataire adresse 1"; Text[100])
        {
            Caption = 'Destinataire adresse 1';
        }
        field(13; "Destinataire adresse 2"; Text[50])
        {
            Caption = 'Destinataire adresse 2';
        }
        field(14; "Destinataire code postal"; Code[20])
        {
            Caption = 'Destinataire code postal';
        }
        field(15; "Destinataire ville"; Text[50])
        {
            Caption = 'Destinataire ville';
        }
        field(16; "Destinataire pays EN"; Text[50])
        {
            Caption = 'Destinataire pays EN';
        }
        field(20; "Type de transport"; Option)
        {
            OptionMembers = cargo,passager;
            Caption = 'Type de transport';
        }
        field(30; "Aeroport de depart"; Text[250])
        {
            Caption = 'Aéroport de départ';
        }
        field(40; Radioactif; Boolean)
        {
            Caption = 'Radioactif';
        }
        field(50; "Date document"; Date)
        {
            Caption = 'Date document';
        }
        field(60; "No Bon Livraison"; Code[20])
        {
            TableRelation = "Sales Shipment Header"."No.";
            Caption = 'No Bon Livraison';

            trigger OnValidate()
            var
                LRecBLHeader: Record "Sales Shipment Header";
                LRecPays: Record "Country/Region";
            begin
                if LRecBLHeader.GET("No Bon Livraison") then begin
                    Destinataire := LRecBLHeader."Sell-to Customer No.";
                    "Destinataire adresse 1" := LRecBLHeader."Ship-to Address";
                    "Destinataire adresse 2" := LRecBLHeader."Ship-to Address 2";
                    "Destinataire code postal" := LRecBLHeader."Ship-to Post Code";
                    "Destinataire nom" := LRecBLHeader."Ship-to Name";
                    "Destinataire ville" := LRecBLHeader."Ship-to City";
                    "Date document" := LRecBLHeader."Document Date";
                    if LRecPays.GET(LRecBLHeader."Sell-to Country/Region Code") then "Destinataire pays EN" := LRecPays."County Name";
                end;
            end;
        }
        field(70; "Masse brute totale"; Decimal)
        {
            CalcFormula = sum("DGX Lines"."Masse brute (kg)" where(DGXNo = field("No DGX")));
            FieldClass = FlowField;
            Caption = 'Masse brute totale';
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
            ParamVente.GET();
            "No DGX" := GestionNoSouche.DoGetNextNo(ParamVente."Souche No. DGX", TODAY, true, false);
        end;
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
}

