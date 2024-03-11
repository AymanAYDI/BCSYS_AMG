namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
tableextension 50015 GenJournalLine extends "Gen. Journal Line" //81
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold';//TODO
        }

        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 91).OnValidate".//TODO NO Modification

        //Unsupported feature: Code Modification on ""Bal. VAT Prod. Posting Group"(Field 93).OnValidate".//TODO NO Modification

        //Unsupported feature: Code Modification on ""Recipient Bank Account"(Field 288).OnValidate".//TODO no longer needed?? 

    }
    keys
    {
        key(Key50000; "Journal Template Name", "Journal Batch Name", "Line No.") //TODO--> Verif
        {
            SumIndexFields = "Balance (LCY)";
            MaintainSIFTIndex = false;
        }
    }
}

