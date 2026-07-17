<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SimpleWDVMinimalCaching._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Simple Web Document Viewer with Annotations</title>
    <script src="WebDocViewer/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="WebDocViewer/jquery-ui-1.14.0.min.js" type="text/javascript"></script>
    <script src="WebDocViewer/raphael-min.js" type="text/javascript"></script>
    <script src="WebDocViewer/clipboard.min.js" type="text/javascript"></script>
    <script src="WebDocViewer/atalaWebDocumentViewer.js" type="text/javascript"></script>

    <link href="WebDocViewer/jquery-ui-1.14.0.min.css" rel="Stylesheet" type="text/css" />
    <link href="WebDocViewer/atalaWebDocumentViewer.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <input type="button" id="btn_url" value="Open tiff form Url" onclick="_viewer.openUrl('https://www.atalasupport.net/sampledocs/DocCleanMultipage.tif'); return false;" />
    <input type="button" id="Button1" value="Open test.pdf from Url" onclick="_viewer.openUrl('https://www.atalasupport.net/sampledocs/test.pdf'); return false;" />
    <input type="button" id="btn_dcm" value="Open DocCleanMultipage.tif" onclick="_viewer.openUrl('/Images/DocCleanMultipage.tif'); return false;" />
    <input type="button" id="btn_ga" value="Open GettysburgAddress.tif" onclick="_viewer.openUrl('/Images/GettysburgAddress.tif'); return false;" />
    <div id="_toolbar1" class="atala-document-toolbar" style="width: 670px;"></div>
    <div id="_container1" class="atala-document-container" style="width: 670px; height:500px;"></div>
    </form>
    <script type="text/javascript" language="javascript">
    //var _docUrl = '/Images/DocCleanMultipage.tif';
        var _docUrl = 'https://www.atalasupport.net/sampledocs/DocCleanMultipage.tif';
    var _serverUrl = '/WDVCachingHandler.ashx';
    var _savePath = '/Saves/';
    var _viewer = new Atalasoft.Controls.WebDocumentViewer({
    'parent': $('#_container1'), // parent container to put the viewer in
    'toolbarparent': $('#_toolbar1'), // parent container to put the viewer toolbar in
    'serverurl': _serverUrl, // server handler url to send image requests to
    'documenturl': _docUrl, // document url relative to the server handler url
    'savepath': _savePath,
    'allowannotations': true,
    'allowtext': true,
    'forcepagefit': true,
    'fitting': Atalasoft.Utils.Fitting.Width,
    'textannomobilezoom': false
});
// Example of binding to an event
_viewer.bind('documentsaved', function(e) {
    if (e.success) {
        alert('save success');
    } else {
        alert('error saving');
    }
});

// Burn all annotations on a single page
function burnAllAnnosOnPage(pageIndex, burnvalue) {
    var annos = _viewer.getAnnotationsFromPage(pageIndex);
    if (annos != null) {
        for (var i = 0; i < annos.length; i++) {
            var anno = annos[i];
            anno.burn = burnvalue;
            anno.update();
        }
    }
}

// burn all annos on all pages
function burnAllAnnos(burnvalue) {
    if (burnvalue == null) {
        burnvalue = true;
    }

    var pageCount = _viewer.getDocumentInfo().count;
    if (pageCount != null && pageCount > 0) {
        for (var i = 0; i < pageCount; i++) {
            burnAllAnnosOnPage(i, burnvalue);
        }
    }
}

</script>

    
</body>
</html>
