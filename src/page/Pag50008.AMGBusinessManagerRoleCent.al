namespace BCSYS.AMGALLOIS.Basic;

using System.Visualization;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.FinancialReports;
using Microsoft.RoleCenters;
using Microsoft.EServices.EDocument;
using System.Environment.Configuration;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.Setup;
using Microsoft.Bank.Payment;
using Microsoft.Purchases.Payables;
using Microsoft.Foundation.Company;
using System.Apps;
using Microsoft.Utilities;
using Microsoft.Integration.Entity;
using Microsoft.Inventory.Item;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Budget;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Sales.Analysis;
using Microsoft.Purchases.Analysis;
using Microsoft.Inventory.Analysis;
using Microsoft.Finance.VAT.Reporting;
using Microsoft.Finance.Currency;
using Microsoft.HumanResources.Employee;
using Microsoft.Finance.Dimension;
using Microsoft.CashFlow.Forecast;
using Microsoft.CashFlow.Account;
using Microsoft.CashFlow.Setup;
using Microsoft.Bank.Statement;
using Microsoft.Bank.DirectDebit;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.FinanceCharge;
using Microsoft.Sales.History;
using Microsoft.Purchases.History;
page 50008 "AMG Business Manager Role Cent"
{
    Caption = 'Business Manager', Comment = 'FRA="Gestionnaire d''activité"';
    PageType = RoleCenter;
    UsageCategory = None;
    ApplicationArea = All;
    layout
    {
        area(rolecenter)
        {
            part("Headline RC Business Manager"; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part("O365 Activities"; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts', Comment = 'FRA="Comptes favoris"';
            }
            part("Trial Balance"; "Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }
            part("Team Member Activities No Msgs"; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Sales Quote")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote', Comment = 'FRA="Devis"';
                Image = NewSalesQuote;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
            }
            action("Sales Order")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order', Comment = 'FRA="Commande vente"';
                Image = NewOrder;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
            }
            action("Sales Invoice")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice', Comment = 'FRA="Facture vente"';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
            }
            action("Purchase Quote")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Quote', Comment = 'FRA="Devis d''achat"';
                Image = NewSalesQuote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
            }
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order', Comment = 'FRA="Commande achat"';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
            }
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoice', Comment = 'FRA="Facture achat"';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
            }
            action("Feuille compta général")
            {
                RunObject = Page "General Journal";
                RunPageView = where("Journal Template Name" = filter('GENERAL'));
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New', Comment = 'FRA="Nouveau"';
                Image = New;
                action(Customer)
                {
                    AccessByPermission = TableData Customer = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer', Comment = 'FRA="Client"';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                }
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                }
            }
            group(Payments)
            {
                Caption = 'Payments', Comment = 'FRA="Paiements"';
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Imported Payments', Comment = 'FRA="Rapprocher les paiements importés"';
                    Image = ApplyEntries;
                    RunObject = Codeunit "Pmt. Rec. Journals Launcher";
                }
                action("Import Bank Transactions")
                {
                    AccessByPermission = TableData "Bank Export/Import Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Bank Transactions...', Comment = 'FRA="Importer les transactions bancaires..."';
                    Image = Import;
                    RunObject = Codeunit "Pmt. Rec. Jnl. Import Trans.";
                }
                action("Register Customer Payments")
                {
                    AccessByPermission = TableData "Payment Registration Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments', Comment = 'FRA="Enregistrer les paiements client"';
                    Image = Payment;
                    RunObject = Page "Payment Registration";
                }
                action("Create Vendor Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Vendor Payments', Comment = 'FRA="Créer des paiements fournisseur"';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = where("Document Type" = filter(Invoice),
                                        "Remaining Amount" = filter(< 0),
                                        "Applies-to ID" = filter(''));
                }
            }
            group(Reports)
            {
                Caption = 'Reports', Comment = 'FRA="États"';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements', Comment = 'FRA="Rapports financiers"';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet', Comment = 'FRA="Bilan"';
                        Image = "Report";
                        RunObject = Report "Balance Sheet";
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement', Comment = 'FRA="Comptes de gestion"';
                        Image = "Report";
                        RunObject = Report "Income Statement";
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows', Comment = 'FRA="Déclaration des trésoreries"';
                        Image = "Report";
                        RunObject = Report "Statement of Cashflows";
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings', Comment = 'FRA="Déclaration des réserves"';
                        Image = "Report";
                        RunObject = Report "Retained Earnings Statement";
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup', Comment = 'FRA="Paramètres"';
                Image = Setup;
                action("Company Settings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Settings', Comment = 'FRA="Paramètres de la société"';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup', Comment = 'FRA="Configuration assistée"';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                }
                group("Services & Extensions")
                {
                    Caption = 'Services & Extensions', Comment = 'FRA="Service et extensions"';
                    Image = ServiceSetup;
                    action(Extensions1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Extensions', Comment = 'FRA="Extensions"';
                        Image = NonStockItemSetup;
                        RunObject = Page "Extension Management";
                    }
                    action("Service Connections1")
                    {
                        ApplicationArea = Service;
                        Caption = 'Service Connections', Comment = 'FRA="Connexions au service"';
                        Image = ServiceTasks;
                        RunObject = Page "Service Connections";
                    }
                }
            }
        }
        area(reporting)
        {
            group("Excel Reports")
            {
                Caption = 'Excel Reports', Comment = 'FRA="États Excel"';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet', Comment = 'FRA="Bilan"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Balance Sheet";
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement', Comment = 'FRA="Comptes de gestion"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Income Stmt.";
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Statement', Comment = 'FRA="Déclaration de trésorerie"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retained Earnings Statement', Comment = 'FRA="Déclaration de réserves"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Retained Earn.";
                }
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance', Comment = 'FRA="Comptabilité fournisseur âgée"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Trial Balance";
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable', Comment = 'FRA="Comptabilité client âgée"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable', Comment = 'FRA="Clients"';
                    Image = "Report";
                    RunObject = Codeunit "Run Template Aged Acc. Rec.";
                }
            }
        }
        area(embedding)
        {
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers', Comment = 'FRA="Fournisseurs"';
                RunObject = Page "Customer List";
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors', Comment = 'FRA="Fournisseurs"';
                RunObject = Page "Vendor List";
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items', Comment = 'FRA="Articles"';
                RunObject = Page "Item List";
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts', Comment = 'FRA="Comptes bancaires"';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts', Comment = 'FRA="Plan comptable"';
                RunObject = Page "Chart of Accounts";
            }
        }
        area(sections)
        {
            group(Finance1)
            {
                Caption = 'Finance', Comment = 'FRA="Finance"';
                Image = Journals;
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals', Comment = 'FRA="Feuilles comptabilité"';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                }
                action("Chart of Accounts1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts', Comment = 'FRA="Plan comptable"';
                    RunObject = Page "Chart of Accounts";
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories', Comment = 'FRA="Catégories de compte général"';
                    RunObject = Page "G/L Account Categories";
                }
                action("G/L Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets', Comment = 'FRA="Budgets"';
                    RunObject = Page "G/L Budget Names";
                }
                action("Fixed Assets1")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets', Comment = 'FRA="Immobilisations"';
                    RunObject = Page "Fixed Asset List";
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules', Comment = 'FRA="Tableaux d''analyse"';
                    RunObject = Page "Account Schedule Names";
                }
                action("Sales Budgets")
                {
                    ApplicationArea = SalesBudget;
                    Caption = 'Sales Budgets', Comment = 'FRA="Budgets vente"';
                    RunObject = Page "Budget Names Sales";
                }
                action("Purchase Budgets")
                {
                    ApplicationArea = PurchaseBudget;
                    Caption = 'Purchase Budgets', Comment = 'FRA="Achats - Budgets"';
                    RunObject = Page "Budget Names Purchase";
                }
                action("Sales Analysis Reports")
                {
                    ApplicationArea = SalesAnalysis;
                    Caption = 'Sales Analysis Reports', Comment = 'FRA="Rapports d''analyse vente"';
                    RunObject = Page "Analysis Report Sale";
                }
                action("Purchase Analysis Reports")
                {
                    ApplicationArea = PurchaseAnalysis;
                    Caption = 'Purchase Analysis Reports', Comment = 'FRA="Rapports d''analyse achat"';
                    RunObject = Page "Analysis Report Purchase";
                }
                action("Inventory Analysis Reports")
                {
                    ApplicationArea = InventoryAnalysis;
                    Caption = 'Inventory Analysis Reports', Comment = 'FRA="Rapports d''analyse stock"';
                    RunObject = Page "Analysis Report Inventory";
                }
                action("VAT Reports")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT Reports', Comment = 'FRA="États TVA"';
                    RunObject = Page "VAT Report List";
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies', Comment = 'FRA="Devises"';
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action(Employees)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees', Comment = 'FRA="Salariés"';
                    RunObject = Page "Employee List";
                }
                action("VAT Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT Statements', Comment = 'FRA="Déclarations de TVA"';
                    RunObject = Page "VAT Statement Names";
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    RunObject = Page Dimensions;
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management', Comment = 'FRA="Banques"';
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts', Comment = 'FRA="Prévisions de la trésorerie"';
                    RunObject = Page "Cash Flow Forecast List";
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts', Comment = 'FRA="Plan comptable de trésorerie"';
                    RunObject = Page "Chart of Cash Flow Accounts";
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Revenues', Comment = 'FRA="Opérations diverses positives de trésorerie"';
                    RunObject = Page "Cash Flow Manual Revenues";
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Expenses', Comment = 'FRA="Opérations diverses négatives de trésorerie"';
                    RunObject = Page "Cash Flow Manual Expenses";
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles règlement"';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"),
                                        Recurring = const(false));
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals', Comment = 'FRA="Feuilles paiement"';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments),
                                        Recurring = const(false));
                }
                action("Bank Accounts1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts', Comment = 'FRA="Comptes bancaires"';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements', Comment = 'FRA="Relevés bancaires"';
                    Image = BankAccountStatement;
                    RunObject = Page "Bank Account Statement List";
                }
                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Recon. Journals', Comment = 'FRA="Feuilles rapprochement bancaire"';
                    Image = ApplyEntries;
                    RunObject = Page "Pmt. Reconciliation Journals";
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Debit Collections', Comment = 'FRA="Recouvrements prélèvement"';
                    RunObject = Page "Direct Debit Collections";
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
                    Image = Payment;
                    RunObject = Page "Payment Terms";
                }
            }
            group(Sales_G)
            {
                Caption = 'Sales', Comment = 'FRA="Ventes"';
                Image = Sales;
                action(Sales_CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers', Comment = 'FRA="Clients"';
                    RunObject = Page "Customer List";
                }
                action(Items2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items', Comment = 'FRA="Articles"';
                    RunObject = Page "Item List";
                }
                action("Item Charges1")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges', Comment = 'FRA="Frais annexes"';
                    RunObject = Page "Item Charges";
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quotes', Comment = 'FRA="Devis"';
                    RunObject = Page "Sales Quotes";
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
                    RunObject = Page "Sales Order List";
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders', Comment = 'FRA="Commandes ouvertes vente"';
                    Image = Reminder;
                    RunObject = Page "Blanket Sales Orders";
                }
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices', Comment = 'FRA="Factures vente"';
                    RunObject = Page "Sales Invoice List";
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos', Comment = 'FRA="Avoirs vente"';
                    RunObject = Page "Sales Credit Memos";
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Sales Return Orders', Comment = 'FRA="Retours vente"';
                    RunObject = Page "Sales Return Order List";
                }
                action(Reminders)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminders', Comment = 'FRA="Relances"';
                    Image = Reminder;
                    RunObject = Page "Reminder List";
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Finance Charge Memos', Comment = 'FRA="Factures d''intérêts"';
                    Image = FinChargeMemo;
                    RunObject = Page "Finance Charge Memo List";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices', Comment = 'FRA="Factures vente enregistrées"';
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistrés"';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts', Comment = 'FRA="Réceptions retour vente enregistrées"';
                    RunObject = Page "Posted Return Receipts";
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Reminders', Comment = 'FRA="Relances émises"';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Finance Charge Memos', Comment = 'FRA="Factures d''intérêts émises"';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
            }
            group(Purchasing1)
            {
                Caption = 'Purchasing', Comment = 'FRA="Procédure d''achat"';
                Image = AdministrationSalesPurchases;
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors', Comment = 'FRA="Fournisseurs"';
                    RunObject = Page "Vendor List";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents', Comment = 'FRA="Documents entrants"';
                    Gesture = None;
                    RunObject = Page "Incoming Documents";
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges', Comment = 'FRA="Frais annexes"';
                    RunObject = Page "Item Charges";
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes', Comment = 'FRA="Demandes de prix"';
                    RunObject = Page "Purchase Quotes";
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders', Comment = 'FRA="Commandes achat"';
                    RunObject = Page "Purchase Order List";
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Purchase Orders', Comment = 'FRA="Commande achat ouverte"';
                    RunObject = Page "Blanket Purchase Orders";
                }
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices', Comment = 'FRA="Factures achat"';
                    RunObject = Page "Purchase Invoices";
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos', Comment = 'FRA="Avoirs achat"';
                    RunObject = Page "Purchase Credit Memos";
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Purchase Return Orders', Comment = 'FRA="Retours achat"';
                    RunObject = Page "Purchase Return Order List";
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos', Comment = 'FRA="Avoirs achat enregistrés"';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="Réceptions achat enregistrées"';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Purchase Return Shipments', Comment = 'FRA="Expéditions retour achat enregistrées"';
                    RunObject = Page "Posted Return Shipments";
                }
            }
        }
    }
}
