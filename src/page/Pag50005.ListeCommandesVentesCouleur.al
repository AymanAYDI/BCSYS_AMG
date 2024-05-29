namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.EServices.EDocument;
using Microsoft.Sales.Comment;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Reporting;
using System.Security.User;
using Microsoft.CashFlow.Forecast;
using Microsoft.Utilities;
using System.Automation;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Reports;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.InventoryDocument;
using Microsoft.Intercompany;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Inventory.Availability;
using Microsoft.Integration.D365Sales;
using Microsoft.Warehouse.Activity;
using Microsoft.Sales.History;
using Microsoft.CRM.Outlook;
using Microsoft.Integration.Dataverse;
using Microsoft.Sales.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Archive;
using Microsoft.Warehouse.Request;
page 50005 "Liste Commandes Ventes Couleur"
{
    Caption = 'Sales Orders', Comment = 'FRA="Commandes GALLOIS"';
    CardPageID = "Sales Order";
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order', Comment = 'FRA="Nouveau,Traiter,Déclarer,Demander une approbation,Commander"';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = sorting("No.", "Document Type")
                      order(descending)
                      where("Document Type" = const(Order));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    StyleExpr = GTxtStyleText;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    StyleExpr = GTxtStyleText;
                    Visible = false;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Visible = JobQueueActive;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = GTxtStyleText;
                }
            }
        }
        area(factboxes)
        {
            part("Sales Lines Couleur"; "Sales Lines Couleur")
            {
                SubPageLink = "Document No." = field("No.");
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder', Comment = 'FRA="Commande"';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.OpenSalesOrderStatistics();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals', Comment = 'FRA="Approbations"';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsSales(Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Commentaires"';
                    Image = ViewComments;
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents', Comment = 'FRA="Documents"';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments', Comment = 'FRA="Expéditions"';
                    Image = Shipment;
                    RunObject = page "Posted Sales Shipments";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices', Comment = 'FRA="Factures"';
                    Image = Invoice;
                    RunObject = page "Posted Sales Invoices";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(PostedSalesPrepmtInvoices)
                {
                    Caption = 'Prepa&yment Invoices', Comment = 'FRA="Factures acompte"';
                    Image = PrepaymentInvoice;
                    RunObject = page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos', Comment = 'FRA="Avoirs acompte"';
                    Image = PrepaymentCreditMemo;
                    RunObject = page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                }
            }
            group(Warehouse_1)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines', Comment = 'FRA="Lignes expédition entrepôt"';
                    Image = ShipmentLines;
                    RunObject = page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = const(37),
                                  "Source Subtype" = field("Document Type"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélèv./rangement stock"';
                    Image = PickLines;
                    RunObject = page "Warehouse Activity List";
                    RunPageLink = "Source Document" = const("Sales Order"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM', Comment = 'FRA="Dynamics CRM"';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrderListInNAV)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order List', Comment = 'FRA="Liste des commandes vente"';
                    Enabled = CRMIntegrationEnabled;
                    Image = "Order";
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction()
                    var
                        CRMSalesorder: Record "CRM Salesorder";
                    begin
                        page.RUN(page::"CRM Sales Order List", CRMSalesorder);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release', Comment = 'FRA="Lancer"';
                Image = ReleaseDoc;
                action(Release_A)
                {
                    Caption = 'Re&lease', Comment = 'FRA="Lancer"';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        LRecHisto: Record "Historique ventes";
                        ReleaseSalesDoc: codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        //DELPHI AUB 29.06.2020
                        // ajout des lignes de vente à l'historique
                        LRecHisto.DELAddCmdVente(Rec."No.", Rec."Document Date");
                        //END DELPHI AUB 29.06.2020
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open', Comment = 'FRA="Rouvrir"';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        LRecHisto: Record "Historique ventes";
                        ReleaseSalesDoc: codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        //DELPHI AUB 29.06.2020
                        // suppression des lignes de vente dans l'historique
                        LRecHisto.DELDeleteCmdVente(Rec."No.");
                        //END DELPHI AUB 29.06.2020
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonctions"';
                Image = "Action";
                action("Pla&nning")
                {
                    Caption = 'Pla&nning', Comment = 'FRA="Planning"';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesOrderPlanningForm: page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RUNMODAL();
                    end;
                }
                action("Order &Promising")
                {
                    AccessByPermission = TableData "Order Promising Line" = R;
                    Caption = 'Order &Promising', Comment = 'FRA="Promesse de livraison"';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        page.RUNMODAL(page::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Sales Order Cnfmn.', Comment = 'FRA="Confirmation envoi commande vente IC"';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: codeunit ICInboxOutboxMgt;
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval', Comment = 'FRA="Approbation demande achat"';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''approbation"';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler demande d''approbation"';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stock"';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    Caption = 'Create &Whse. Shipment', Comment = 'FRA="Créer expédition entrepôt"';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', Comment = 'FRA="Validation"';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost', Comment = 'FRA="Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(codeunit::"Sales-Post (Yes/No)");
                    end;
                }
                action(PostAndSend)
                {
                    Caption = 'Post and Send', Comment = 'FRA="Valider et envoyer"';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Post(codeunit::"Sales-Post and Send");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par lot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        report.RUNMODAL(report::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue', Comment = 'FRA="Supprimer de la file d''attente des travaux"';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action("Preview Posting")
                {
                    Caption = 'Preview Posting', Comment = 'FRA="Aperçu compta."';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    begin
                        ShowPreview()
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print', Comment = 'FRA="Imprimer"';
                Image = Print;
                action("Work Order")
                {
                    Caption = 'Work Order', Comment = 'FRA="Ordre de fabrication"';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    Caption = 'Pick Instruction', Comment = 'FRA="Instruction prélèvement"';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation', Comment = 'FRA="Confirmation de commande"';
                Image = Email;
                action("Email Confirmation")
                {
                    Caption = 'Email Confirmation', Comment = 'FRA="Envoyer confirmation par e-mail"';
                    Ellipsis = true;
                    Image = Email;

                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action("Print Confirmation")
                {
                    Caption = 'Print Confirmation', Comment = 'FRA="Imprimer confirmation"';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.', Comment = 'FRA="Dispo. réservation vente"';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = report "Sales Reservation Avail.";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility();
        CurrPage.IncomingDocAttachFactBox.page.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord()
    var
        LRecPurchInvHeader: Record "Purch. Inv. Header";
        LRecPurchInvLine: Record "Purch. Inv. Line";
        LRecPurchHeaderArchive: Record "Purchase Header Archive";
        LRecPurchaseLine: Record "Purchase Line";
        LRecPurchLineArchive: Record "Purchase Line Archive";
        LRecSalesLine: Record "Sales Line";
        LIntCountAllReceipt: Integer;
        LIntCountReceipt: Integer;
    begin
        //DELPHI AUB 14.06.2019 edited by AUB 24.09.2019
        LRecSalesLine.RESET();
        LRecSalesLine.SETRANGE("Document No.", Rec."No.");
        //LRecSalesLine.SETRANGE("Special Order",TRUE);
        LIntCountReceipt := 0; // no item received
        LIntCountAllReceipt := 0;
        GIntLinestoShip := 0;
        GTxtStyleText := 'Standard';
        if LRecSalesLine.FindSet() then
            repeat
                GIntLinestoShip += LRecSalesLine."Qty. to Ship";
                if LRecSalesLine."Special Order" then begin
                    LRecPurchaseLine.RESET();
                    if (LRecSalesLine."Special Order Purchase No." <> '') and (LRecSalesLine."Special Order Purch. Line No." <> 0) then begin
                        LRecPurchaseLine.SETRANGE("Document No.", LRecSalesLine."Special Order Purchase No.");
                        LRecPurchaseLine.SETRANGE("Line No.", LRecSalesLine."Special Order Purch. Line No.");
                        if LRecPurchaseLine.FINDFIRST() then begin
                            if LRecPurchaseLine."Quantity Received" > 0 then
                                LIntCountReceipt += 1;
                            if LRecPurchaseLine."Quantity Received" >= LRecSalesLine.Quantity then
                                LIntCountAllReceipt += 1;
                        end else begin
                            // If no result, search in Purch. Invoice Lines
                            LRecPurchInvHeader.SETRANGE("Order No.", LRecSalesLine."Special Order Purchase No.");
                            if LRecPurchInvHeader.FIND('-') then
                                repeat
                                    LRecPurchInvLine.SETRANGE("Document No.", LRecPurchInvHeader."No.");
                                    LRecPurchInvLine.SETRANGE(Type, LRecSalesLine.Type::Item);
                                    LRecPurchInvLine.SETRANGE("No.", LRecSalesLine."No.");
                                    LRecPurchInvLine.SETFILTER(Quantity, '<>0');
                                    if LRecPurchInvLine.FIND('-') then
                                        repeat
                                            if LRecPurchInvLine.Quantity > 0 then
                                                LIntCountReceipt += 1;
                                            if LRecPurchInvLine.Quantity >= LRecSalesLine.Quantity then
                                                LIntCountAllReceipt += 1;
                                        until LRecPurchInvLine.NEXT() = 0;
                                until LRecPurchInvHeader.NEXT() = 0
                            else begin
                                //DELPHI AUB search in Purchase Order Archives 03.09.2020
                                LRecPurchHeaderArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                                LRecPurchHeaderArchive.SETRANGE("No.", LRecSalesLine."Special Order Purchase No.");
                                if LRecPurchHeaderArchive.FINDLAST() then begin
                                    LRecPurchLineArchive.SETRANGE("Document Type", LRecPurchHeaderArchive."Document Type"::Order);
                                    LRecPurchLineArchive.SETRANGE("Document No.", LRecPurchHeaderArchive."No.");
                                    LRecPurchLineArchive.SETRANGE("Doc. No. Occurrence", LRecPurchHeaderArchive."Doc. No. Occurrence");
                                    LRecPurchLineArchive.SETRANGE("Version No.", LRecPurchHeaderArchive."Version No.");
                                    LRecPurchLineArchive.SETRANGE("Line No.", LRecSalesLine."Special Order Purch. Line No.");
                                    if LRecPurchLineArchive.FINDFIRST() then begin
                                        if LRecPurchLineArchive."Quantity Received" > 0 then
                                            LIntCountReceipt += 1;
                                        if LRecPurchLineArchive."Quantity Received" >= LRecSalesLine.Quantity then
                                            LIntCountAllReceipt += 1;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            until LRecSalesLine.NEXT() = 0;

        if (LIntCountAllReceipt <> 0) and (LIntCountAllReceipt = LRecSalesLine.COUNT) then
            GTxtStyleText := 'Favorable'
        else
            if (LIntCountAllReceipt > 0) or (LIntCountReceipt > 0) then
                GTxtStyleText := 'Ambiguous';
        //DELPHI AUB 16.07.2019 si tout est expédié -> green color
        if GIntLinestoShip = 0 then // items all sent
            GTxtStyleText := 'Favorable'
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(Rec.FIND(Which) and ShowHeader());
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        NewStepCount: Integer;
    begin
        repeat
            NewStepCount := Rec.NEXT(Steps);
        until (NewStepCount = 0) or ShowHeader();

        exit(NewStepCount);
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: codeunit "CRM Integration Management";
        OfficeMgt: codeunit "Office Management";
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        end;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);

        JobQueueActive := SalesSetup.JobQueueActive();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        Rec.CopySellToCustomerFilter();
        Rec.FINDFIRST();
    end;

    var
        DocPrint: codeunit "Document-Print";
        ReportPrint: codeunit "Test Report-Print";
        UserMgt: codeunit "User Setup Management";
        CanCancelApprovalForRecord: Boolean;
        CRMIntegrationEnabled: Boolean;
        IsOfficeAddin: Boolean;
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        SkipLinesWithoutVAT: Boolean;
        GIntLinestoShip: Decimal;
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        GTxtStyleText: Text[80];

    procedure ShowPreview()
    var
        SalesPostYesNo: codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure Post(PostingCodeunitID: Integer)
    var
        LinesInstructionMgt: codeunit "Lines Instruction Mgt.";
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        CurrPage.UPDATE(false);
    end;

    procedure SkipShowingLinesWithoutVAT()
    begin
        SkipLinesWithoutVAT := true;
    end;

    local procedure ShowHeader(): Boolean
    var
        CashFlowManagement: codeunit "Cash Flow Management";
    begin
        if not SkipLinesWithoutVAT then
            exit(true);

        exit(CashFlowManagement.GetTaxAmountFromSalesOrder(Rec) <> 0);
    end;
}

