namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using BCSYS_AMG.BCSYS_AMG;
using Microsoft.Sales.Archive;
page 50010 "Historique ventes article"
{
    DeleteAllowed = false;
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Archive";
    SourceTableView = sorting("Quote No.", Reference, "Customer No.")
                      order(descending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = 'FRA="Customer No."';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = 'FRA="Customer Name"';
                }
                field("Sales Document Date"; Rec."Sales Document Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sales Document Date field.', Comment = 'FRA="Sales Document Date"';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Quote";
                    TableRelation = "Sales Header";
                    ToolTip = 'Specifies the value of the Quote No. field.', Comment = 'FRA="N° devis"';
                    trigger OnDrillDown()
                    var
                        LRecDevis: Record "Sales Header";
                        LRecDevisArchive: Record "Sales Header Archive";
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."Quote No.") then
                                PAGE.RUNMODAL(Page::"Sales Quote", LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."Quote No.") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."Quote No.");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Quote Archive", LRecDevisArchive)
                        end
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecDevis: Record "Sales Header";
                        LRecDevisArchive: Record "Sales Header Archive";
                    begin
                        //JOS 16/05/2023
                        if Rec.Archive <> true then begin
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."Quote No.") then
                                PAGE.RUNMODAL(Page::"Sales Quote", LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."Quote No.") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."Quote No.");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Quote Archive", LRecDevisArchive)
                        end
                    end;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Order";
                    ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = 'FRA="N° commande vente"';
                    trigger OnDrillDown()
                    var
                        LRecCmdeVente: Record "Sales Header";
                        LRecCmdeVenteArchive: Record "Sales Header Archive";
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."Sales Order No.") then
                                PAGE.RUNMODAL(Page::"Sales Order", LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."Sales Order No.") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."Sales Order No.");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Order Archive", LRecCmdeVenteArchive)
                        end
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeVente: Record "Sales Header";
                        LRecCmdeVenteArchive: Record "Sales Header Archive";
                    begin
                        //JOS 16/05/2023
                        if Rec.Archive <> true then begin
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."Sales Order No.") then
                                PAGE.RUNMODAL(Page::"Sales Order", LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."Sales Order No.") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."Sales Order No.");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Order Archive", LRecCmdeVenteArchive)
                        end
                    end;
                }
                field(Reference; Rec.Reference)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reference field.', Comment = 'FRA="Reference"';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'FRA="Description"';
                }
                field("External Reference"; Rec."External Reference")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the External Reference field.', Comment = 'FRA="Reference externe"';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = 'FRA="Quantity"';
                }
                field("Sales Amount"; Rec."Sales Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sales Amount field.', Comment = 'FRA="Prix de vente"';
                }
                field("% Discount"; Rec."% Discount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the % Discount field.', Comment = 'FRA="% de remise"';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Purchase Order";
                    ToolTip = 'Specifies the value of the Purchase Order No. field.', Comment = 'FRA="N° commande achat"';
                    trigger OnDrillDown()
                    var
                        LRecCmdeAchat: Record "Purchase Header";
                    begin
                        //JOS 13.07.2023
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."Purchase Order No.") then
                            PAGE.RUNMODAL(Page::"Purchase Order", LRecCmdeAchat);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeAchat: Record "Purchase Header";
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."Purchase Order No.") then
                            PAGE.RUNMODAL(Page::"Purchase Order", LRecCmdeAchat);
                        //END DELPHI AUB
                    end;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    TableRelation = "Sales Invoice Header"."No.";
                    ToolTip = 'Specifies the value of the Sales Invoice No. field.', Comment = 'FRA="N° facture vente"';
                    trigger OnDrillDown()
                    var
                        LRecFactureVente: Record "Sales Invoice Header";
                    begin
                        //JOS 13.07.2023
                        if LRecFactureVente.GET(Rec."Sales Invoice No.") then
                            PAGE.RUNMODAL(Page::"Posted Sales Invoice", LRecFactureVente);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecFactureVente: Record "Sales Invoice Header";
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecFactureVente.GET(Rec."Sales Invoice No.") then
                            PAGE.RUNMODAL(Page::"Posted Sales Invoice", LRecFactureVente);
                        //END DELPHI AUB
                    end;
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.', Comment = 'FRA="Stock"';
                }
                field(Archive; Rec.Archive)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Archive field.', Comment = 'FRA="Archive"';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Recharger Historique")
            {
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report CopyLinesHisto;
                RunPageOnRec = false;
                ToolTip = 'Executes the Recharger Historique action.';
            }
        }
    }

    var
        GRecSalesLineArchive: Record "Sales Header Archive";
}

