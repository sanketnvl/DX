function toggle_visibility(id) {
    var e = document.getElementById(id);
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
}


$(window).load(function(){
	  //$('#dvLoading').fadeOut(100);
	});

$(document).ready(function(){ 
	


});

$(function(){
	getSigntype();
});

    $(document).ready(function() {
      $('#linear').signaturePad({drawOnly:true, lineTop:200});
      $('#smoothed').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:200});
      $('#smoothed-variableStrokeWidth').signaturePad({drawOnly:true, drawBezierCurves:true, variableStrokeWidth:true, lineTop:200});
    });
    
    
//phase 2 

var x;
var y ;
$(document).ready(function(){
    $('.nav-tabs a').on('shown.bs.tab', function(event){
         x = $(event.target).text();         // active tab
         y = $(event.relatedTarget).text();  
    });
});

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

//show signature types
$("#typeSign").keyup(function(){
	var typeValue=$("#typeSign").val();
	//dataURL = typeValue.toDataURL();
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


function getTypeData(key){
	
	$('.selected').removeClass('selected');
    $('.imgselect'+key).addClass('selected');
	
	var imgSrc=$('#img'+key).attr('src');
	$("#myType").val(imgSrc);
}

function readImage() {
    if ( this.files && this.files[0] ) {
        var FR = new FileReader();
        FR.onload = function(e) {
             $('#img').attr( "src", e.target.result );
             $('#base').text( e.target.result );
        };       
        FR.readAsDataURL( this.files[0] );
    }
}

function modalPopBox(value){
	$("#imageField").val(value);
	$('#myModal').modal('show');
}



$("#asd").change(readImage);
    
    



$(document).ready(function() {
    $('#linear').signaturePad({drawOnly:true, lineTop:200});
    $('#smoothed').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:200});
    $('#smoothed-variableStrokeWidth').signaturePad({drawOnly:true, drawBezierCurves:true, variableStrokeWidth:true, lineTop:200});
  });

  