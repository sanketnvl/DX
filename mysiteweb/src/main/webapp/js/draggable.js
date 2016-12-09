$(function(){
    DragSigner();
    DragMe();
  })

  //remove the dragsigner when click on close icon
  $(document).on("click", ".closeIt", function(){
    var parent = $(this).parent();
    parent.remove();
  });

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

        var pageNum = $(this).closest('div').find('.pageimg').attr("id");
		//console.log($(this).attr("id"));

		
        if (document_id == 1 && signer_id == 1) {
			dragEl = ui.helper.clone().html('<input type="textbox" id="fullname" class="form-control" value="" required placeholder="Name" />');
			dragEl.attr('id', 'fullname1');
		} else if (document_id == 1 && signer_id == 2) {
			dragEl = ui.helper.clone().html('<input type="date" id="signDate" class="form-control" value="" required/>');
			dragEl.attr('id', 'date1');
		} else if (document_id == 1 && signer_id == 3) {
		//	dragEl = ui.helper.clone().html('<button value="Signature" type="button" id="userSign" as="'+pageNum+'" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"><div class="form-control" id="showSign"></div>');
			dragEl = ui.helper.clone().html('<img id="userSign" src="images/blue.jpg" data-toggle="modal" data-target="#myModal" alt="Smiley face" height="42" width="150">');
			dragEl.attr('id', 'signature1');
		}
        
        // debug current dropped position
       //alert("top: " + topPosition + ", left: " + leftPosition); 
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

        // update draged element position to database
        // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)

        // activate dragging for cloned element
        DragMe();
      }
      
      
      
      
    });
   
  }



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
        
        
        
        // debug current dropped position
        // this position is working perfectly fine.
        // above drag, drop and clone position should behave like this
        //alert("top: " + stopPosition.top + ", left: " + stopPosition.left); 
        
        //var pageNum = $(this).closest('div').find('.pageimg').attr("id");
        /*console.log($('[data-document_id='+document_id+']'));
        $("ul").find("[data-slide='" + current + "']");
        */
       // $('#element').parents().eq(2)
        var classes = $("#userSign").parent().eq(1).attr("id");
        
        //console.log($(this).prev().attr("id"));
        
        //alert(classes);
        //console.log(dragEl.hasClass("parent"))
        if(!dragEl.hasClass("parent")){
         // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
        }
      }
    });
       
  }

  
  
  
  var x;
  var y ;
  $(document).ready(function(){

      $('.nav-tabs a').on('shown.bs.tab', function(event){
           x = $(event.target).text();         // active tab
           y = $(event.relatedTarget).text();  
          
      
         
      /*    $(".act span").text(x);
          $(".prev span").text(y);*/
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
             /* var textAreaFileContents = document.getElementById
              (
                  "textAreaFileContents"
              );*/
       
          	dataURLFile = fileLoadedEvent.target.result;
          	  
          };
       fileReader.readAsDataURL(fileToLoad);
         
      }
  }

  //add signature 
  function addSignature() {
  	var text;
  	
  	var sign = document.getElementById('img1');
  	
  	if(x=="Draw")
  	{
  	 text = document.getElementById('can');
  	 dataURL = text.toDataURL();
  	
  	}

  	else if(x=="My Signature") {
  	
  	dataURL = sign.getAttribute('src');
  	
  	}
  	else{
  		dataURL= sign.getAttribute('src');;
  		
  	}
  	//localStorage.setItem("data", dataURL);
  		sign.setAttribute('src', dataURL);
  		
  		 $('#myModal').modal('hide');
  	      //$("#myModal").hide();
  	      //$("#userSign").append('<img id="addSign" class="thumbnail"  src="" ></img>');
  	      //$("#userSign").val(120189282);
  	      //$("#userSign").remove();
  	      $("#userSign").attr('src', dataURL);		
  		
/*  	$("#userSign").hide();
  	$('#myModal').modal('hide');

  	//$("#myModal").hide();

  	$("#showSign").append('<img id="addSign" class="thumbnail"  src= +dataURL></img>');
  	
  	$("#addSign").attr('src', dataURL);*/

  }

  
  
// save data to HOME CONTROLLER

/*  function addSignature(){
      var sign=document.getElementById('img1');
      var newSign=sign.getAttribute('src');

       //$("#userSign").hide();
      $('#myModal').modal('hide');
      //$("#myModal").hide();
      //$("#userSign").append('<img id="addSign" class="thumbnail"  src="" ></img>');
      //$("#userSign").val(120189282);
      //$("#userSign").remove();
      $("#userSign").attr('src', newSign);
//    $("#userSign").css("background-color", "white");
      
 }*/


function saveDocumentSign() 
{
	var fullname = $("#fullname").val();
	var signDate = $("#signDate").val();
	
	var sign = document.getElementById('userSign');
	var signature = sign.getAttribute('src');
	var fileName = $("#fileName").val();

	var dateLeft = $("#date1").css("left");
	var dateTop = $("#date1").css("top");
	
	var namePosition = $("#fullname1").css("position");
	var nameLeft = $("#fullname1").css("left");
	var nameTop = $("#fullname1").css("top");

	var signPosition = $("#signature1").css("position");
	var signLeft = $("#signature1").css("left");
	var signTop = $("#signature1").css("top");
	
	var csrfidval = $("#csrfid").val();
	var csrfname = $("#csrfname").val();
	
	
	//alert("signLeft: "+signLeft+ " signTop: "+signTop);
	$.ajax({
		
		
		
		type : "POST",
		url : "saveDocumentSign",
		data : "dateLeft="+dateLeft +"&fullName="+fullname+"&dateTop=" + dateTop + "&signDate=" + signDate + "&signature="
				+ signature + "&fileName=" + fileName + "&namePosition="
				+ namePosition + "&nameLeft=" + nameLeft + "&nameTop="
				+ nameTop + "&signPosition=" + signPosition + "&signLeft="
				+ signLeft + "&signTop=" + signTop+"&_csrf="+csrfidval,
		 /*data: JSON.stringify({
			    "dateLeft":dateLeft,
			    "dateTop":dateTop,
			    "signDate":signDate,
			    "signature":signature,
			    "namePosition":namePosition,
			    "nameLeft":nameLeft,
			    "nameTop":nameTop,
			    "signPosition":signPosition,
			    "signLeft":signLeft,
			    "signTop":signTop,
			    "_csrf":csrfidval
			    
			  }),
			  dataType: "json",
			  contentType: "application/json",*/
		success : function(response) {
			alert('Document save successfully');
			window.location.href = "showFiles";
		}
	});
	
}