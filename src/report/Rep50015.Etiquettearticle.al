namespace BCSYS.AMGALLOIS.Basic;
using Microsoft.Inventory.Item;
using System.Text;
report 50015 "Etiquette article"
{
    UsageCategory = None;
    ApplicationArea = All;
    WordMergeDataItem = Item;
    DefaultRenderingLayout = Word;

    dataset
    {
        dataitem(Item; Item)
        {
            column(Item_CodeAztec; AZTECBarCode)
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(Item_No; Item."No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
            begin
                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;

                // Set data string source 
                if "No." <> '' then begin
                    BarcodeString := "No.";
                    // Encode the data string to the barcode font
                    AZTECBarCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                end
            end;
        }
    }
    rendering
    {
        layout(Word)
        {
            Type = Word;
            LayoutFile = './src/report/rdl/Etiquettearticle.docx';
        }
    }
    var
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        AZTECBarCode: Text;


    trigger OnInitReport()
    begin
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::Aztec;
    end;
}

