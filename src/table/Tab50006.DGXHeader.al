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
            Caption = 'DGX No.';
        }
        field(2; "DGX Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Multimodal, Air cargo, Air passenger';
            OptionMembers = "Multi-modal","Aerien cargo","Aerien passager";
            Caption = 'DGX Type';
        }
        field(10; Recipient; Code[20])
        {
            Caption = 'Recipient', Comment = 'Recipient';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(11; "Recipient Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Name';
        }
        field(12; "Recipient Adress 1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Adress 1';
        }
        field(13; "Recipient Adress 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Adress 2';
        }
        field(14; "Recipient Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Post Code';
        }
        field(15; "Recipient City"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient City';
        }
        field(16; "Recipient Country EN"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient Country EN';
        }
        field(20; "Type of transport"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = cargo,passager;
            Caption = 'Type of transport';
        }
        field(30; "Airport of departure"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Airport of departure';
        }
        field(40; Radioactive; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Radioactive';
        }
        field(50; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }
        field(60; "Delivery slip no."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header"."No.";
            Caption = 'Delivery slip no.';
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
            Caption = 'Total Gross Mass';
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
        "DGX No." := GestionNoSouche.DoGetNextNo(ParamVente."DGX Serie No.", TODAY, true, false);
    end;

    var
        ParamVente: Record "Sales & Receivables Setup";
        GestionNoSouche: Codeunit NoSeriesManagement;
}

