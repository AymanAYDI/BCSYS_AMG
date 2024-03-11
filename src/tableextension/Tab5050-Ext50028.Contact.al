namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.CRM.Contact;
tableextension 50028 Contact extends Contact //5050
{
    fields
    {
        modify("Company Name")
        {
            TableRelation = Contact where(Type = const(Company));
        }
        field(50000; "Holding Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

}

