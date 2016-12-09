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
        var uniqueGenerator = $("#generator").val();
        
        //check previous value empty or not 
        if(checkEmptyValue(uniqueGenerator))
        {
        	
        	if (document_id == 1 && signer_id == 1) {
    			dragEl = ui.helper.clone().html('<span class="titlepad">Name</span><span class="closeIt hideIt">x</span><input type="text" id="fullname_'+uniqueGenerator+'" class="form-control" value=""  placeholder="Name" onclick="loadpopover('+uniqueGenerator+')" readonly /><input type="hidden" id="element_'+uniqueGenerator+'" />');
    			dragEl.attr('id', 'fullnamewrap_'+uniqueGenerator);
    			
    		} else if (document_id == 1 && signer_id == 2) {
    			dragEl = ui.helper.clone().html('<span class="titlepad">Date</span><span class="closeIt hideIt">x</span><input type="text" id="date_'+uniqueGenerator+'" class="form-control" value="" placeholder="date" onclick="loadpopover('+uniqueGenerator+')" readonly /><input type="hidden" id="element_'+uniqueGenerator+'" />');
    			dragEl.attr('id', 'datewrap_'+uniqueGenerator);
    		} else if (document_id == 1 && signer_id == 3) {
    			dragEl = ui.helper.clone().html('<span class="titlepad">Signature</span><span class="closeIt hideIt">x</span><input type="text" id="sign_'+uniqueGenerator+'"  class="form-control" onclick="loadpopover('+uniqueGenerator+')" readonly placeholder="signature" /><input type="hidden" id="element_'+uniqueGenerator+'" /><div id ="enableselfsign_'+uniqueGenerator+'">');
    			dragEl.attr('id', 'signwrap_'+uniqueGenerator);
    		}
        	dragEl.attr('name', uniqueGenerator);
            var incremented = parseInt(uniqueGenerator)+1;
            $("#generator").val(incremented);
            
            
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


  function addSignature(){
		var text;
		var fieldValue=$("#imageField").val();
		var val="";
		if(x=="My Signature") {  //my signature 
			var signId = $("#mysignatureflag").val();
			var sign = document.getElementById('mySignature'+signId);
			dataURL = sign.getAttribute('src');
			sign.setAttribute('src', dataURL);
			$('#myModal').modal('hide');
			val= $("#field"+fieldValue).attr('src', dataURL);
			$("#field"+fieldValue).attr('data', dataURL);
		}else
		if(x=="Upload") {  //upload 
			var sign = document.getElementById('show_update_sign');
 			dataURL = sign.getAttribute('src');
 			sign.setAttribute('src', dataURL);
			$('#myModal').modal('hide');
			val=$("#field"+fieldValue).attr('src', dataURL);
			$("#field"+fieldValue).attr('data', dataURL);
			$("#mysignatureflag").val("");
		}else
		if(x=="Draw"){  //draw 
			text = $('#colors_sketch')[0].toDataURL();
			dataURL = text;
			$('#myModal').modal('hide');
			val=$("#field"+fieldValue).attr('src', dataURL);
			$("#field"+fieldValue).attr('data', dataURL);
			$("#mysignatureflag").val("");
		}else
		{  //draw 
			var dataURL = $("#myType").val();
			$('#myModal').modal('hide');
			val=$("#field"+fieldValue).attr('src', dataURL);
			$("#field"+fieldValue).attr('data', dataURL);
			$("#mysignatureflag").val("");
		}
		
	}

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


function getSigntype(){
	var typeValue=$("#typeSign").val();
	//dataURL = typeValue.toDataURL();
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
	     global: false,
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	    });  
}

	function loadpopover(uniqueGenerator)
	{
		//alert(uniqueGenerator);
		//$("[data-toggle=popover]").popover();
		$('div.dragMe').popover({ 
		    html : true,
		    title: '<input type="hidden" id="popupid" value="'+uniqueGenerator+'" />',
		    
		    content: function() {
		      return $("#popover-content").html();
		    }
		});
	}
	
	$('html').on('mouseup', function(e) {
	    if(!$(e.target).closest('.popover').length) {
	        $('.popover').each(function(){
	            $(this.previousSibling).popover('hide');
	        });
	    }
	});	
	
	
