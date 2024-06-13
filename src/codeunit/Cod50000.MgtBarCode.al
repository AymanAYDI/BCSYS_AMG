namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Inventory.Item;
using System.Text;

codeunit 50000 MgtBarCode //TODO: A revoir
{
    //     // Manager BARCODE
    //TODO : A migrer les reports 1322, 10804, 10806, 10808

    //     trigger OnRun()
    //     begin
    //     end;

    //     var
    //         TxTBarCode: Text;
    //         BarCodeFormat: DotNet BarcodeFormat;
    //         BarCodeWriter: DotNet BarcodeWriter;
    //         EncodingOption: DotNet EncodingOptions;
    //         BitMatrix: DotNet BitMatrix;
    //         ImageFormat: DotNet ImageFormat;
    //         AztecBitmap: DotNet Bitmap;
    //         Item: Record Item;
    //         FileManagement: Codeunit "File Management";
    //         TempBlob: Record TempBlob;
    //         TxtLocationSave: Text;

    //     procedure AddCodeBarAztec(PArticle: Record Item)
    //     begin
    //         EncodingOption := EncodingOption.EncodingOptions();
    //         EncodingOption.Height := 75;
    //         EncodingOption.Width := 75;

    //         BarCodeWriter := BarCodeWriter.BarcodeWriter();
    //         BarCodeWriter.Format := BarCodeFormat.AZTEC;
    //         BarCodeWriter.Options := EncodingOption;
    //         TxTBarCode := PArticle."No.";
    //         BitMatrix := BarCodeWriter.Encode(TxTBarCode);
    //         AztecBitmap := BarCodeWriter.Write(BitMatrix);

    //         TxtLocationSave := 'C:\Partage\AMG\Temp\' + TxTBarCode + '.bmp';

    //         if not ISSERVICETIER then
    //             if EXISTS(TxtLocationSave) then
    //                 ERASE(TxtLocationSave);

    //         AztecBitmap.Save(TxtLocationSave, ImageFormat.Bmp);

    //         // ajout a la table article
    //         //FileManagement.BLOBImport(TempBlob,TxtLocationSave);
    //         FileManagement.BLOBImportFromServerFile(TempBlob, TxtLocationSave);
    //         PArticle.CodeAZTEC := TempBlob.Blob;
    //         PArticle.CodeBar := true;
    //         PArticle.Modify();
    //         COMMIT();
    //         SLEEP(500);


    //         if EXISTS(TxtLocationSave) then
    //             ERASE(TxtLocationSave);
    //     end;
    // 
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

