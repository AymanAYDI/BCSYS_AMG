namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.CRM.Contact;
tableextension 50028 Contact extends Contact //5050
{
    fields
    {
        field(50000; "Holding Company"; Text[100])
        {
            Caption = 'Holding Company';
        }
    }
}

