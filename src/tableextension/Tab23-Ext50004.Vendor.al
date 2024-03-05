namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Payables;
using System.EMail;
using Microsoft.CRM.Contact;
tableextension 50004 Vendor extends Vendor //23
{
    fields
    {
        modify("No. of Blanket Orders")
        {
            Caption = 'No. of Blanket Orders', Comment = 'FRA="Nbre de commandes ouvertes"';
        }
        modify("Pay-to No. of Blanket Orders")
        {
            Caption = 'Pay-to No. of Blanket Orders', Comment = 'FRA="Paiement - Nbre de commandes ouvertes"';
        }
        modify("E-Mail")
        {
            //todo chech line 750
            trigger OnAfterValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        modify("Primary Contact No.")
        {
            //todo check line 1015
            trigger OnAfterValidate()
            var
                Cont: Record Contact;
            begin
                if "Primary Contact No." <> '' then begin
                    Cont.Get("Primary Contact No.");
                    if Cont."Mobile Phone No." <> '' then
                        "Mobile Phone No." := Cont."Mobile Phone No.";
                end;
            end;
        }
        field(50000; "Nb écritures non lettrées"; Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where("Vendor No." = field("No."),
                                                             Open = const(true)));
            FieldClass = FlowField;
        }
    }
    //todo verifier Ondelete
    //todo i can't find solution for OnValidate Phone No. line 236
}

