# SimpleWDVMinimalCaching
Demonstrates how to use the WebDocumentViewer with remote https urls

This is needed because despite having the name "openUrl()" the WDV open
only opens local virtual files.

This code handles the DocumentInfoRequested event and when it sees that 
an incoming request starts with "https", it fetches the file to a local 
virtual path and then updates so that it can handle locally.

This is very minimal caching and can be adapted for any "get me some file hosted 
somewhere not local to me" approach.

This is the C# version

## Prerequisites
### DotImage Document Imaging
This demo assumes you have the Atalasoft SDK DotImage SDK installed and 
licensed for DotImage Document Imaging (or you can request a 30 day evaluation when 
installing/activating)

[Download DotImage](https://www.atalasoft.com/BeginDownload/DotImageDownloadPage)

> **NOTE**
> This current build is based on DotImage 11.5.0.10. You may be able to back down
> to previous versions, but please ensure that you properly account for /ajust to 
> the differences in versions of jQuery, jQueryUI, and their associated css files.

### Visual Studio 2022 with .NET Framework 4.6.2 or above (but not .NET 5+)
This is a .NET Framework project. Since DotImage 11.5 supports .NET Framework 
4.6.2 as its minimum, this is the target. You can safely update it to higher  
.NET Framework versions (but not .NET 5+)

### IIS Express
This demo is set up using IIS Express (the built in web server in VS2022). 

#### Changing to Local IIS or deploying
You may alter it to run under a local copy of IIS, but if you do so you'll need 
to copy your licenses from

`c:\users\YOUR_USERNAME\AppData\Local\Atalasoft\DotImage\11.5\`

into the bin directory of the application (next to the Atalasoft DLLs)


## Cloning
We recommend the following if you wish to donload/clone a copy

Example: git for windows
```bash
git clone https://github.com/AtalaSupport/DemoGallery_Web_SimpleWDVMinimalCaching_CS_x64.git SimpleWDVMinimalCaching
```

