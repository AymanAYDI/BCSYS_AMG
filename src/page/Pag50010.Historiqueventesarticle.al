namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
page 50010 "Historique ventes article"
{
    DeleteAllowed = false;
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Historique ventes";
    SourceTableView = sorting("Date document vente", Référence, "N° client")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N° client"; Rec."N° client")
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
                field("N° devis"; Rec."N° devis")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Quote";
                    TableRelation = "Sales Header";

                    trigger OnDrillDown()
                    var
                        LRecDevis: Record 36;
                        LRecDevisArchive: Record 5107;
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."N° devis") then
                                PAGE.RUNMODAL(41, LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."N° devis") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."N° devis");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5162, LRecDevisArchive)
                        end
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecDevis: Record 36;
                        LRecDevisArchive: Record 5107;
                    begin
                        //JOS 16/05/2023
                        if Rec.Archive <> true then begin
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."N° devis") then
                                PAGE.RUNMODAL(41, LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."N° devis") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."N° devis");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5162, LRecDevisArchive)
                        end
                    end;
                }
                field("N° commande vente"; Rec."N° commande vente")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Order";

                    trigger OnDrillDown()
                    var
                        LRecCmdeVente: Record 36;
                        LRecCmdeVenteArchive: Record 5107;
                    begin
                        //JOS 13/07/2023
                        if Rec.Archive <> true then begin
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."N° commande vente") then
                                PAGE.RUNMODAL(42, LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."N° commande vente") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."N° commande vente");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5159, LRecCmdeVenteArchive)
                        end
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeVente: Record 36;
                        LRecCmdeVenteArchive: Record 5107;
                    begin
                        //JOS 16/05/2023
                        if Rec.Archive <> true then begin
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."N° commande vente") then
                                PAGE.RUNMODAL(42, LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."N° commande vente") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."N° commande vente");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5159, LRecCmdeVenteArchive)
                        end
                    end;
                }
                field(Référence; Rec.Référence)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Référence externe"; Rec."Référence externe")
                {
                    Editable = false;
                }
                field(Quantité; Rec.Quantité)
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
                field("N° commande achat"; Rec."N° commande achat")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Purchase Order";

                    trigger OnDrillDown()
                    var
                        LRecCmdeAchat: Record 38;
                    begin
                        //JOS 13.07.2023
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."N° commande achat") then
                            PAGE.RUNMODAL(50, LRecCmdeAchat);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeAchat: Record 38;
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."N° commande achat") then
                            PAGE.RUNMODAL(50, LRecCmdeAchat);
                        //END DELPHI AUB
                    end;
                }
                field("N° facture vente"; Rec."N° facture vente")
                {
                    TableRelation = "Sales Invoice Header"."No.";

                    trigger OnDrillDown()
                    var
                        LRecFactureVente: Record 112;
                    begin
                        //JOS 13.07.2023
                        if LRecFactureVente.GET(Rec."N° facture vente") then
                            PAGE.RUNMODAL(132, LRecFactureVente);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecFactureVente: Record 112;
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecFactureVente.GET(Rec."N° facture vente") then
                            PAGE.RUNMODAL(132, LRecFactureVente);
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
                //todo report spe
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Report 50020;
                RunPageOnRec = false;
            }
        }
    }

    var
        GRecSalesLineArchive: Record 5107;
}

