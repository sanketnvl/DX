 function readURL(input) {
 if (input.files && input.files[0]) {
     var reader = new FileReader();

     reader.onload = function (e) {
         $('.blah')
             .attr('src', e.target.result);
            
     };

     reader.readAsDataURL(input.files[0]);
 }
}


function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
       $(elem).prev().find('a[data-toggle="tab"]').click();
}	   $('#example').DataTable( {});
	  
$('.square_2').on('click', function(){
 		 $('.square_2.active').removeClass('active');
 		 $(this).addClass('active');

$('.row_4').show('.square_2.active#test12');
  });



function docUpload(){
	 $('form#UploadForm').submit();
}

function delteAjaxUploadFile(fileId,fileName)
	{
		$("#doc-error-msg").hide();
		$("#doc-success-msg").hide();
		$("#doc-error-msg-text").html("");
		$("#doc-success-msg-text").html("");
		$("#groupsignuploadpopupalert").hide();
		$("#groupsignuploadpopupmessage").html("");
	 	$.ajax({
			
			type : "POST",
			url : "deleteajaxuploadeddocument",
		    data: {'fileId':fileId,'fileName':fileName},
	        success : function(response) {
	        	if(response==1){
	        		$("#UploadForm").show();
	        		$("#ajaxuploadedfile").html("");
	        		$('#groupfilename').html("");
	        		$('#groupfileid').html("");
	        		$('#percent').html("");
	        		$('#myfile').val("");
	        		$('#groupfilename').val("");
	        		$('#signerjsondata').val("");
	        		$('#fieldshtml').val("");
	        		
	        		$('#groupfilename').val("");
	        		$('#groupfileid').val("");
	        		$('#envelopeid').val("");
	        		
	    			$("#doc-success-msg").show();
	    			$("#doc-error-msg").hide();
	    			$("#doc-success-msg-text").html("File successfully deleted.");
	        	}else{
	        		$("#doc-success-msg").hide();
	    			$("#doc-error-msg").show();
	    			$("#doc-error-msg-text").html("Error in File deletion.");

	        	}
	        	
	        	
	
			}
		}); 
	}