function popoverDropdown(optionVal)
{ 
	
	//var uniqueNo = $('#popupid').val();
	var uniqueNo = $(".popover").prev("div.dragMe").attr('name');
	//console.log($(optionVal).parent("div").parent("div").find("#popupid").val());
	//var uniqueNo = $(optionVal).parent("div").parent("div").find("#popupid").val();
	var text = $(optionVal).find("option:selected").text();
	var value = optionVal.value;

	if($('#fullname_'+uniqueNo).length && optionVal.value !="")
	{
		$('#fullname_'+uniqueNo).val(text);
		$('#element_'+uniqueNo).val(value);
		$('#fullname_'+uniqueNo).attr('value',text);
		if(value==0){
			 $('#fullname_'+uniqueNo).attr("readonly", false);
		}else{
			$('#fullname_'+uniqueNo).attr("readonly", true);
		}
	}else if($('#date_'+uniqueNo).length && optionVal.value !="")
	{
		$('#date_'+uniqueNo).val(text);
		 $('#date_'+uniqueNo).attr('value', text);
		$('#element_'+uniqueNo).val(value);
		if(value==0){
			 $('#date_'+uniqueNo).attr("readonly", true);
			 $('#date_'+uniqueNo).val(todyaDate());
			 $('#date_'+uniqueNo).attr('value', todyaDate());
		}else{
			$('#date_'+uniqueNo).attr("readonly", true);
			$('#fullname_'+uniqueNo).val("");
			$('#fullname_'+uniqueNo).attr('value','');
		}
		
	}else if($('#sign_'+uniqueNo).length && optionVal.value !="")
	{
		$('#sign_'+uniqueNo).val(text);
		$('#element_'+uniqueNo).val(value);
		$('#sign_'+uniqueNo).attr('value',text);
		if(value==0){
			 $("#enableselfsign_"+uniqueNo).html("");
			 $("#enableselfsign_"+uniqueNo).prepend('<img id="field'+uniqueNo+'" data="" class="selfsign-control1" src="images/blue.jpg" data-toggle="modal" onclick="modalPopBox('+uniqueNo+');" alt="Smiley face" height="42" width="150">');
		}else{
			 $("#enableselfsign_"+uniqueNo).html("");
		}
	}
	//console.log(optionVal.getAttribute("class"));
	$(".popover").popover('hide');
}

function popupSubmit(){
	var uniqueGenerator = $("#generator").val();
	var records=[];
	var me = false;
	
	$('#groupsignpopupalert').hide();
	$('#allsignermust').html("");
	
	for(var i=1; i< uniqueGenerator; i++){

			var priority = $("#element_"+i).val();
			var name;
			var email;
			var left;
			var top;
			var fieldValue;
			var fieldType;
			var items = {};
			
			if($("#fullname_"+i).length) 
			{
				
				var fullname =$("#fullname_"+i); 
				if(priority != "" &&  fullname.val() !="" && fullname.val().trim() != "")
				{
					items['priority']	 = priority;
					items['signerName']		 = getDataByPriority(priority,'name');
					items['signerEmail']	 	 = getDataByPriority(priority,'email');
					items['left']		 = $('#fullnamewrap_'+i).css("left");
					items['top'] 		 = $('#fullnamewrap_'+i).css("top");
					items['fieldValue']	 = fullname.val().trim();
					items['fieldName'] 	 = "name";
					items['fieldtype']	 = "text";
					items['pageNumber']	 = "1"
					items['height']	 	 = "34"
					items['width']	 	 = "161"
						
					records.push(items);	
				}else{
					$('#groupsignpopupalert').show();
					$('#allsignermust').html("Enter name of signee. ");
					$("#fullname_"+i).focus();
					return false;
				}
				
			}else if($("#date_"+i).length)
			{
				var date =$("#date_"+i); 
				if(priority != "" &&  date.val() !="" && date.val().trim != "")
				{
					items['priority']	 = priority;
					items['signerName']		 = getDataByPriority(priority,'name');
					items['signerEmail']	 	 = getDataByPriority(priority,'email');
					items['left']		 = $('#datewrap_'+i).css("left");
					items['top'] 		 = $('#datewrap_'+i).css("top");
					items['fieldValue']	 = date.val().trim();
					items['fieldName'] 	 = "date";
					items['fieldtype']	 = "text"
					items['pageNumber']	 = "1"
					items['height']	 	 = "34"
					items['width']	 	 = "161"
						
					records.push(items);
					
				}else{
					$('#groupsignpopupalert').show();
					$('#allsignermust').html("Enter date of signature.");					
					$("#date_"+i).focus();
					return false;
				}
			}else if($("#sign_"+i).length)
			{
				var sign =$("#sign_"+i); 
				if(priority != "" &&  sign.val() !="" && sign.val().trim != "")
				{
					
					items['priority']	 = priority;
					items['signerName']		 = getDataByPriority(priority,'name');
					items['signerEmail']	 	 = getDataByPriority(priority,'email');
					items['left']		 = $('#signwrap_'+i).css("left");
					items['top'] 		 = $('#signwrap_'+i).css("top");
					items['fieldValue']	 = sign.val().trim();
					if(priority == 0 ){
						if($("#field"+i).attr("data") !=""){
							 items['fieldValue'] = $("#field"+i).attr("src");
						}else{
							$('#groupsignpopupalert').show();
							$('#allsignermust').html("Please sign yourself. ");					
							$("#sign_"+i).focus();
							return false;
						}					
					}
					items['fieldName'] 	 = "sign";
					items['fieldtype']	 = "image"
					items['pageNumber']	 = "1"
					items['height']	 	 = "34"
					items['width']	 	 = "161"
					
					records.push(items);
					
				}else{
					$('#groupsignpopupalert').show();
					$('#allsignermust').html("Choose signature for the selected signee. ");
					$("#sign_"+i).focus();
					return false;
				}
			}
		
			if(priority == 0){
				me =true;
			}
	}
	
	//check me assign or not
	 if($('#selfsign').is(':checked'))
	 {
		if(me == false){
			$('#groupsignpopupalert').show();
			$('#allsignermust').html("Assign at least one field to yourself. ");
			return false;
		} 
	 }
	
	//check all signers assign to sign
	var table = document.getElementById("signers_list");
	for (var i = 1, row; row = table.rows[i]; i++) 
	{
		var found = false;
		for(var j=1; j< uniqueGenerator; j++){
			var priority = $("#element_"+j).val();
			if(priority != "" && row.cells[0].innerHTML == priority){
				found =true;
			}
		}
		if(found==false){
			content = document.getElementById($(row.cells[1].innerHTML).attr("id")).value;
			$('#groupsignpopupalert').show();
			$('#allsignermust').html("Assign at least one field to: "+content);
			return false;
			break;
		}else{
			$('#groupsignpopupalert').hide();
			$('#allsignermust').html("");
		}
		
	}

	
	
	$("#signerjsondata").val(JSON.stringify(records));
	
	$("#signerslistdiv").css({ 'pointer-events': "none" });
	$("#signerslistdiv").css({ 'background-color': "#eee" });
	$("#enableedit").show();
	$("#groupsignalert").hide();
	$("#groupsignsuccessalert").show();
	$("#groupsignsendsuccessmsg").html("Document successfully prepared.");
	
	$("#fillandsign").modal('hide');
	$('body').removeClass('modal-open');
	$('.modal-backdrop').remove();
	
	//start edit groupsign fields
	$("#fieldshtml").val("");
	var fieldsHTML = "";
	$("#document-reader > .dragMe").each(function() {
		fieldsHTML += $(this).prop("outerHTML");
	});
	$("#fieldshtml").val(fieldsHTML);
	//end edit groupsign fields
}

