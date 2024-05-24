namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.VAT.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.History;
tableextension 50023 VATEntry extends "VAT Entry" //254
{
    fields
    {
        field(50000; "Nom Fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; Adresse; Text[100])
        {
            CalcFormula = lookup(Vendor.Address where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Code postal"; Code[20])
        {
            CalcFormula = lookup(Vendor."Post Code" where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Ville; Text[30])
        {
            CalcFormula = lookup(Vendor.City where("No." = field("Bill-to/Pay-to No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "No. Facture Fourn"; Code[35])
        {
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Invoice No." where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. Facture Fourn', Comment = 'FRA="N° Facture Fourn"';
        }
    }
}

