namespace BCSYS_AMG.BCSYS_AMG;

using Microsoft.Inventory.Item;
using System.Text;

codeunit 50003 MgtBarCode2
{
    procedure AddCodeBarAztec(Item: Record Item)
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFrontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
    begin
        BarcodeFrontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeString := Item."No.";
        BarcodeFrontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
        EncodedText := BarcodeFrontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
    end;

    var
        EncodedText: Text;
}