function getDataByPriority(priority,type)
{
	var table = document.getElementById("signers_list");
	var content;
	if(priority == 0){
		if(type == "name"){
			content = document.getElementById("selfname").value;
		}else if(type == "email"){
			content = document.getElementById("selfemail").value;
		}
	}else
	{
		
	
		for (var i = 1, row; row = table.rows[i]; i++) 
		{
			if(row.cells[0].innerHTML == priority && type == "name"){ 
				content = document.getElementById($(row.cells[1].innerHTML).attr("id")).value;
				break;
			}else if(row.cells[0].innerHTML == priority && type == "email"){ 
				content = document.getElementById($(row.cells[2].innerHTML).attr("id")).value;
				break;
			}else{ 
				content = "";
			}
			
		}
	
	}
	return content;
}

function checkEmptyValue(uniqueGenerator)
{ 
	$('#groupsignpopupalert').hide();
	$('#allsignermust').html("");
	var uniqueGenerator = parseInt(uniqueGenerator)-1;
	
	if(uniqueGenerator != 0){
		
		var name = $("#fullname_"+uniqueGenerator);
		var date = $("#date_"+uniqueGenerator);
		var sign = $("#sign_"+uniqueGenerator);
		
		if(name.length != 0) 
		{
			if(name.val() =="")
			{
				$('#groupsignpopupalert').show();
				$('#allsignermust').html("Enter name of signee. ");
				name.focus();
				return false;
			}
		}
		
		if(date.length != 0) 
		{
			if(date.val() =="")
			{
				$('#groupsignpopupalert').show();
				$('#allsignermust').html("Enter date of signature.");
				date.focus();
				return false;
			}
		}

		if(sign.length != 0) 
		{
			if(sign.val() =="")
			{
				$('#groupsignpopupalert').show();
				$('#allsignermust').html("Choose signature for the selected signee. ");
				sign.focus();
				return false;
			}
		}
		
		
	}
	return true;
}

function todyaDate(){
	
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

	today = mm+'/'+dd+'/'+yyyy;
	return today;
}