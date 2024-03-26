namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Finance.Deferral;
using Microsoft.Finance.Dimension;
using Microsoft.Purchases.History;
using Microsoft.Sales.Pricing;
using Microsoft.Inventory.BOM;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Availability;
using Microsoft.Foundation.Attachment;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Archive;
using Microsoft.Finance.Currency;
using System.Environment.Configuration;
using Microsoft.Inventory.Setup;
using Microsoft.Sales.Setup;
using System.Utilities;
using Microsoft.Foundation.Navigate;
page 50007 "Sales Order Subform Color"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.';

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type';
                    Editable = CurrPageIsEditable;
                    LookupPageID = "Option Lookup List";
                    TableRelation = "Option Lookup Buffer"."Option Caption" where("Lookup Type" = const(Sales));
                    ToolTip = 'Specifies the type of transaction that will be posted with the document line. If you select Comment, then you can enter any text in the Description field, such as a message to a customer. ';
                    Visible = IsFoundation;

                    trigger OnValidate()
                    begin
                        TempOptionLookupBuffer.SetCurrentType(Rec.Type.AsInteger());
                        if TempOptionLookupBuffer.AutoCompleteLookup(TypeAsText, TempOptionLookupBuffer."Lookup Type"::Sales) then
                            Rec.Validate(Type, TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow();
                        UpdateTypeText();
                        DeltaUpdateTotals();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                        UpdateEditableOnRow();
                        Rec.ShowShortcutDimCode(ShortcutDimCode);

                        QuantityOnAfterValidate();
                        UpdateTypeText();
                        DeltaUpdateTotals();
                        //DELPHI AUB 22.03.2021 AMG.CARBO
                        CurrPage.Update(true);
                        //END DELPHI AUB
                    end;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Item Reference number. If you enter a Item Reference number on a sales or purchase document.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesHeader: Record "Sales Header";
                        ItemReferenceMgt: Codeunit "Item Reference Management";
                    begin
                        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
                        ItemReferenceMgt.SalesReferenceNoLookup(Rec, SalesHeader);
                        NoOnAfterValidate();
                        OnReferenceNoOnAfterLookup(Rec);
                    end;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }
                field("Item supplier"; Rec."Item supplier")
                {
                    ToolTip = 'Specifies the value of the Vendor field.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the IC partner. If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate();
                    end;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that a substitute is available for the item on the sales line.';
                    Visible = false;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = true;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that this item is a catalog item.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT product posting group. Links business transactions made for the item, resource, or G/L account with the general ledger, to account for VAT amounts resulting from trade with that record.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ShowMandatory = not IsCommentLine;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies a description of the entry of the product to be sold. To add a non-transactional text line, fill in the Description field only.';

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
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                    Visible = false;
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the item on the sales line is a special-order item.';
                    Visible = false;
                }
                field("Special Order Purchase No."; Rec."Special Order Purchase No.")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Special Order Purchase No. field.';
                }
                field("Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
                {
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Special Order Purch. Line No. field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code explaining why the item was returned.';
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
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    Visible = LocationCodeVisible;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate();
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether a reservation can be made for items on this line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies how many units are being sold.';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                        DeltaUpdateTotals();

                        //DEB DELPHI XAV
                        Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                        Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                        //Modify;
                        //FIN DELPHI XAV
                    end;
                }
                field("Qty received"; GDecQtyReceived)
                {
                    Caption = 'Qty Received from Supplier';
                    DecimalPlaces = 0 : 2;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the Qty Received from the Supplier field.';
                }
                field("Qty In Stock"; GDecStock)
                {
                    DecimalPlaces = 0 : 2;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the value of the GDecStock field.';
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = Assembly;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the sales line quantity that you want to supply by assembly.';
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
                    ToolTip = 'Specifies how many units of the item on the line have been reserved.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida();
                        DeltaUpdateTotals();
                        //DELPHI AUB 25.07.2019
                        Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                        Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                        //Rec.Modify; //AUB 29.05.2020
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the unit of measure for the item or resource on the sales line.';
                    Visible = false;
                }
                field("Last direct cost"; GDecLastDirectCost)
                {
                    ToolTip = 'Specifies the value of the GDecLastDirectCost field.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field(SalesPriceExist; Rec.PriceExists())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    ToolTip = 'Specifies that there is a specific price for this customer.';
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the price for one unit on the sales line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                        //DEB DELPHI XAV
                        Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                        Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                        //Rec.Modify; //AUB 29.05.2020
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = not (IsCommentLine or IsBlankNumber);
                    Enabled = not (IsCommentLine or IsBlankNumber);
                    ShowMandatory = (not IsCommentLine) and (Rec."No." <> '');
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                    end;
                }
                field(SalesLineDiscExists; Rec.LineDiscExists())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    ToolTip = 'Specifies that there is a specific discount for this customer.';
                    Visible = false;
                }
                field(Marge; Rec.Marge)
                {
                    Importance = Standard;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Marge field.';
                }
                field(Marque; Rec.Marque)
                {
                    Style = StrongAccent;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the % Marge field.';
                    trigger OnValidate()
                    begin
                        //DELPHI AUB 16.07.2019 Réactualisation Marge
                        Rec.FCalculateOnMargeChange(Rec."No.", Rec.Marque); //DELPHI AUB
                        DeltaUpdateTotals(); //DELPHI AUB
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the line discount percentage that is valid for the item quantity on the line.';

                    trigger OnValidate()
                    begin
                        Rec.FCalculateMargeOnLineDiscountChange(Rec."No."); //DELPHI AUB
                        DeltaUpdateTotals(); //DELPHI AUB
                        //DEB DELPHI XAV
                        Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                        Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                        Rec.Modify();
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals();
                        //DEB DELPHI XAV
                        Rec.Marge := Rec.FCalculeMarge(Rec."No.", Rec."Quantity (Base)", Rec.Amount);
                        Rec.Marque := Rec.FCalculeMarque(Rec.Marge, Rec.Amount);
                        Rec.Modify();
                    end;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';
                    Visible = false;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount of the line in the currency of the sales document if a prepayment percentage is specified for the sales line.';
                    Visible = false;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been invoiced to the customer for this sales line.';
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total calculated invoice discount amount for the line.';
                    Visible = false;
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the actual invoice discount amount that will be posted for the line in next invoice.';
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the quantity of items that remain to be shipped.';

                    trigger OnValidate()
                    begin
                        if Rec."Qty. to Asm. to Order (Base)" <> 0 then begin
                            CurrPage.SAVERECORD();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as shipped.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    StyleExpr = GTxtStyleText;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = ItemCharges;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = ItemChargeStyleExpression;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';

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
                    ToolTip = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        CurrPage.Update(false);
                    end;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = OrderPromising;
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
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
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the date that the shipment should ship from the warehouse. If the customer requests a delivery date, the program calculates the planned shipment date by subtracting the shipping time from the requested delivery date. If the customer does not request a delivery date or the requested delivery date cannot be met, the program calculates the content of this field by adding the shipment time to the shipping date.';

                    trigger OnValidate()
                    begin
                        UpdateForm(true);
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate();
                    end;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                    Visible = false;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies which work type the resource applies to when the sale is related to a job.';
                    Visible = false;
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.';
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.';
                    Visible = false;
                }
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many assemble-to-order units on the sales order line need to be assembled and handled in warehouse documents.';
                    Visible = false;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many assemble-to-order units on the sales order line remain to be assembled and handled in warehouse documents.';
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the date that will be used on related fixed asset ledger entries.';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies if depreciation was calculated until the FA posting date of the line.';
                    Visible = false;
                }
                field("<Depr. until FA Posting Date>"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies, if the type is Fixed Asset, that information on the line is to be posted to all the assets defined depreciation books. ';
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies a depreciation book code if you want the journal line to be posted to that depreciation book, as well as to the depreciation book in the Depreciation Book Code field.';
                    Visible = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                    Visible = false;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") and (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    ToolTip = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.ShowDeferralSchedule();
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';
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
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the document number.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
            }
            group(Control51)
            {
                group(Control45)
                {
                    field("TotalSalesLineLineAmount"; TotalSalesLine."Line Amount")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code, TotalSalesHeader."Prices Including VAT");
                        Caption = 'Subtotal Excl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
                    }
                    field("Invoice Discount Amount"; InvoiceDiscountAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(rec.FIELDCAPTION("Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate();
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 3;
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate();
                            AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(Rec);
                            InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount();
                        end;
                    }
                }
                group(Control28)
                {
                    field("Total Amount Excl. VAT"; TotalSalesLine.Amount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
                        Caption = 'Total VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of VAT amounts on all lines in the document.';
                    }
                    field("Total Amount Incl. VAT"; TotalSalesLine."Amount Including VAT")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = Rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
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
                ApplicationArea = Basic, Suite;
                Caption = 'Select items';
                Ellipsis = true;
                Image = NewItem;
                ToolTip = 'Add two or more items from the full list of your inventory items.';

                trigger OnAction()
                begin
                    Rec.SelectMultipleItems();
                end;
            }
            action(ActRemplir)
            {
                Caption = 'Fill Qty';
                Image = AutofillQtyToHandle;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Execute the Fill Qty action.';
                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", GRecSalesLine."Outstanding Quantity");
                            if GRecSalesLine."Qty. to Ship (Base)" <> GRecSalesLine."Outstanding Qty. (Base)" then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", GRecSalesLine."Outstanding Qty. (Base)");
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                    //END DELPHI AUB 08/10/2019
                end;
            }
            action(ActViderAExpedier)
            {
                Caption = 'Empty Qty to ship';
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Empty Qty to Ship action.';
                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Ship", 0);
                            if GRecSalesLine."Qty. to Ship (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Ship (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                    //END DELPHI AUB 24/09/2019
                end;
            }
            action(ActViderAFacturer)
            {
                Caption = 'Empty Qty to invoice';
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Execute the Empty Qty to Invoice action.';
                trigger OnAction()
                begin
                    //DELPHI AUB 24/09/2019
                    GRecSalesLine.Reset();
                    GRecSalesLine.SetRange("Document Type", GRecSalesLine."Document Type"::Order);
                    GRecSalesLine.SetRange("Document No.", Rec."Document No.");
                    if GRecSalesLine.FindSet() then
                        repeat
                            GRecSalesLine.Validate("Qty. to Invoice", 0);
                            if GRecSalesLine."Qty. to Invoice (Base)" <> 0 then
                                GRecSalesLine.Validate("Qty. to Invoice (Base)", 0);
                            GRecSalesLine.Modify();
                        until GRecSalesLine.Next() = 0;
                    CurrPage.Update(true);
                    //END DELPHI AUB 24/09/2019
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("F&unctions")
                {
                    Caption = 'F&unctions';
                    Image = "Action";
                    action(GetPrice)
                    {
                        AccessByPermission = TableData "Sales Price" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Price';
                        Ellipsis = true;
                        Image = Price;
                        ToolTip = 'Insert the lowest possible price in the Unit Price field according to any special price that you have set up.';

                        trigger OnAction()
                        begin
                            ShowPrices();
                        end;
                    }
                    action("Get Li&ne Discount")
                    {
                        AccessByPermission = TableData "Sales Line Discount" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Li&ne Discount';
                        Ellipsis = true;
                        Image = LineDiscount;
                        ToolTip = 'Insert the best possible discount in the Line Discount field according to any special discounts that you have set up.';

                        trigger OnAction()
                        begin
                            ShowLineDisc()
                        end;
                    }
                    action(ExplodeBOM_Functions)
                    {
                        AccessByPermission = TableData "BOM Component" = R;
                        ApplicationArea = Suite;
                        Caption = 'E&xplode BOM';
                        Image = ExplodeBOM;
                        ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';

                        trigger OnAction()
                        begin
                            ExplodeBOM();
                        end;
                    }
                    action("Insert Ext. Texts")
                    {
                        AccessByPermission = TableData "Extended Text Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insert &Ext. Texts';
                        Image = Text;
                        ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                        trigger OnAction()
                        begin
                            InsertExtendedText(true);
                        end;
                    }
                    action(ReserveAction)
                    {
                        ApplicationArea = Reservation;
                        Caption = '&Reserve';
                        Ellipsis = true;
                        Image = Reserve;
                        ToolTip = 'Reserve the quantity that is required on the document line that you opened this window for.';

                        trigger OnAction()
                        begin
                            Rec.FIND();
                            Rec.ShowReservation();
                        end;
                    }
                    action(OrderTracking)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order &Tracking';
                        Image = OrderTracking;
                        ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                        trigger OnAction()
                        begin
                            ShowTracking();
                        end;
                    }
                    action("Select Nonstoc&k Items")
                    {
                        AccessByPermission = TableData "Nonstock Item" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Ca&talog Items';
                        Image = NonStockItem;
                        ToolTip = 'View the list of catalog items that exist in the system. ';

                        trigger OnAction()
                        begin
                            ShowNonstockItems();
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByEvent())
                        end;
                    }
                    action(ItemAvailabilityByPeriod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        end;
                    }
                    action(ItemAvailabilityByVariant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByVariant())
                        end;
                    }
                    action(ItemAvailabilityByLocation)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByLocation())
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec, ItemAvailFormsMgt.ByBOM())
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
                    action("Reservation Entries")
                    {
                        AccessByPermission = TableData Item = R;
                        ApplicationArea = Reservation;
                        Caption = 'Reservation Entries';
                        Image = ReservationLedger;
                        ToolTip = 'View the entries for every reservation that is made, either manually or automatically.';

                        trigger OnAction()
                        begin
                            Rec.ShowReservationEntries(true);
                        end;
                    }
                    action(ItemTrackingLines)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item &Tracking Lines';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Shift+Ctrl+I';
                        ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                        trigger OnAction()
                        begin
                            Rec.OpenItemTrackingLines();
                        end;
                    }
                    action(SelectItemSubstitution)
                    {
                        AccessByPermission = TableData "Item Substitution" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution';
                        Image = SelectItemSubstitution;
                        ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                        trigger OnAction()
                        begin
                            CurrPage.SAVERECORD();
                            Rec.ShowItemSub();
                            CurrPage.Update(true);
                            Rec.AutoReserve();
                        end;
                    }
                    action(Dimensions)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                        trigger OnAction()
                        begin
                            Rec.ShowDimensions();
                        end;
                    }
                    action("Co&mments")
                    {
                        ApplicationArea = Comments;
                        Caption = 'Co&mments';
                        Image = ViewComments;
                        ToolTip = 'View or add comments for the record.';

                        trigger OnAction()
                        begin
                            Rec.ShowLineComments();
                        end;
                    }
                    action("Item Charge &Assignment")
                    {
                        AccessByPermission = TableData "Item Charge" = R;
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charge &Assignment';
                        Image = ItemCosts;
                        ToolTip = 'Assign additional direct costs, for example for freight, to the item on the line.';

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
                        Caption = 'Order &Promising';
                        Image = OrderPromising;
                        ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                        trigger OnAction()
                        begin
                            OrderPromisingLine();
                        end;
                    }
                    action(DocAttach)
                    {
                        ApplicationArea = All;
                        Caption = 'Attachments';
                        Image = Attach;
                        ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                        trigger OnAction()
                        var
                            DocumentAttachmentDetails: Page "Document Attachment Details";
                            RecRef: RecordRef;
                        begin
                            RecRef.GETTABLE(Rec);
                            DocumentAttachmentDetails.OpenForRecRef(RecRef);
                            DocumentAttachmentDetails.RunModal();
                        end;
                    }
                    group("Assemble to Order")
                    {
                        Caption = 'Assemble to Order';
                        Image = AssemblyBOM;
                        action(AssembleToOrderLines)
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Assemble-to-Order Lines';
                            ToolTip = 'View any linked assembly order lines if the documents represents an assemble-to-order sale.';

                            trigger OnAction()
                            begin
                                Rec.ShowAsmToOrderLines();
                            end;
                        }
                        action("Roll Up &Price")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Price';
                            Ellipsis = true;
                            ToolTip = 'Update the unit price of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollupAsmPrice();
                            end;
                        }
                        action("Roll Up &Cost")
                        {
                            AccessByPermission = TableData "BOM Component" = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Cost';
                            Ellipsis = true;
                            ToolTip = 'Update the unit cost of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollUpAsmCost();
                            end;
                        }
                    }
                    action(DocumentLineTracking)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document &Line Tracking';
                        Image = Navigate;
                        ToolTip = 'View related open, posted, or archived documents or document lines. ';

                        trigger OnAction()
                        begin
                            ShowDocumentLineTracking();
                        end;
                    }
                    action(DeferralSchedule)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Schedule';
                        Enabled = Rec."Deferral Code" <> '';
                        Image = PaymentPeriod;
                        ToolTip = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.';

                        trigger OnAction()
                        begin
                            Rec.ShowDeferralSchedule();
                        end;
                    }
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenPurchOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm();
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket sales order.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        BlanketSalesOrder: Page "Blanket Sales Order";
                    begin
                        Rec.TESTFIELD("Blanket Order No.");
                        SalesHeader.SetRange("No.", Rec."Blanket Order No.");
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
            LRecItem.Reset();
            if LRecItem.GET(Rec."No.") then begin
                LRecItem.CALCFIELDS(Inventory);
                GDecStock := LRecItem.Inventory;
                GDecLastDirectCost := LRecItem."Last Direct Cost";
            end;
            LRecPurchaseLine.Reset();
            if (Rec."Special Order Purchase No." <> '') and (Rec."Special Order Purch. Line No." <> 0) then begin
                LRecPurchaseLine.SetRange("Document No.", Rec."Special Order Purchase No.");
                LRecPurchaseLine.SetRange("Line No.", Rec."Special Order Purch. Line No.");
                if LRecPurchaseLine.FINDFIRST() then
                    GDecQtyReceived := LRecPurchaseLine."Quantity Received"
                else begin
                    // If no result, search in Purch. Invoice Lines
                    LRecPurchInvHeader.SetRange("Order No.", Rec."Special Order Purchase No.");
                    if LRecPurchInvHeader.FINDSET() then
                        repeat
                            LRecPurchInvLine.SetRange("Document No.", LRecPurchInvHeader."No.");
                            LRecPurchInvLine.SetRange(Type, Rec.Type::Item);
                            LRecPurchInvLine.SetRange("No.", Rec."No.");
                            LRecPurchInvLine.SETFILTER(Quantity, '<>0');
                            if LRecPurchInvLine.FINDSET() then
                                repeat
                                    GDecQtyReceived += LRecPurchInvLine.Quantity;
                                until LRecPurchInvLine.Next() = 0;
                        until LRecPurchInvHeader.Next() = 0
                    else begin
                        LRecPurchHeaderArchive.SetRange("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                        LRecPurchHeaderArchive.SetRange("No.", Rec."Special Order Purchase No.");
                        if LRecPurchHeaderArchive.FINDLAST() then begin
                            LRecPurchLineArchive.SetRange("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                            LRecPurchLineArchive.SetRange("Document No.", LRecPurchHeaderArchive."No.");
                            LRecPurchLineArchive.SetRange("Doc. No. Occurrence", LRecPurchHeaderArchive."Doc. No. Occurrence");
                            LRecPurchLineArchive.SetRange("Version No.", LRecPurchHeaderArchive."Version No.");
                            LRecPurchLineArchive.SetRange("Line No.", Rec."Special Order Purch. Line No.");
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
    var
        ApplicationAreaMgmtFacade2: Codeunit "Application Area Mgmt. Facade";
    begin
        SalesSetup.GET();
        InventorySetup.GET();
        Currency.InitRoundingPrecision();
        TempOptionLookupBuffer.FillLookupBuffer(Enum::"Option Lookup Type"::Sales);
        IsFoundation := ApplicationAreaMgmtFacade2.IsFoundationEnabled();
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
        Clear(ShortcutDimCode);
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
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
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
        SalesHeader2: Record "Sales Header";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        SalesHeader2.Get(Rec."Document Type", Rec."Document No.");
        if SalesHeader2.InvoicedLineExists() then
            if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true) then
                exit;

        SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, SalesHeader2);
        DocumentTotals.SalesDocTotalsNotUpToDate();
        CurrPage.Update(false);
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
        PurchHeader.SetRange("No.", Rec."Purchase Order No.");
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
        PurchHeader.SetRange("No.", Rec."Special Order Purchase No.");
        if not PurchHeader.ISEMPTY then begin
            PurchOrder.SETTABLEVIEW(PurchHeader);
            PurchOrder.EDITABLE := false;
            PurchOrder.RUN();
        end else begin
            PurchRcptHeader.SetRange("Order No.", Rec."Special Order Purchase No.");
            if PurchRcptHeader.COUNT = 1 then
                PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
            else
                PAGE.RUN(PAGE::"Posted Purchase Receipts", PurchRcptHeader);
        end;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        OnBeforeInsertExtendedText(Rec);
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
        TrackingForm.RunModal();
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure OrderPromisingLine()
    var
        TempOrderPromisingLine: Record "Order Promising Line" temporary;
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
        OrderPromisingLine.SETRANGE("Source ID", Rec."Document No.");
        OrderPromisingLine.SETRANGE("Source Line No.", Rec."Line No.");

        OrderPromisingLines.SetSource(OrderPromisingLine."Source Type"::Sales);
        OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
        OrderPromisingLines.RUNMODAL();
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
                CurrPage.Update(false);
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
            CurrPage.Update(false);
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

        OnAfterQuantityOnAfterValidate(Rec, xRec);
    end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        if Rec.Reserve = Rec.Reserve::Always then
            Rec.AutoReserve();
        CurrPage.Update(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        DeltaUpdateTotals();
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.Update(false);
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
            CurrPage.Update(false);
        end else
            CurrPage.Update(true);
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        if (Rec.Type = Rec.Type::Item) and rec.IsAsmToOrderRequired() then begin
            CurrPage.SAVERECORD();
            Rec.AutoAsmToOrder();
            CurrPage.Update(false);
        end;
    end;

    procedure ShowDocumentLineTracking()
    var
        DocLineTracking: Page "Document Line Tracking";
    begin
        CLEAR(DocumentLineTracking);
        DocumentLineTracking.SetDoc(0, Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        DocumentLineTracking.RUNMODAL();
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

        Clear(DimMgt);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnReferenceNoOnAfterLookup(var SalesLine: Record "Sales Line")
    begin
    end;
}

