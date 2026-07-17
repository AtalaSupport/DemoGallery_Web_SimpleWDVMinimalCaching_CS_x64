using System;
using System.Web;
using Atalasoft.Imaging.WebControls;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;


public class WDVCachingHandler : WebDocumentRequestHandler
{
    static WDVCachingHandler()
    {
        Atalasoft.Imaging.Codec.RegisteredDecoders.Decoders.Add(new Atalasoft.Imaging.Codec.Pdf.PdfDecoder() { Resolution = 200 }); //Lets us view PDFs.
    }

    public WDVCachingHandler()
    {
        this.DocumentInfoRequested += WDVHandler_DocumentInfoRequested; // Will always be called first.
    }

    private void WDVHandler_DocumentInfoRequested(object sender, DocumentInfoRequestedEventArgs e)
    {
        // if the incoming e.FilePath starts with "https" then we need to go fetch it locally
        // and update the e.FilePath with the new localpath
        // From there, WDV will use its normal defaults for "I jsut asked it to open a local virtual
        // file that is on disk on the server"
        //
        // Older versions of DotImage would not properly update when e.FilePath was updated after initial call
        // SO they need a much more complex mechanism
        //
        // TL;DR: if e.FilePath is a url it will download the document to a lotal file then return it
        // if e.Filepath is not a URL it assumes normal rules for WDV (virtual file)
        // You will need to implement your own scavenging / caching routine if you want something 
        // more robust.. this is just a minimal example

        if (e.FilePath.StartsWith("https"))
        {
            string cachedDocFileName = Guid.NewGuid().ToString();
            // This will be what we return
            string cachedVirtualPath = "/CahcedImages/" + cachedDocFileName;
            // doing this because we need a physical path for the save/download
            string tempPath = Path.Combine(HttpContext.Current.Request.MapPath("/CahcedImages/"), cachedDocFileName); //Make up a temp filename.

            // Needed by system.net.webclient
            ServicePointManager.ServerCertificateValidationCallback += ValidateRemoteCertificate;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            using (var client = new System.Net.WebClient())
            {
                client.DownloadFile(e.FilePath, tempPath);
            }

            e.FilePath = cachedVirtualPath;
        }
    }


    /// <summary>
    /// Certificate validation callback.
    /// </summary>
    private static bool ValidateRemoteCertificate(object sender, X509Certificate cert, X509Chain chain, SslPolicyErrors error)
    {
        // If the certificate is a valid, signed certificate, return true.
        if (error == System.Net.Security.SslPolicyErrors.None)
        {
            return true;
        }

        Console.WriteLine("X509Certificate [{0}] Policy Error: '{1}'",
            cert.Subject,
            error.ToString());

        return false;
    }
}
