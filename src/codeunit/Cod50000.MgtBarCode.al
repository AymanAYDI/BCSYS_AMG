codeunit 50000 MgtBarCode
{
    // Manager BARCODE


    trigger OnRun()
    begin
    end;

    var
        TxTBarCode: Text;
        BarCodeFormat: DotNet BarcodeFormat;
        BarCodeWriter: DotNet BarcodeWriter;
        EncodingOption: DotNet EncodingOptions;
        BitMatrix: DotNet BitMatrix;
        ImageFormat: DotNet ImageFormat;
        AztecBitmap: DotNet Bitmap;
        Item: Record 27;
        FileManagement: Codeunit 419;
        TempBlob: Record 99008535;
        TxtLocationSave: Text;

    procedure AddCodeBarAztec(PArticle: Record 27)
    begin
        EncodingOption := EncodingOption.EncodingOptions();
        EncodingOption.Height := 75;
        EncodingOption.Width := 75;

        BarCodeWriter := BarCodeWriter.BarcodeWriter();
        BarCodeWriter.Format := BarCodeFormat.AZTEC;
        BarCodeWriter.Options := EncodingOption;
        TxTBarCode := PArticle."No.";
        BitMatrix := BarCodeWriter.Encode(TxTBarCode);
        AztecBitmap := BarCodeWriter.Write(BitMatrix);

        TxtLocationSave := 'C:\Partage\AMG\Temp\' + TxTBarCode + '.bmp';

        if not ISSERVICETIER then
            if EXISTS(TxtLocationSave) then
                ERASE(TxtLocationSave);

        AztecBitmap.Save(TxtLocationSave, ImageFormat.Bmp);

        // ajout a la table article
        //FileManagement.BLOBImport(TempBlob,TxtLocationSave);
        FileManagement.BLOBImportFromServerFile(TempBlob, TxtLocationSave);
        PArticle.CodeAZTEC := TempBlob.Blob;
        PArticle.CodeBar := true;
        PArticle.Modify();
        COMMIT();
        SLEEP(500);


        if EXISTS(TxtLocationSave) then
            ERASE(TxtLocationSave);
    end;
}

