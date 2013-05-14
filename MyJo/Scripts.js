var savedSel ;
var editor;


window.onload=function(){
    //    debugger;
    //    rangy.init(); //Seems to fire ok
    editor = document.getElementById('content');
    
}

function doIt()
{
    editor.focus();
    document.execCommand('insertImage', false, '/Users/yassingamal/Desktop/photo0.png')
    
}
function doBold()
{
    var isAllBold = document.queryCommandState("Bold");
    if(!isAllBold)
    {
        document.execCommand("Bold");
    }
}

function doUnBold()
{
    var isAllBold = document.queryCommandState("Bold");
    if(isAllBold)
    {
        document.execCommand("Bold");
    }
}


function doItalic()
{
    var isAllBold = document.queryCommandState("Italic");
    if(!isAllBold)
    {
        document.execCommand("Italic");
    }
}

function doUnItalic()
{
    var isAllBold = document.queryCommandState("Italic");
    if(isAllBold)
    {
        document.execCommand("Italic");
    }
}




function saveSelection()
{
    savedSel = rangy.saveSelection();
}


function getFocus()
{
    editor.focus();
}

function restoreSelection()
{
    rangy.restoreSelection(savedSel);
}

function selectAllContent()
{
    document.execCommand('selectAll',false,null);
}


function moveImageAtTo(x, y, newX, newY) {
//    debugger;
    // Get our required variables
    var element  = document.elementFromPoint(x, y);
    if (element.toString().indexOf('Image') == -1) // Attempt to move an image which doesn't exist at the point
        return;
    var caretRange = document.caretRangeFromPoint(newX, newY);
    var selection = window.getSelection();
    
    // Save the image source so we know this later when we need to re-insert it
    var imageSrc = element.src;
    
    // Set the selection to the range of the image, so we can delete it
    var nodeRange = document.createRange();
    nodeRange.selectNode(element);
    selection.removeAllRanges();
    selection.addRange(nodeRange);
    
    // Delete the image
    document.execCommand('delete');
    
    // Set the selection to the caret range, so we can then add the image
    var selection = window.getSelection();
    var range = document.createRange();
    selection.removeAllRanges();
    selection.addRange(caretRange);
    
    // Re-insert the image
    document.execCommand('insertImage', false, imageSrc);
}
