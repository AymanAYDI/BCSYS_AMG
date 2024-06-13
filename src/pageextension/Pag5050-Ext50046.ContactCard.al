namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.CRM.Contact;

pageextension 50046 "ContactCard" extends "Contact Card" //5050
{
    layout
    {
        addafter("Salutation Code")
        {
            field("Holding Company"; Rec."Holding Company")
            {
                ApplicationArea = All;
            }
        }
    }
}
