namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.CRM.Contact;

pageextension 50047 "ContactList" extends "Contact List" //5052
{
    layout
    {
        addafter("Mobile Phone No.")
        {
            field("Holding Company"; Rec."Holding Company")
            {
                ApplicationArea = All;
            }
        }
    }
}
