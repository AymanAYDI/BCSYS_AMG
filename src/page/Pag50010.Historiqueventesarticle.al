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
    SourceTable = "Sales Archive";
    SourceTableView = sorting("Quote No.", Reference, "Customer No.")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Sales Document Date"; Rec."Sales Document Date")
                {
                    Editable = false;
                }
                field("Quote No."; Rec."Quote No.")
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
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."Quote No.") then
                                PAGE.RUNMODAL(41, LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."Quote No.") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."Quote No.");
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
                            if LRecDevis.GET(LRecDevis."Document Type"::Quote, Rec."Quote No.") then
                                PAGE.RUNMODAL(41, LRecDevis)
                        end
                        else begin
                            if LRecDevisArchive.GET(LRecDevisArchive."Document Type"::Quote, Rec."Quote No.") then
                                LRecDevisArchive.SETASCENDING("Version No.", false);
                            LRecDevisArchive.SETRANGE(LRecDevisArchive."No.", Rec."Quote No.");
                            if LRecDevisArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5162, LRecDevisArchive)
                        end
                    end;
                }
                field("Sales Order No."; Rec."Sales Order No.")
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
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."Sales Order No.") then
                                PAGE.RUNMODAL(42, LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."Sales Order No.") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."Sales Order No.");
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
                            if LRecCmdeVente.GET(LRecCmdeVente."Document Type"::Order, Rec."Sales Order No.") then
                                PAGE.RUNMODAL(42, LRecCmdeVente)
                        end
                        else begin
                            if LRecCmdeVenteArchive.GET(LRecCmdeVenteArchive."Document Type"::Order, Rec."Sales Order No.") then
                                LRecCmdeVenteArchive.SETASCENDING("Version No.", false);
                            LRecCmdeVenteArchive.SETRANGE(LRecCmdeVenteArchive."No.", Rec."Sales Order No.");
                            if LRecCmdeVenteArchive.FINDFIRST() then
                                PAGE.RUNMODAL(5159, LRecCmdeVenteArchive)
                        end
                    end;
                }
                field(Reference; Rec.Reference)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("External Reference"; Rec."External Reference")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Sales Amount"; Rec."Sales Amount")
                {
                    Editable = false;
                }
                field("% Discount"; Rec."% Discount")
                {
                    Editable = false;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Purchase Order";

                    trigger OnDrillDown()
                    var
                        LRecCmdeAchat: Record 38;
                    begin
                        //JOS 13.07.2023
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."Purchase Order No.") then
                            PAGE.RUNMODAL(50, LRecCmdeAchat);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecCmdeAchat: Record 38;
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecCmdeAchat.GET(LRecCmdeAchat."Document Type"::Order, Rec."Purchase Order No.") then
                            PAGE.RUNMODAL(50, LRecCmdeAchat);
                        //END DELPHI AUB
                    end;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    TableRelation = "Sales Invoice Header"."No.";

                    trigger OnDrillDown()
                    var
                        LRecFactureVente: Record 112;
                    begin
                        //JOS 13.07.2023
                        if LRecFactureVente.GET(Rec."Sales Invoice No.") then
                            PAGE.RUNMODAL(132, LRecFactureVente);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LRecFactureVente: Record 112;
                    begin
                        //DELPHI AUB 01.07.2020
                        if LRecFactureVente.GET(Rec."Sales Invoice No.") then
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

