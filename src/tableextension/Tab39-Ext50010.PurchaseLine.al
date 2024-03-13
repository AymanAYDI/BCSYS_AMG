namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Purchases.Document;
using Microsoft.Utilities;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Inventory.Item;
using Microsoft.Finance.ReceivablesPayables;
using System.Environment.Configuration;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.Currency;
tableextension 50010 PurchaseLine extends "Purchase Line" //39
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"),
                                     "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true),
                                                                                          "Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Item)) Item where(Blocked = const(false),
                "Purchasing Blocked" = const(false));
            trigger OnAfterValidate()
            var
                PostingSetupMgt: Codeunit PostingSetupManagement;
            begin
                PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group", "VAT Prod. Posting Group");
            end;
        }
        modify(Description)
        {
            TableRelation = if (Type = const("G/L Account"),
                                "System-Created Entry" = const(false)) "G/L Account".Name where("Direct Posting" = const(true),
                                                                                          "Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account".Name
            else
            if (Type = const(Item)) Item.Description where(Blocked = const(false),
            "Purchasing Blocked" = const(false))
            else
            if (Type = const("Fixed Asset")) "Fixed Asset".Description
            else
            if (Type = const("Charge (Item)")) "Item Charge".Description;
        }
        modify("Blanket Order No.")
        {
            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            Caption = 'Blanket Order Line No.';
        }
        //todo editable cannot be customized
        // modify("Receipt No.")
        // {
        //     editable = true;
        // }
    }
    var
        FindRecordMgt: codeunit 703;

        ConfirmManagement: codeunit 27;

        Text017: Label '\The entered information may be disregarded by warehouse operations.';

    var
        AnotherItemWithSameDescrQst: Label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment = '%1=Item no., %2=item description';
        AnotherChargeItemWithSameDescQst: Label 'Item charge No. %1 also has the description "%2".\Do you want to change the current item charge no. to %1?', Comment = '%1=Item charge no., %2=item charge description';
        AnotherItemWithSameDescrQst: Label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment = '%1=Item no., %2=item description';

    procedure SendBlockedItemNotification()
    var
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        NotificationToSend: Notification;
        BlockedItemNotificationMsg: Label 'Item %1 is blocked, but it is allowed on this type of document.', Comment = '%1 is Item No.';

    begin
        NotificationToSend.Id := GetBlockedItemNotificationID();
        NotificationToSend.Recall();
        NotificationToSend.Message := StrSubstNo(BlockedItemNotificationMsg, "No.");
        NotificationLifecycleMgt.SendNotification(NotificationToSend, RecordId);
    end;

    procedure GetBlockedItemNotificationID(): Guid
    begin
        exit('963A9FD3-11E8-4CAA-BE3A-7F8CEC9EF8EC');
    end;

    procedure UpdateLineAmount(var LineAmountChanged: Boolean; Currency: Record Currency)
    var
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
    begin
        if Rec."Line Amount" <> xRec."Line Amount" then begin
            "VAT Difference" := 0;
            NonDeductibleVAT.InitNonDeductibleVATDiff(Rec);
            LineAmountChanged := true;
        end;
        if "Line Amount" <> Round(Quantity * "Direct Unit Cost", Currency."Amount Rounding Precision") - "Line Discount Amount" then begin
            "Line Amount" :=
              Round(Quantity * "Direct Unit Cost", Currency."Amount Rounding Precision") - "Line Discount Amount";
            "VAT Difference" := 0;
            NonDeductibleVAT.InitNonDeductibleVATDiff(Rec);
            LineAmountChanged := true;
        end;
    end;
    //todo ondelete
    //todo Onvalidate de Type
    //todo Onvalidate "No."
    //todo Onvalidate Location Code
    //todo OnValidate Description
    //todo OnValidate Allow Invoice Disc.
    //todo OnValidate  VAT Prod. Posting Group
    //todo i can't find slution for line 3513
    //todo i can't find slution for line 3551
    //todo i can't find slution for line 4499
    //todo i can't find slution for line 4348
    //todo i can't find slution for line 4495,4515
}

