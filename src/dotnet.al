dotnet
{
    assembly("zxing")
    {
        Version = '0.16.6.0';
        Culture = 'neutral';
        PublicKeyToken = '830ae994e36ac27d';

        type("ZXing.BarcodeFormat"; "BarcodeFormat")
        {
        }

        type("ZXing.BarcodeWriter"; "BarcodeWriter")
        {
        }

        type("ZXing.Common.EncodingOptions"; "EncodingOptions")
        {
        }

        type("ZXing.Common.BitMatrix"; "BitMatrix")
        {
        }
    }

    assembly("System.Drawing")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("System.Drawing.Imaging.ImageFormat"; "ImageFormat")
        {
        }

        type("System.Drawing.Bitmap"; "Bitmap")
        {
        }
    }

}
