namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Payables;
using System.EMail;
using Microsoft.CRM.Contact;
tableextension 50004 Vendor extends Vendor //23
{
    fields
    {
        field(50000; "Nb Ecritures non lettrees"; Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where("Vendor No." = field("No."),
                                                             Open = const(true)));
            FieldClass = FlowField;
            Caption = 'No. of unlettered entries', Comment = 'FRA="Nb écritures non lettrées"';
        }
    }
}

