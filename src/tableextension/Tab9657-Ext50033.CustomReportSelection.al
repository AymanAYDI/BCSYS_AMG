namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Foundation.Reporting;
tableextension 50033 CustomReportSelection extends "Custom Report Selection" //9657
{
    fields
    {
        modify(Usage)
        {
            OptionCaption = 'S.Quote,S.Order,S.Invoice,S.Cr.Memo,S.Test,P.Quote,P.Order,P.Invoice,P.Cr.Memo,P.Receipt,P.Ret.Shpt.,P.Test,B.Stmt,B.Recon.Test,B.Check,Reminder,Fin.Charge,Rem.Test,F.C.Test,Prod.Order,S.Blanket,P.Blanket,M1,M2,M3,M4,Inv1,Inv2,Inv3,SM.Quote,SM.Order,SM.Invoice,SM.Credit Memo,SM.Contract Quote,SM.Contract,SM.Test,S.Return,P.Return,S.Shipment,S.Ret.Rcpt.,S.Work Order,Invt.Period Test,SM.Shipment,S.Test Prepmt.,P.Test Prepmt.,S.Arch.Quote,S.Arch.Order,P.Arch.Quote,P.Arch.Order,S.Arch.Return,P.Arch.Return,Asm.Order,P.Asm.Order,S.Order Pick Instruction,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,P.V.Remit.,C.Statement,V.Remittance,JQ,S.Invoice Draft,Pro Forma S. Invoice,S.Arch.Blanket,P.Arch.Blanket,Phys.Invt.Order Test,Phys.Invt.Order,P.Phys.Invt.Order,Phys.Invt.Rec.,P.Phys.Invt.Rec.,P.Order VAT,S.Proforma';

            //Unsupported feature: Property Modification (OptionString) on "Usage(Field 3)".

        }

        //Unsupported feature: Code Modification on ""Report ID"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        if ("Report ID" = 0) OR ("Report ID" <> xRec."Report ID") Then BEGIN
          VALIDATE("Custom Report Layout Code",'');
          VALIDATE("Email Body Layout Code",'');
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        */
        //end;

        //Unsupported feature: Deletion on ""Send To Email"(Field 9).OnValidate".

    }
}

