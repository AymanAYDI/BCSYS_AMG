namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using Microsoft.Finance.VAT.Setup;
tableextension 50005 Item extends Item //27
{
    fields
    {
        modify("Price/Profit Calculation")
        {
            trigger OnAfterValidate()
            begin
                case "Price/Profit Calculation" of
                    "Price/Profit Calculation"::"Price=Last Direct Cost+Profit":
                        if "Profit %" < 100 then
                            "Unit Price" :=
                              ROUND(
                                ("Last Direct Cost" / (1 - "Profit %" / 100)) *
                                (1 + CalcVAT()),
                                0.01);
                end;
            end;
        }
        modify("Last Direct Cost")
        {
            trigger OnAfterValidate()
            begin
                Validate("Price/Profit Calculation");
                Rec."Last Date Modified Price" := TODAY;
            end;
        }
        field(50000; Brand; Text[40])
        {
            Caption = 'Brand';
        }
        field(50010; Grade; Text[40])
        {
            Caption = 'Grade';
        }
        field(50020; Color; Text[40])
        {
            Caption = 'Color';
        }
        field(50030; Process1; Text[100])
        {
            Caption = 'Process1';
        }
        field(50040; Process2; Text[100])
        {
            Caption = 'Process2';
        }
        field(50050; Origin; Text[50])
        {
            Caption = 'Origin';
        }
        field(50060; Material; Text[30])
        {
            Caption = 'Material', Comment = 'FRA="Matérial"';
        }
        field(50100; History; Boolean)
        {
            CalcFormula = exist("Historique ventes" where(Reference = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Historique ventes";
            Caption = 'History';
        }
        field(50110; "Type carbo"; Boolean)
        {
            Caption = 'Type carbo';
        }
        field(50115; "Code ONU"; Code[10])
        {
            TableRelation = "ONU table";
            ValidateTableRelation = true;
            Caption = 'Code ONU';
        }
        field(50116; "UN version"; Integer)
        {
            TableRelation = "ONU table".Version where(Code = field("Code ONU"));
            Caption = 'UN version';
        }
        field(50120; CodeAZTEC; BLOB)
        {
            Caption = 'CodeAZTEC';
        }
        field(50121; CodeBar; Boolean)
        {
            Caption = 'CodeBar';
        }
        field(50122; "Last Date Modified Price"; Date)
        {
            Caption = 'Last Date Modified Price', Comment = 'FRA="Dernière date de modification du prix"';
        }

    }
    fieldgroups
    {
        addlast(DropDown; "Vendor No.", "Shelf No.", "Description 2", "Unit Cost", "Purch. Unit of Measure")
        {
        }
    }
    local procedure CalcVAT(): Decimal
    var
        VATPostingSetup: Record "VAT Posting Setup";
        Text006: Label 'Prices including VAT cannot be calculated when %1 is %2.', Comment = 'FRA="Les prix TTC ne peuvent pas être calculés quand %1 est identique à %2."';
    begin
        if "Price Includes VAT" then begin
            VATPostingSetup.Get("VAT Bus. Posting Gr. (Price)", "VAT Prod. Posting Group");
            case VATPostingSetup."VAT Calculation Type" of
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    VATPostingSetup."VAT %" := 0;
                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    Error(
                      Text006,
                      VATPostingSetup.FieldCaption("VAT Calculation Type"),
                      VATPostingSetup."VAT Calculation Type");
            end;
        end else
            Clear(VATPostingSetup);

        exit(VATPostingSetup."VAT %" / 100);
    end;

}

