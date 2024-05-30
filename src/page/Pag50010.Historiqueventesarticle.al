namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Archive;
using Microsoft.Sales.History;
page 50010 "Historique ventes article"
{
    DeleteAllowed = false;
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Historique ventes";
    SourceTableView = sorting("Date document vente", Reference, "No. client")
                      order(descending);
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N° client"; Rec."No. client")
                {
                    Editable = false;
                }
                field("Nom client"; Rec."Nom client")
                {
                    Editable = false;
                }
                field("Date document vente"; Rec."Date document vente")
                {
                    Editable = false;
                }
                field("N° devis"; Rec."No. devis")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Quote";
                    TableRelation = "Sales Header";

                    trigger OnDrillDown()
                    var
                        LRecDevis: Record "Sales Header";
                        LRecDevisArchive: Record "Sales Header Archive";
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."No. devis") then
                                PAGE.RUNMODAL(Page::"Sales Quote", LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."No. devis") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."No. devis");
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
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."No. devis") then
                                PAGE.RUNMODAL(Page::"Sales Quote", LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."No. devis") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."No. devis");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Quote Archive", LRecDevisArchive)
                        end
                    end;
                }
                field("N° commande vente"; Rec."No. commande vente")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Order";

                    trigger OnDrillDown()
                    var
                        LRecCmdeVente: Record "Sales Header";
                        LRecCmdeVenteArchive: Record "Sales Header Archive";
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."No. commande vente") then
                                PAGE.RUNMODAL(Page::"Sales Order", LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."No. commande vente") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."No. commande vente");
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
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."No. commande vente") then
                                PAGE.RUNMODAL(Page::"Sales Order", LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."No. commande vente") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."No. commande vente");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(Page::"Sales Order Archive", LRecCmdeVenteArchive)
                        end
                    end;
                }
                field(Référence; Rec.Reference)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Référence externe"; Rec."Reference externe")
                {
                    Editable = false;
                }
                field(Quantité; Rec.Quantite)
                {
                    Editable = false;
                }
                field("Prix de vente"; Rec."Prix de vente")
                {
                    Editable = false;
                }
                field("% de remise"; Rec."% de remise")
                {
                    Editable = false;
                }
                field("N° commande achat"; Rec."No. commande achat")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Purchase Order";

                    trigger OnDrillDown()
                    var
                        LRecCmdeAchat: Record "Purchase Header";
                    begin
                        //JOS 13.07.2023
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."No. commande achat") then
                            PAGE.RUNMODAL(Page::"Purchase Order", LRecCmdeAchat);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeAchat: Record "Purchase Header";
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."No. commande achat") then
                            PAGE.RUNMODAL(Page::"Purchase Order", LRecCmdeAchat);
                        //END DELPHI AUB
                    end;
                }
                field("N° facture vente"; Rec."No. facture vente")
                {
                    TableRelation = "Sales Invoice Header"."No.";

                    trigger OnDrillDown()
                    var
                        LRecFactureVente: Record "Sales Invoice Header";
                    begin
                        //JOS 13.07.2023
                        if LRecFactureVente.GET(Rec."No. facture vente") then
                            PAGE.RUNMODAL(Page::"Posted Sales Invoice", LRecFactureVente);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecFactureVente: Record "Sales Invoice Header";
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecFactureVente.GET(Rec."No. facture vente") then
                            PAGE.RUNMODAL(Page::"Posted Sales Invoice", LRecFactureVente);
                        //END DELPHI AUB
                    end;
                }
                field(Inventory; Rec.Inventory)
                {
                }
                field(Archive; Rec.Archive)
                {
                    Editable = false;
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
            }
        }
    }
}

