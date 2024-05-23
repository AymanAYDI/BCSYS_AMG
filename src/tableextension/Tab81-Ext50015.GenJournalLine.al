namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Finance.GeneralLedger.Journal;
tableextension 50015 GenJournalLine extends "Gen. Journal Line" //81
{
    fields
    {
        modify("On Hold")
        {
            Caption = 'On Hold', Comment = 'FRA="En attente"';
        }
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