//Renumber table rows
	function renumber_table(tableID) {
		$(tableID + " tr").each(function() {
			count = $(this).parent().children().index($(this)) + 1;
			$(this).find('.priority').html(count);
		});
	}



 $(document).ready(function() {
	 
	//Initialize tooltips
	 $('.nav-tabs > li a[title]').tooltip();
	 //Wizard
	 $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

	     var $target = $(e.target);

	     if ($target.parent().hasClass('disabled')) {
	         return false;
	     }
	 });
	 /* $(".next-step").click(function (e) {

	     var $active = $('.wizard .nav-tabs li.active');
	     $active.next().removeClass('disabled');
	     nextTab($active);

	 }); */
	 $(".prev-step").click(function (e) {

	     var $active = $('.wizard .nav-tabs li.active');
	     prevTab($active);

	 });
	 
	 
	 $("#signtype1").click(function(){
		 $("#selftype").prop("checked", true)
	  });
	 $("#signtype2").click(function(){
		 $("#grouptype").prop("checked", true)
	  });
	 
	 
		var options = {
		        beforeSend : function() {
		                $("#progressbox").show();
		                $("#progressbar").width('0%');
		                $("#doc-error-msg").hide();
		    			$("#doc-success-msg").hide();
		                $("#doc-error-msg-text").html("");
		                $("#doc-success-msg-text").html("");
		                $("#percent").html("0%");
		        },
		        uploadProgress : function(event, position, total, percentComplete) {
		                $("#progressbar").width(percentComplete + '%');
		                $("#percent").html(percentComplete + '%');
		                
		                if (percentComplete > 50) {
		                	
			    			
		                }
		        },
		        success : function(response) {
		                $("#progressbar").width('100%');
		                $("#percent").html('100%');
		                
		                var obj = JSON.parse(response);
			        	if(obj.status == 'S' && obj.fileId != null){
			        		$('#groupfilename').val(obj.fileName);
			        		$('#groupfileid').val(obj.fileId);
			        		$('#envelopeid').val(obj.envelopeId);
			        		$("#UploadForm").hide();
			        		
			        		$("#ajaxuploadedfile").html('<div class="inner-addon left-addon"><i class="glyphicon icon-doc-pdf"></i><input type="text" class="form-control input-lg" placeholder="'+obj.fileName+'"><a href="javascript:delteAjaxUploadFile('+obj.fileId+',\''+obj.fileName+'\')" ><span class="icon-circle-x closy"></span></a></div>');
			        		responseMessage = obj.message;
			        		
			        		$("#doc-success-msg").show();
			    			$("#doc-error-msg").hide();
			    			$("#doc-success-msg-text").html(responseMessage);
			    			
			        		
			        	}else if(obj.status == 'E'){
			        		responseMessage = obj.message;
			        		$("#doc-success-msg").hide();
			        		$("#doc-error-msg").show();
			    			$("#doc-error-msg-text").html(responseMessage);
			        	}else{
			        		responseMessage = obj.message;
			        		$("#doc-success-msg").hide();
			    			$("#doc-error-msg").show();
			    			$("#doc-error-msg-text").html(responseMessage);
			        	}
		        },
		        complete : function(response) {
		        	
		        	
		        
		        },
		        error : function() {
	        		$("#doc-success-msg").hide();
	    			$("#doc-error-msg").show();
	    			$("#doc-error-msg-text").html("ERROR: unable to upload files");
		        }
		};
		$("#UploadForm").ajaxForm(options);

		
		
		//Helper function to keep table row from collapsing when being sorted
		var fixHelperModified = function(e, tr) {
			var $originals = tr.children();
			var $helper = tr.clone();
			$helper.children().each(function(index)
			{
			  $(this).width($originals.eq(index).width())
			});
			return $helper;
		};

		//Make diagnosis table sortable
		$("#signers_list tbody").sortable({
	    	helper: fixHelperModified,
			stop: function(event,ui) {renumber_table('#signers_list')}
		}).disableSelection();


		//Delete button in table rows
		$('table').on('click','.btn-delete',function() {
			var priority = parseInt($('#signers_list tr:last-child td:first-child').html());
			
			if(priority>1)
			{
				tableID = '#' + $(this).closest('table').attr('id');
				r = confirm('Delete this item?');
				if(r) {
					$(this).closest('tr').remove();
					renumber_table(tableID);
				}
			}
			
		});

		
	    //document.getElementById("checkbox-1").disabled = true;
		
	    
	    
	    var scntDiv = $('#p_scents');
        var i = $('#p_scents p').size() + 1;
        
        $('#addScnt').on('click', function() { 
        		var priority = parseInt($('#signers_list tr:last-child td:first-child').html()) + 1;
        		$('<tr class="row disttop2"><td class="numberingcls priority">'+priority+'</td><td><div class=""><input type="text" class="form-control " placeholder="Name" id="name_'+priority+i+'" name="name_'+priority+i+'"></div></td><td><div class=""><input type="email" class="form-control " placeholder="Email" id="email_'+priority+i+'" type="text" name="email_'+priority+i+'"></div></td><td><div class="col-md-1 col-sm-1 col-xs-1 close-btn"> <a class="btn btn-delete btNNCross"><i class="fa fa-times-circle" aria-hidden="true"></i></a> </div></td></tr>').appendTo(scntDiv);
        		
        		i++;
                priority++;
                return false;
        });
        
        $('#remScnt').on('click', function() { 
                if( i > 2 ) {
                        $(this).parents('p').remove();
                        i--;
                }
                return false;
        });
		
	});

 
 function next(current,next,step)
 {
 	 $("#doc-error-msg").hide();
 	 $("#doc-success-msg").hide();
 	 $("#doc-error-msg-text").html("");
 	 $("#doc-success-msg-text").html("");
 	 //step 1
 	 if(current==1 && next==2 && step==1)
 	 {
 		if (!$("input[name='signtype']:checked").val()) 
 		{
 			$("#doc-error-msg").show();
 			$("#doc-error-msg-text").html("Please select sign type.");
 		}else if(!$('#groupfilename').val() || !$('#groupfileid').val() || !$('#envelopeid').val())
 		{
 			$("#doc-error-msg").show();
 			$("#doc-error-msg-text").html("Please upload document.");
 		}
 		else{
 			 var $active = $('.wizard .nav-tabs li.active');
 			 $active.next().removeClass('disabled');
 			 nextTab($active);
 		}
 	 }
 }

 