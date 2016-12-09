$(function(){
	
    DragSigner();
    DragMe();
    getSigntype();
    modalPopBoxPDF();
 
    
})

/*******************************Drag and Drop Functionality start here********************/
//This is use for DragSigner
function DragSigner(){

    $(".dragSigners").draggable({
      helper: 'clone',
      cursor: 'move',
      tolerance: 'fit',
      revert: true 
    });
    
    $("#document-reader").droppable({  
      accept: '.dragSigners',
      activeClass: "drop-area",
      drop: function(e, ui) {
        dragEl = ui.helper.clone();
        ui.helper.remove();
        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        leftPosition  = ui.offset.left - $(this).offset().left;
        topPosition   = ui.offset.top - $(this).offset().top;
        var pageNum = $(e.target).closest('div').find('.pageimg').attr("id");
        var uniqueGenerator = $("#generator").val();
        if (document_id == 1 && signer_id == 1) {
			dragEl = ui.helper.clone().html('<input type="text" id="field'+uniqueGenerator+'" class="selfsign-control"  onchange="getfieldValue(this.value,'+uniqueGenerator+')" value="" name="name" required />');
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
		} else if (document_id == 1 && signer_id == 2) {
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1; //January is 0!
			var yyyy = today.getFullYear();

			if(dd<10) {
			    dd='0'+dd
			} 

			if(mm<10) {
			    mm='0'+mm
			} 

			today = dd+'/'+mm+'/'+yyyy;
			dragEl = ui.helper.clone().html('<input type="text" id="field'+uniqueGenerator+'" class="selfsign-control" value="'+today+'" name="date" onchange="getfieldValue(this.value,'+uniqueGenerator+')"  required readonly/>');
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
		} else if (document_id == 1 && signer_id == 3) {
			dragEl = ui.helper.clone().html('<img id="field'+uniqueGenerator+'"  class="selfsign-control1" alt="Signature" data-toggle="modal" onclick="modalPopBox('+uniqueGenerator+');"  height="auto" width="70">');
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
		}
        var incremented = parseInt(uniqueGenerator)+1;
        $("#generator").val(incremented);

        dragEl.data("signer-id", signer_id);
        dragEl.draggable({
          helper: 'original',
          cursor: 'move',
          tolerance: 'fit',
          drop: function (event, ui) {
            $(ui.draggable).remove();
          }
        });

        // append element to #document-reader
        dragEl.addClass("dragMe");
        dragEl.removeClass("dragSigners col-sm-6 parent");
        dragEl.find("span.closeIt").removeClass("hideIt");
        dragEl.appendTo('#document-reader');
        DragMe();
      }
    });
   
  }



//This is use for DragMe
function DragMe(){
    var document_id;
    $(".dragMe").draggable({
      containment: "#document-reader",
      cursor: 'move',
      // opacity: 0.35,
      stack: $('#document-reader'),
      scroll: false,
      appendTo: $("#document-reader"),
      start: function(event, ui) {
        startPosition = $(this).position();
      },
      stop: function(event, ui) {
        dragEl        = $(this);
        stopPosition  = dragEl.position();
        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        var classes = $("#userSign").parent().eq(1).attr("id");
        if(!dragEl.hasClass("parent")){
        }
      }
    });    
 }


/*******************************Drag and Drop Functionality end here *******************************/

function getfieldValue(currentValue,id){
	//alert('CurrentValue'+currentValue+id);
	$("#field"+id).attr("value", currentValue);
	
}





/******************Signature[POP-BOX] TYPE functionality start here*********************************/
//show signature types
$("#typeSign").keyup(function(){
	var typeValue=$("#typeSign").val();
	$.ajax({  
	     type : "GET",   
	     url : $("#contextPath").val()+"ajax/createTypeFonts?imgType="+typeValue,   
	     dataType: 'json',
	     success : function(response) {  
	    	 var imgData=response;
	    	 	$("#selectType").empty();
    		 	$.each( imgData, function( key, value ) {
    		 		  $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a onclick="getTypeData('+key+')" class="thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
	    		});
	     },
	     global: false,
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	 });  
});			

//onchange type signatures show text
function getSigntype(){
	var typeValue=$("#typeSign").val();
	$.ajax({  
	     type : "GET",   
	     url : $("#contextPath").val()+"ajax/createTypeFonts",   
	     data : "imgType="+typeValue,  
	     dataType: 'json',
	     success : function(response) {  
	    	 var imgData=response;
	    	 	$("#selectType").empty();
    		 	$.each( imgData, function( key, value ) {
	    		  $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
	    		});
	     },  
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	 });  
}
function getTypeData(key){
	$('.selected').removeClass('selected');
    $('.imgselect'+key).addClass('selected');
	var imgSrc=$('#img'+key).attr('src');
	$("#myType").val(imgSrc);
}
/******************Signature[POP-BOX] TYPE functionality end here***********************************/




/******************Signature[POP-BOX] UPLOAD functionality start here*********************************/
//load signature image file and convert it into base 64
var dataURLFile;
function loadImageFileAsURL()
{
    var filesSelected = document.getElementById("myFile").files;
    if (filesSelected.length > 0)
    {
        var fileToLoad = filesSelected[0];
        var fileReader = new FileReader();
        fileReader.onload = function(fileLoadedEvent) 
        	{
      	  dataURLFile = fileLoadedEvent.target.result;
        	};
         fileReader.readAsDataURL(fileToLoad);
     }
}

function readImage() {
    if ( this.files && this.files[0] ) {
        var FR = new FileReader();
        FR.onload = function(e) {
             $('#uploadFile').attr( "src", e.target.result );
             $('#base').text( e.target.result );
        };       
        FR.readAsDataURL( this.files[0] );
    }
}

$("#asd").change(readImage);





/******************Signature[POP-BOX] DRAW functionality start here***********************************/

$(document).ready(function() {
	$('#linear').signaturePad({drawOnly:true, lineTop:200});
    $('#smoothed').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:200});
    $('#smoothed-variableStrokeWidth').signaturePad({drawOnly:true, drawBezierCurves:true, variableStrokeWidth:true, lineTop:200});
});




function modalPopBoxPDF(){
	$('#myModalPDF').modal('show');
}
/***********************************End Save Document ************************************/

/***********************************Ajax File Upload ****************************************/





