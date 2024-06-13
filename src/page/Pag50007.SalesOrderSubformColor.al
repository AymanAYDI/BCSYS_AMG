namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Purchases.History;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Item;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Sales.Pricing;
using Microsoft.Utilities;
using Microsoft.Finance.Deferral;
using Microsoft.Finance.Currency;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Archive;
using System.Environment.Configuration;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Setup;
using System.Utilities;
using Microsoft.Foundation.Navigate;
using Microsoft.Foundation.Attachment;
page 50007 "Sales Order Subform Color"
{
    AutoSplitKey = true;
    Caption = 'Lines', Comment = 'FRA="Lignes"';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Order));
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Genera)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                        SetLocationCodeMandatory();
                        UpdateEditableOnRow();
                        UpdateTypeText();
                        DeltaUpdateTotals();
                    end;
                }
                field(FilteredTypeField; TypeAsText)
                {
                    ApplicationArea = All;
                    Caption = 'Type', Comment = 'FRA="Type"';
                    Editable = CurrPageIsEditable;
                    LookupPageID = "Option Lookup List";
                    TableRelation = "Option Lookup Buffer"."Option Caption" where("Lookup Type" = const(Sales));
                    Visible = IsFoundation;

                    trigger OnValidate()
                    begin
                        TempOptionLookupBuffer.SetCurrentType(Rec.Type.AsInteger());
                        if TempOptionLookupBuffer.AutoCompleteLookup(TypeAsText, TempOptionLookupBuffer."Lookup Type"::Sales) then
                            Rec.VALIDATE(Type, TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow();
                        UpdateTypeText();
                        DeltaUpdateTotals();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                        UpdateEditableOnRow();
                        Rec.ShowShortcutDimCode(ShortcutDimCode);

                        QuantityOnAfterValidate();
                        UpdateTypeText();
                        DeltaUpdateTotals();
                        //DELPHI AUB 22.03.2021 AMG.CARBO
                        CurrPage.UPDATE(true);
                        //END DELPHI AUB
                    end;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemReferenceMgt: Codeunit "Item Reference Management";
                    begin
                        ItemReferenceMgt.SalesReferenceNoLookup(Rec, SalesHeader);
                        NoOnAfterValidate();
                    end;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }
                field("Fournisseur article"; Rec."Fournisseur article")
                {
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = Intercompany;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = Intercompany;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate();
                    end;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                    StyleExpr = GTxtStyleText;
                    Visible = true;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        UpdateEditableOnRow();

                        if Rec."No." = xRec."No." then
                            exit;

                        NoOnAfterValidate();
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        UpdateTypeText();
                        DeltaUpdateTotals();
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    QuickEntry = false;
                    ShowMandatory = LocationCodeMandatory;
                    StyleExpr = GTxtStyleText;
                    Visible = LocationCodeVisible;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate();
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field(ReserveF; Rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                        DeltaUpdateTotals();
                    end;
                }
                field("Qté réceptionnée"; GDecQtyReceived)
                {
                    Caption = 'Qté Reçue du Fourn.', Comment = 'FRA="Qté Reçue du Fourn."';
                    DecimalPlaces = 0 : 2;
                    StyleExpr = GTxtStyleText;
                }
                field("Qté en stock"; GDecStock)
                {
                    Caption = 'Qté en stock';
                    DecimalPlaces = 0 : 2;
                    StyleExpr = GTxtStyleText;
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = Assembly;
                    BlankZero = true;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowAsmToOrderLines();
                    end;

                    trigger OnValidate()
                    begin
                        QtyToAsmToOrderOnAfterValidate();
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = Reservation;
                    BlankZero = true;
                    QuickEntry = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida();
                        DeltaUpdateTotals();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Dernier coût direct"; GDecLastDirectCost)
                {
                    Caption = 'Dernier coût direct';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SalesPriceExist; Rec.PriceExists())
                {
                    ApplicationArea = All;
                    Caption = 'Sales Price Exists', Comment = 'FRA="Prix vente existant"';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field(SalesLineDiscExists; Rec.LineDiscExists())
                {
                    ApplicationArea = All;
                    Caption = 'Sales Line Disc. Exists', Comment = 'FRA="Rem. ligne vente existante"';
                    Editable = false;
                    Visible = false;
                }
                field(Marge; Rec.Marge)
                {
                    Editable = false;
                    Importance = Standard;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Marque; Rec.Marque)
                {
                    Style = StrongAccent;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals(); //DELPHI AUB
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals(); //DELPHI AUB
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    Visible = false;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = Prepayments;
                    Visible = false;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = Prepayments;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD();
                        AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(Rec);
                        InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                        ValidateInvoiceDiscountAmount();
                    end;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;

                    trigger OnValidate()
                    begin
                        if Rec."Qty. to Asm. to Order (Base)" <> 0 then begin
                            CurrPage.SAVERECORD();
                            CurrPage.UPDATE(false);
                        end;
                    end;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    QuickEntry = false;
                    StyleExpr = GTxtStyleText;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = Prepayments;
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = Prepayments;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = ItemCharges;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = ItemChargeStyleExpression;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = ItemCharges;
                    BlankZero = true;
                    QuickEntry = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        CurrPage.UPDATE(false);
                    end;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = OrderPromising;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = Planning;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = Planning;

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate();
                    end;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    Visible = false;
                }
                field("<Depr. until FA Posting Date>"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = FixedAssets;
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = FixedAssets;
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = FixedAssets;
                    Visible = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") and (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.ShowDeferralSchedule();
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = DimVisible2;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible3;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible4;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible5;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible6;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible7;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = DimVisible8;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
            group(Group2)
            {
                group(Group3)
                {
                    ShowCaption = false;
                    field(TotalSalesLine_LineAmount; TotalSalesLine."Line Amount")
                    {
                        ApplicationArea = All;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalSalesHeader."Prices Including VAT");
                        Caption = 'Subtotal Excl. VAT', Comment = 'FRA="Sous-total HT"';
                        Editable = false;
                    }
                    field("Invoice Discount Amount"; InvoiceDiscountAmount)
                    {
                        ApplicationArea = All;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FIELDCAPTION("Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
                        Editable = InvDiscAmountEditable;

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate();
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = All;
                        Caption = 'Invoice Discount %', Comment = 'FRA="% remise facture"';
                        DecimalPlaces = 0 : 3;
                        Editable = InvDiscAmountEditable;

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate();
                            AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(Rec);
                            InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                }
                group(Group1)
                {
                    ShowCaption = false;
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
                        ApplicationArea = All;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                        Caption = 'Total Amount Excl. VAT', Comment = 'FRA="Montant total HT"';
                        DrillDown = false;
                        Editable = false;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = All;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
                        Caption = 'Total VAT', Comment = 'FRA="Total TVA"';
                        Editable = false;
                    }
                    field("Total Amount Incl. VAT"; TotalSalesLine."Amount Including VAT")
                    {
                        ApplicationArea = All;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                        Caption = 'Total Amount Incl. VAT', Comment = 'FRA="Montant total TTC"';
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SelectMultiItems)
            {
                AccessByPermission = TableData Item = R;
                ApplicationArea = All;
                Caption = 'Select items', Comment = 'FRA="Sélectionner des articles"';
                Ellipsis = true;
                Image = NewItem;

                trigger OnAction()
                begin
                    Rec.SelectMultipleItems();
                end;
            }
            action(ActRemplir)
            {
                Caption = 'Remplir Qté', Comment = 'FRA="Remplir Qté"';
                Image = AutofillQtyToHandle;
                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET() then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Ship", GRecSalesLine."Outstanding Quantity");
                            if GRecSalesLine."Qty. to Ship (Base)" <> GRecSalesLine."Outstanding Qty. (Base)" then
                                GRecSalesLine.VALIDATE("Qty. to Ship (Base)", GRecSalesLine."Outstanding Qty. (Base)");
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //END DELPHI AUB 08/10/2019
                end;
            }
            action(ActViderAExpedier)
            {
                Caption = 'Vider Qté à expédier', Comment = 'FRA="Vider Qté à expédier"';
                Image = DeleteQtyToHandle;

                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET() then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Ship", 0);
                            if GRecSalesLine."Qty. to Ship (Base)" <> 0 then
                                GRecSalesLine.VALIDATE("Qty. to Ship (Base)", 0);
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //END DELPHI AUB 24/09/2019
                end;
            }
            action(ActViderAFacturer)
            {
                Caption = 'Vider Qté à facturer', Comment = 'FRA="Vider Qté à facturer"';
                Image = DeleteQtyToHandle;

                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.RESET();
                    GRecSalesLine.SETRANGE("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    if GRecSalesLine.FINDSET() then
                        repeat
                            GRecSalesLine.VALIDATE("Qty. to Invoice", 0);
                            if GRecSalesLine."Qty. to Invoice (Base)" <> 0 then
                                GRecSalesLine.VALIDATE("Qty. to Invoice (Base)", 0);
                            GRecSalesLine.MODIFY();
                        until GRecSalesLine.NEXT() = 0;
                    CurrPage.UPDATE(true);
                    //END DELPHI AUB 24/09/2019
                end;
            }
            group("&Line")
            {
                Caption = '&Line', Comment = 'FRA="Ligne"';
                Image = Line;
                group("F&unctions")
                {
                    Caption = 'F&unctions', Comment = 'FRA="Fonctions"';
                    Image = "Action";
                    action(GetPrice)
                    {
                        AccessByPermission = TableData "Sales Price" = R;
                        ApplicationArea = All;
                        Caption = 'Get Price', Comment = 'FRA="Extraire prix"';
                        Ellipsis = true;
                        Image = Price;

                        trigger OnAction()
                        begin
                            ShowPrices();
                        end;
                    }
                    action("Get Li&ne Discount")
                    {
                        AccessByPermission = TableData "Sales Line Discount" = R;
                        ApplicationArea = All;
                        Caption = 'Get Li&ne Discount', Comment = 'FRA="Extraire remise ligne"';
                        Ellipsis = true;
                        Image = LineDiscount;

                        trigger OnAction()
                        begin
                            ShowLineDisc()
                        end;
                    }
                    action(ExplodeBOM_Functions)
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Suite;
                        Caption = 'E&xplode BOM', Comment = 'FRA="Eclater nomenclature"';
                        Image = ExplodeBOM;

                        trigger OnAction()
                        begin
                            ExplodeBOM();
                        end;
                    }
                    action("Insert Ext. Texts")
                    {
                        AccessByPermission = TableData "Extended Text Header" = R;
                        ApplicationArea = All;
                        Caption = 'Insert &Ext. Texts', Comment = 'FRA="Insérer textes étendus"';
                        Image = Text;

                        trigger OnAction()
                        begin
                            InsertExtendedText(true);
                        end;
                    }
                    action(Reserve)
                    {
                        ApplicationArea = Reservation;
                        Caption = '&Reserve', Comment = 'FRA="Réserver"';
                        Ellipsis = true;
                        Image = Reserve;

                        trigger OnAction()
                        begin
                            Rec.FIND();
                            Rec.ShowReservation();
                        end;
                    }
                    action(OrderTracking)
                    {
                        ApplicationArea = All;
                        Caption = 'Order &Tracking', Comment = 'FRA="Chaînage"';
                        Image = OrderTracking;

                        trigger OnAction()
                        begin
                            ShowTracking();
                        end;
                    }
                    action("Select Nonstoc&k Items")
                    {
                        AccessByPermission = TableData "Nonstock Item" = R;
                        ApplicationArea = All;
                        Caption = 'Select Ca&talog Items', Comment = 'FRA="Sélectionner des articles de catalogue"';
                        Image = NonStockItem;

                        trigger OnAction()
                        begin
                            ShowNonstockItems();
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by', Comment = 'FRA="Disponibilité article par"';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        ApplicationArea = All;
                        Caption = 'Event', Comment = 'FRA="Événement"';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent())
                        end;
                    }
                    action(ItemAvailabilityByPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Period', Comment = 'FRA="Période"';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        end;
                    }
                    action(ItemAvailabilityByVariant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant', Comment = 'FRA="Variante"';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant())
                        end;
                    }
                    action(ItemAvailabilityByLocation)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location', Comment = 'FRA="Magasin"';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation())
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level', Comment = 'FRA="Niveau nomenclature"';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM())
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information', Comment = 'FRA="Informations connexes"';
                    action("Reservation Entries")
                    {
                        AccessByPermission = TableData Item = R;
                        ApplicationArea = Reservation;
                        Caption = 'Reservation Entries', Comment = 'FRA="Écritures réservation"';
                        Image = ReservationLedger;

                        trigger OnAction()
                        begin
                            Rec.ShowReservationEntries(true);
                        end;
                    }
                    action(ItemTrackingLines)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item &Tracking Lines', Comment = 'FRA="Lignes traçabilité"';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Shift+Ctrl+I';

                        trigger OnAction()
                        begin
                            Rec.OpenItemTrackingLines();
                        end;
                    }
                    action(SelectItemSubstitution)
                    {
                        AccessByPermission = TableData "Item Substitution" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution', Comment = 'FRA="Sélectionner article de substitution"';
                        Image = SelectItemSubstitution;

                        trigger OnAction()
                        begin
                            CurrPage.SAVERECORD();
                            Rec.ShowItemSub();
                            CurrPage.UPDATE(true);
                            Rec.AutoReserve();
                        end;
                    }
                    action(Dimensions)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                        Image = Dimensions;
                        ShortCutKey = 'Shift+Ctrl+D';

                        trigger OnAction()
                        begin
                            Rec.ShowDimensions();
                        end;
                    }
                    action("Co&mments")
                    {
                        ApplicationArea = Comments;
                        Caption = 'Co&mments', Comment = 'FRA="Commentaires"';
                        Image = ViewComments;

                        trigger OnAction()
                        begin
                            Rec.ShowLineComments();
                        end;
                    }
                    action("Item Charge &Assignment")
                    {
                        AccessByPermission = TableData "Item Charge" = R;
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charge &Assignment', Comment = 'FRA="Affectation frais annexes"';
                        Image = ItemCosts;

                        trigger OnAction()
                        begin
                            ItemChargeAssgnt();
                            SetItemChargeFieldsStyle();
                        end;
                    }
                    action(OrderPromising)
                    {
                        AccessByPermission = TableData "Order Promising Line" = R;
                        ApplicationArea = OrderPromising;
                        Caption = 'Order &Promising', Comment = 'FRA="Promesse de livraison"';
                        Image = OrderPromising;

                        trigger OnAction()
                        begin
                            OrderPromisingLine();
                        end;
                    }
                    action(DocAttach)
                    {
                        ApplicationArea = All;
                        Caption = 'Attachments', Comment = 'FRA="Pièces jointes"';
                        Image = Attach;

                        trigger OnAction()
                        var
                            DocumentAttachmentDetails: Page "Document Attachment Details";
                            RecRef: RecordRef;
                        begin
                            RecRef.GETTABLE(Rec);
                            DocumentAttachmentDetails.OpenForRecRef(RecRef);
                            DocumentAttachmentDetails.RUNMODAL();
                        end;
                    }
                    group("Assemble to Order")
                    {
                        Caption = 'Assemble to Order', Comment = 'FRA="Assembler pour commande"';
                        Image = AssemblyBOM;
                        action(AssembleToOrderLines)
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Assemble-to-Order Lines', Comment = 'FRA="Lignes Assembler pour commande"';

                            trigger OnAction()
                            begin
                                Rec.ShowAsmToOrderLines();
                            end;
                        }
                        action("Roll Up &Price")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Price', Comment = 'FRA="Prix relation"';
                            Ellipsis = true;

                            trigger OnAction()
                            begin
                                Rec.RollupAsmPrice();
                            end;
                        }
                        action("Roll Up &Cost")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Cost', Comment = 'FRA="Coûts relation"';
                            Ellipsis = true;

                            trigger OnAction()
                            begin
                                Rec.RollUpAsmCost();
                            end;
                        }
                    }
                    action(DocumentLineTracking)
                    {
                        ApplicationArea = All;
                        Caption = 'Document &Line Tracking', Comment = 'FRA="Traçabilité ligne document"';
                        Image = Navigate;

                        trigger OnAction()
                        begin
                            ShowDocumentLineTracking();
                        end;
                    }
                    action(DeferralSchedule)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Schedule', Comment = 'FRA="Tableau d''échelonnement"';
                        Enabled = Rec."Deferral Code" <> '';
                        Image = PaymentPeriod;

                        trigger OnAction()
                        begin
                            Rec.ShowDeferralSchedule();
                        end;
                    }
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder', Comment = 'FRA="Commande"';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment', Comment = 'FRA="Livraison directe"';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Purchase &Order', Comment = 'FRA="Commande achat"';
                        Image = Document;

                        trigger OnAction()
                        begin
                            OpenPurchOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order', Comment = 'FRA="Commande spéciale"';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = All;
                        Caption = 'Purchase &Order', Comment = 'FRA="Commande achat"';
                        Image = Document;

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm();
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order', Comment = 'FRA="Commande ouverte"';
                    Image = BlanketOrder;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        BlanketSalesOrder: Page "Blanket Sales Order";
                    begin
                        Rec.TESTFIELD("Blanket Order No.");
                        SalesHeader.SETRANGE("No.", Rec."Blanket Order No.");
                        if not SalesHeader.ISEMPTY then begin
                            BlanketSalesOrder.SETTABLEVIEW(SalesHeader);
                            BlanketSalesOrder.EDITABLE := false;
                            BlanketSalesOrder.RUN();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetTotalSalesHeader();
        CalculateTotals();
        SetLocationCodeMandatory();
        UpdateEditableOnRow();
        UpdateTypeText();
        SetItemChargeFieldsStyle();
    end;

    trigger OnAfterGetRecord()
    var
        LRecItem: Record Item;
        LRecPurchInvHeader: Record "Purch. Inv. Header";
        LRecPurchInvLine: Record "Purch. Inv. Line";
        LRecPurchHeaderArchive: Record "Purchase Header Archive";
        LRecPurchaseLine: Record "Purchase Line";
        LRecPurchLineArchive: Record "Purchase Line Archive";
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateTypeText();
        SetItemChargeFieldsStyle();
        GTxtStyleText := 'Standard';
        GDecQtyReceived := 0;
        GDecStock := 0;
        GDecLastDirectCost := 0;
        if Rec.Type = Rec.Type::Item then begin
            LRecItem.RESET();
            if LRecItem.GET(Rec."No.") then begin
                LRecItem.CALCFIELDS(Inventory);
                GDecStock := LRecItem.Inventory;
                //DELPHI AUB 19.12.19 affichage Dernier coût direct
                GDecLastDirectCost := LRecItem."Last Direct Cost";
                //END DELPHI AUB 19.12.19
            end;
            LRecPurchaseLine.RESET();
            if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
                LRecPurchaseLine.SETRANGE("Document No.", Rec."Special Order Purchase No.");
                LRecPurchaseLine.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                if LRecPurchaseLine.FINDFIRST() then
                    GDecQtyReceived := LRecPurchaseLine."Quantity Received"
                else begin
                    // If no result, search in Purch. Invoice Lines
                    LRecPurchInvHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
                    if LRecPurchInvHeader.FIND('-') then
                        repeat
                            LRecPurchInvLine.SETRANGE("Document No.", LRecPurchInvHeader."No.");
                            LRecPurchInvLine.SETRANGE(Type, Rec.Type::Item);
                            LRecPurchInvLine.SETRANGE("No.", Rec."No.");
                            LRecPurchInvLine.SETFILTER(Quantity, '<>0');
                            if LRecPurchInvLine.FIND('-') then
                                repeat
                                    GDecQtyReceived += LRecPurchInvLine.Quantity;
                                until LRecPurchInvLine.NEXT() = 0;
                        until LRecPurchInvHeader.NEXT() = 0
                    else begin
                        //DELPHI AUB search in Purchase Order Archives 03.09.2020
                        LRecPurchHeaderArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                        LRecPurchHeaderArchive.SETRANGE("No.", Rec."Special Order Purchase No.");
                        if LRecPurchHeaderArchive.FINDLAST() then begin
                            LRecPurchLineArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                            LRecPurchLineArchive.SETRANGE("Document No.", LRecPurchHeaderArchive."No.");
                            LRecPurchLineArchive.SETRANGE("Doc. No. Occurrence", LRecPurchHeaderArchive."Doc. No. Occurrence");
                            LRecPurchLineArchive.SETRANGE("Version No.", LRecPurchHeaderArchive."Version No.");
                            LRecPurchLineArchive.SETRANGE("Line No.", Rec."Special Order Purch. Line No.");
                            if LRecPurchLineArchive.FINDFIRST() then
                                GDecQtyReceived += LRecPurchLineArchive."Quantity Received";
                        end;
                    end;
                end;
            end else
                //No Special Order - verify quantity in stock
                if (Rec.Quantity > GDecStock) then
                    GTxtStyleText := 'StandardAccent'
                else
                    GTxtStyleText := 'StrongAccent';
        end;
        if (GDecQtyReceived > 0) and (GDecQtyReceived >= Rec.Quantity) then
            GTxtStyleText := 'Favorable'
        else
            if GDecQtyReceived > 0 then
                GTxtStyleText := 'Ambiguous';
        //END DELPHI AUB

    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT();
            if not ReserveSalesLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReserveSalesLine.DeleteLine(Rec);
        end;
        DocumentTotals.SalesDocTotalsNotUpToDate();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        DocumentTotals.SalesCheckAndClearTotals(Rec, xRec, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        exit(Rec.FIND(Which));
    end;

    trigger OnInit()
    begin
        SalesSetup.GET();
        InventorySetup.GET();
        Currency.InitRoundingPrecision();
        TempOptionLookupBuffer.FillLookupBuffer(TempOptionLookupBuffer."Lookup Type"::Sales);
        IsFoundation := ApplicationAreaMgmtFacade.IsFoundationEnabled();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DocumentTotals.SalesCheckIfDocumentChanged(Rec, xRec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();

        // Default to Item for the first line and to previous line type for the others
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            if xRec."Document No." = '' then
                Rec.Type := Rec.Type::Item;
        CLEAR(ShortcutDimCode);
        UpdateTypeText();
    end;

    trigger OnOpenPage()
    var
        Location: Record Location;
    begin
        if Location.READPERMISSION then
            LocationCodeVisible := not Location.ISEMPTY;

        SetDimensionsVisibility();
    end;

    var
        Currency: Record Currency;
        InventorySetup: Record "Inventory Setup";
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        TotalSalesHeader: Record "Sales Header";
        GRecSalesLine: Record "Sales Line";
        TotalSalesLine: Record "Sales Line";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        DocumentTotals: Codeunit "Document Totals";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        CurrPageIsEditable: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        InvDiscAmountEditable: Boolean;
        IsBlankNumber: Boolean;
        IsCommentLine: Boolean;
        IsFoundation: Boolean;
        LocationCodeMandatory: Boolean;
        LocationCodeVisible: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        AmountWithDiscountAllowed: Decimal;
        GDecLastDirectCost: Decimal;
        GDecQtyReceived: Decimal;
        GDecStock: Decimal;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        VATAmount: Decimal;
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.', Comment = 'FRA="Vous ne pouvez pas utiliser la fonction Éclater nomenclature car un acompte de la commande vente a été facturé."';
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?', Comment = 'FRA="Une ou plusieurs lignes ont été facturées. La remise répartie sur les lignes facturées n''est pas prise en compte.\\Voulez-vous mettre à jour la remise facture ?"';
        ItemChargeStyleExpression: Text;
        TypeAsText: Text[30];
        GTxtStyleText: Text[80];

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate();
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        SalesHeaderL: Record "Sales Header";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        SalesHeaderL.GET(Rec."Document Type", Rec."Document No.");
        if SalesHeaderL.InvoicedLineExists() then
            if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true) then
                exit;

        SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, SalesHeaderL);
        DocumentTotals.SalesDocTotalsNotUpToDate();
        CurrPage.UPDATE(false);
    end;

    procedure CalcInvDisc()
    var
        SalesCalcDiscount: Codeunit "Sales-Calc. Discount";
    begin
        SalesCalcDiscount.CalculateInvoiceDiscountOnLine(Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate();
    end;

    procedure ExplodeBOM()
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate();
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        Rec.TESTFIELD("Purchase Order No.");
        PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := false;
        PurchOrder.RUN();
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        Rec.TESTFIELD("Special Order Purchase No.");
        PurchHeader.SETRANGE("No.", Rec."Special Order Purchase No.");
        if not PurchHeader.ISEMPTY then begin
            PurchOrder.SETTABLEVIEW(PurchHeader);
            PurchOrder.EDITABLE := false;
            PurchOrder.RUN();
        end else begin
            PurchRcptHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
            if PurchRcptHeader.COUNT = 1 then
                PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
            else
                PAGE.RUN(PAGE::"Posted Purchase Receipts", PurchRcptHeader);
        end;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            COMMIT();
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock();
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL();
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
        OrderPromisingLine.SetRange("Source ID", Rec."Document No.");
        OrderPromisingLine.SetRange("Source Line No.", Rec."Line No.");

        OrderPromisingLines.SetSource(OrderPromisingLine."Source Type"::Sales);
        OrderPromisingLines.SetTableView(OrderPromisingLine);
        OrderPromisingLines.RunModal();
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD();

        SaveAndAutoAsmToOrder();

        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            if (Rec."Outstanding Qty. (Base)" <> 0) and (Rec."No." <> xRec."No.") then begin
                Rec.AutoReserve();
                CurrPage.UPDATE(false);
            end;
        end;
    end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder();

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
        end;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SAVERECORD();
                        Rec.AutoReserve();
                    end;
            end;
    end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        if Rec.Reserve = Rec.Reserve::Always then
            Rec.AutoReserve();
        CurrPage.UPDATE(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        DeltaUpdateTotals();
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Shipment Date" <> xRec."Shipment Date")
        then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(false);
        end else
            CurrPage.UPDATE(true);
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        if (Rec.Type = Rec.Type::Item) and Rec.IsAsmToOrderRequired() then begin
            CurrPage.SAVERECORD();
            Rec.AutoAsmToOrder();
            CurrPage.UPDATE(false);
        end;
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTrackingPage: Page "Document Line Tracking";
    begin
        //TODO : A activer après migration des données
        // Clear(DocumentLineTrackingPage);
        // DocumentLineTrackingPage.SetSourceDoc(
        //     "Document Line Source Type"::"Sales Order", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        // DocumentLineTrackingPage.RunModal();
    end;

    local procedure SetLocationCodeMandatory()
    begin
        LocationCodeMandatory := InventorySetup."Location Mandatory" and (Rec.Type = Rec.Type::Item);
    end;

    local procedure GetTotalSalesHeader()
    begin
        DocumentTotals.GetTotalSalesHeaderAndCurrency(Rec, TotalSalesHeader, Currency);
    end;

    local procedure CalculateTotals()
    begin
        DocumentTotals.SalesCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculateSalesSubPageTotals(TotalSalesHeader, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshSalesLine(Rec);
    end;

    local procedure DeltaUpdateTotals()
    begin
        DocumentTotals.SalesDeltaUpdateTotals(Rec, xRec, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    end;

    local procedure UpdateEditableOnRow()
    begin
        IsCommentLine := not Rec.HasTypeToFillMandatoryFields();
        UnitofMeasureCodeIsChangeable := not IsCommentLine;

        CurrPageIsEditable := CurrPage.EDITABLE;
        IsBlankNumber := Rec."No." = '';
        InvDiscAmountEditable := CurrPageIsEditable and not SalesSetup."Calc. Inv. Discount";
    end;

    local procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        if not IsFoundation then
            exit;
        RecRef.GETTABLE(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.FIELD(Rec.FIELDNO(Type)));
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        if Rec.AssignedItemCharge() and (Rec."Qty. Assigned" <> Rec.Quantity) then
            ItemChargeStyleExpression := 'Unfavorable';
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        CLEAR(DimMgt);
    end;
}

