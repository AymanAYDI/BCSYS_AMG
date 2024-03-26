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
            Caption = 'No. of Blanket Orders', Comment = 'No. of Blanket Orders';
        }
        modify("Pay-to No. of Blanket Orders")
        {
            Caption = 'Pay-to No. of Blanket Orders', Comment = 'Pay-to No. of Blanket Orders';
        }
        modify("E-Mail")
        {
            //TODO check line 750
            trigger OnAfterValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        modify("Primary Contact No.")
        {
            //TODO check line 1015
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
        field(50000; "No. of unlettered entries"; Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where("Vendor No." = field("No."),
                                                             Open = const(true)));
            FieldClass = FlowField;
            Caption = 'No. of unlettered entries', Comment = 'No. of unlettered entries';
        }
    }
    //TODO verifier Ondelete
    //TODO i can't find solution for OnValidate Phone No. line 236
}

