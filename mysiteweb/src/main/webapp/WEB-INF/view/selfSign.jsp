<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.myexample.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>

<% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>
<% Registration registration = (Registration)auth.getPrincipal(); %>

<% 
String fileName="user.png";
if(registration.getPhoto() != null) 
	{
		fileName = registration.getPhoto();
	}
String picPath = "images/profile/"+fileName;
%>

<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>


<jsp:include page="header.jsp" />
   <style>
      /* enable absolute positioning */
      .inner-addon { 
      position: relative; 
      }
      /* style icon */
      .inner-addon .glyphicon {
      position: absolute;
      padding: 10px;
      pointer-events: none;
      }
      /* align icon */
      .left-addon .glyphicon  { left:  0px;}
      .right-addon .glyphicon { right: 0px;}
      /* add padding  */
      .left-addon input  { padding-left:  30px; }
      .right-addon input { padding-right: 30px; }
      
      .alert-success1 {
	    color: #3c763d;
	    background-color: #dff0d8;
	    border-color: #d6e9c6;
	}
	.alert1 {
	    padding: 15px;
	    margin-bottom: 20px;
	    border: 1px solid transparent;
	    border-radius: 4px;
	}
	
	.error {
	    color:red !important;
	    background:none !important;
	    
	    font-size:13px; 
	}
	
	#draggable1 > .pad1 {
    padding-top: 10px;
    padding-bottom: 10px;
}
.icon-span-filestyle{display:none;}

	
   </style>
   

      <!-- Page Header -->
      <div class="row" style="background:#CCCCCC;">
        <div class="col-lg-3">
          <h3 class="page-header" >Self Sign</h3>
              </div>
               <div class="groupsigneralertclass col-lg-4">
                <div class="alert alert-danger fade in " style="display:none;" id="groupsignalert">
			<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
			<span class="alert fade in" id="groupsignsendmsg"></span>
   		</div>
	  	<div class="alert alert-success" style="display:none;" id="groupsignsuccessalert">
	    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
	    	<span class="alert fade in" id="groupsignsendsuccessmsg"></span>
	  	</div> 
 		</div>
      </div>

       <!-- /.row -->
       <!-- Projects Row -->
       <div class="row rowpad PADself" id="hide_row">
            
            
            <!-- <div class="col-xs-12 col-sm-6 col-md-6 portfolio-item">
                <h4>
                   <span>Step 1. Please upload your document</span>
                </h4>
                <br>
                <div class="col-xs-12 col-sm-12 col-md-12 selfDiv">
                   <div class="row">
                      <div class="col-xs-12 col-sm-12 col-md-12">
                         <div class="col-xs-6 col-sm-6 col-md-8 col-md-offset-1 text-center">
                            <a href="#" id="hideshow"  data-toggle="modal" data-target="#uploadFileModel" class="btn btn-block btn-style1">UPLOAD FILES</a>
                         </div>
                        
                      </div>
                   </div>
                    <div class="row pad1">
                       <div class="col-xs-12 col-sm-12 col-md-12">
                        
                       </div>
                    </div>
                    <div class="row ">
                       <div class="col-xs-12 col-sm-12 col-md-12">
                      		
                       		<div class="btn col-xs-12 col-sm-12 col-md-9 col-md-offset-1">
                      			<div id="message"></div>
								<div id ="ajaxuploadedfile">
							 
							</div>	
							
							
						</div>
						   <div class="col-xs-12 col-sm-12 col-md-12">
						   	<h4>
                        		<span id="showSteps" style="">&nbsp;&nbsp;Step 2. Prepare and Sign</span>
	                   		 </h4>
						   </div>
					
						<button type="button" class="btn btn-style2 col-xs-12 col-sm-12 col-md-9 col-md-offset-1" style="" id="prepare_and_sign"  onclick="readTr(document.getElementById('groupfileid').value)" disabled>PREPARE & SIGN</button>
					   </div>                        
                   </div>
                  </div>
                  </div> -->
                  
                  <div class="col-xs-12 col-sm-8 col-md-5 portfolio-item">
                     <h4>
                        <span><strong>Step 1:</strong> Please upload your document</span>
                        
                     </h4>
                     <br>
                     <div class="col-xs-12 col-sm-12 col-md-12" style="background-color:#F1EFF0;border:1px solid #ccc;padding:22px 0;">
                         <div class="row">
                           <div class="col-xs-12 col-sm-12 col-md-12">
                              <div class="col-xs-6 col-sm-6 col-md-8 col-md-offset-1 text-center">
                                 <a href="#" id="hideshow" class="btn btn-block btn-style1" style="margin: 15px 32px;color:#fff;" data-toggle="modal" data-target="#uploadFileModel">UPLOAD FILES</a>
                              </div>
                           
                           </div>
                        </div>
                        <div class="row pad1">
                           <div class="col-xs-12 col-sm-12 col-md-12">
                          
                           </div>
                        </div>
                     
            
                     </div>
                     
                     
                     
                      <div class="col-xs-12 col-sm-12 col-md-12"><br>
						    <h4>
                        		<span id="showSteps" style="margin-left:-12px;"><strong>Step 2:</strong> Prepare and Sign</span>
	                   		 </h4>
	                   		 <br>
						   </div>     
                     
                     <div class="col-xs-12 col-sm-12 col-md-12" style="background-color:#F1EFF0;border:1px solid #ccc;padding: 14px 1px 42px 0px;">
                                 <div class="row ">
                         <div class="col-xs-12 col-sm-12 col-md-12">
                         	
                         		<div class="btn col-xs-12 col-sm-12 col-md-8 col-md-offset-2" style="margin-top:10px;">
                        		<div id="message"></div>
								<div id="ajaxuploadedfile"></div>	
								</div>
							
								<button type="button" class="btn btn-style2 col-xs-12 col-sm-12 col-md-8 col-md-offset-2" style="width: 255px;margin:2px 78px" id="prepare_and_sign" onclick="readTr(document.getElementById('groupfileid').value)" disabled="">PREPARE &amp; SIGN</button>
						</div>     
						 </div>
                        </div>
                     </div>
                  <div class="col-xs-12 col-sm-6 col-md-6 portfolio-item">
                     <h4 style="padding-left: 10px;">
                        <span><strong>Step 3:</strong> Enter recipient's email ID</span>
                     </h4>
                     <br>
                     <div class="col-xs-12 col-sm-12 col-md-12">
                       <form id="form1" name="form1"> 
                           <fieldset>
                              <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                       <input type="text" id="email" placeholder="<%=registration.getEmail()%>" value="<%=registration.getEmail()%>" class="form-control" name="from" readonly/>
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group pad1">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                       <input type="text" id="recipient"  placeholder="Add Recipient *" class="form-control" name="recipient" />
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group pad1">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                       <input type="text" id="cc"  placeholder="Add CC" class="form-control" name="cc" />
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group pad1">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                       <input type="text" id="title" placeholder="Subject*" class="form-control" name="title" />
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group pad1">
                                 <textarea name="message"" placeholder="Message *" 
                                    class="form-control" name="message" id="emailsubject" ></textarea>
                              </div>
                              <div class="row pad2">
                                 <div class="col-xs-12 col-sm-4 col-sm-offset-6 col-md-4 col-md-offset-8">
                                    <input type="button" id="sendEmail" onclick="saveSelfSign();" class="col-xs-12 btn btn-lg btn-primary"  style="border-radius:0;" value="Send"/>
                                 </div>
                              </div>
                              <input type="hidden" id="jsonPDFData" value="" />
                           </fieldset>
                        </form>
                     </div>
                  </div>
               </div>
               
	<jsp:include page="footer.jsp"></jsp:include>
       <!-- Modal pic -->
<!-- upload files model -->
 <div class="modal fade" id="uploadFileModel" role="dialog">
    <div class="modal-dialog">
       <!-- Modal content-->
       <div class="modal-content">
     	 <form id="UploadForm" action="ajaxupload" method="post" enctype="multipart/form-data">
	          <div class="modal-header">
	             <button type="button" class="close" data-dismiss="modal">&times;</button>
	             <h4 class="modal-title">Please select your file </h4>
	          </div>
	          <div class="modal-body">
	 			<div class="row">
					<div class="col-xs-12 col-sm-6 col-md-12">
						 <label class="control-label">Select File</label>
						 <input type="file" size="60" id="myfile" name="file" class="filestyle">
						<input type="hidden" name="signtype" value="S">
						<input type="hidden" id="loginuserid" name="loginuserid" value="<% if (registration != null) { out.print(registration.getId()); } %>" /> 
					</div>
				</div>	 
			 </div>
	          <div class="modal-footer">
	                 <div class="alert alert-danger fade in " style="display:none;text-align: center;" id="groupsignuploadpopupalert">
						<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						<div id="groupsignuploadpopupmessage"></div>
			   		</div>
	         	   <div class="col-xs-12 col-sm-2 col-md-2 pull-right padHH">
					<input type="submit" value="Save" class="form-control btn btn-primary">
				</div>
	          </div>
		</form>	
       </div>
    </div>
 </div>
 
 
<!-- POP UP BOX for Signature start here -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index:100000;display:none;">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					 
					 <li role="presentation" class="active"><a href="#type" aria-controls="type" role="tab" data-toggle="tab">Type</a></li> 
					 <li role="presentation"><a href="#draw" aria-controls="profile" role="tab" data-toggle="tab">Draw</a></li>
					 <li role="presentation"><a href="#upload"aria-controls="messages" role="tab" data-toggle="tab">Upload</a></li>
					 <!-- <li role="presentation"><a href="#mysignature" aria-controls="settings" role="tab" data-toggle="tab">My Signature</a></li> -->
				</ul>
			
			</div>
			<div class="modal-body">
				<div class="tab-content">
					<!-- TYPE -->
					<div role="tabpanel" class="tab-pane active" id="type">
						<input class="form-control" id="typeSign" type="text" value="<%=registration.getFirstName()%>  <%=registration.getLastname()%>"><br><br>
						 <div class="row" id="selectType">
						</div>
					</div>
					<!-- DRAW -->
					<div role="tabpanel" class="tab-pane" id="draw">
						<div class="tools">
						<a href="#colors_sketch" data-tool="marker">Marker</a> <a href="#colors_sketch" data-tool="eraser">
						Eraser</a>
						</div>
						<canvas id="colors_sketch" width="500" height="200"></canvas>
				<%-- 		<div class="sigPad" id="smoothed-variableStrokeWidth"
							style="width: 404px; margin-top: 10px;">
							<ul class="sigNav">
								<li class="clearButton"><a href="#clear">Clear</a></li>
							</ul>
							<div class="sig sigWrapper" style="height: auto;">
								<div class="typed"></div>
								<canvas class="pad" width="400" height="250" id="drawSignature"></canvas>
								<input type="hidden" name="output" class="output">
							</div>
						</div> --%>
					</div>
					<!-- UPLOAD -->
					<div role="tabpanel" class="tab-pane" id="upload">
						  <form id="update_sign">
					    	<div class="form-group">
							    <label for="exampleInputFile"></label>
							   <input type='file' name="fileimage" id="upload_sign" />
							    <p class="text-danger">Please upload your files(Support only .gif,jpg,jpeg and file size max 10MB) .</p>
							  </div>
						</form>
					<img id="show_update_sign" src="" height="300px" width="300px" />
					</div>
					<!-- MY SIGNATURE -->
					<!-- <div role="tabpanel" class="tab-pane" id="mysignature">
						<div class="row">
							<div class="col-lg-3 col-md-4 col-xs-6 thumb">
								<a class="thumbnail"> <img id="mySignature" class="img-responsive"
									src="data:image/png;base64,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" alt="">
								</a> 
							</div>
						</div>
					</div> -->
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" onclick="addSignature();" class="btn btn-primary">Add</button>
			</div>
		</div>
	</div>
</div>
<!-- POP UP BOX for  end here -->
 <!-- POP UP BOX for document start here -->
<div class="modal fade" id="fillandsign" role="dialog">
            <div class="modal-dialog modal-dialogK">
                <div class="modal-content modal-contentG">
                  <div class="modal-header modal-headerH">
                     <div class="col-xs-12 col-sm-8 col-md-8">
                  		 <div >
                             <div id="error-alert" class="alert alert-danger fade in  hidden"  style="text-align:center;margin: 0px;" role="alert">
						     <button type="button" class="close" data-dismiss="alert" aria-label="Close">    
						        <span aria-hidden="true">&times;</span>
						     </button> 
						     <span id="errorMsg"></span>
						    </div>
                        </div> 
                     </div>
                     <div class="col-xs-12 col-sm-4 col-md-4">
                        <div class="row">
                           <div class="col-xs-12 col-sm-6 col-md-6">
                              <a  class="col-xs-12 btn btn-styleHG" data-dismiss="modal">Close</a>
                           </div>
                           <div class="col-xs-12 col-sm-6 col-md-6">
                              <a  class="col-xs-12 btn btn-styleHG" onclick="saveSelfSignPDFData();">Save & Close</a>
                            </div>
                        </div>
                     </div>
                     <!-- <button type="button" class="close closeJ" data-dismiss="modal">&times;</button> -->
                  </div>
                  <div class="modal-body modal-bodyZ">
             		 <div class="row">
                      <div class="col-xs-12 col-sm-8 col-md-9 text-center divAA">
                         <div style="background-color:#fff;overflow:auto;height:600px;" class="rederpdf">
                            
                         </div>
                      </div>
                      <div class="col-xs-12 col-sm-2 col-md-2 modalX">
                 			<div class="col-sm-12 shape" id="draggable1">
                 			<p class="text-center"><strong>Fields Available</strong></p>
					<div id="signer-1" class="col-sm-6 col-sm-6 dragMe dragSigners drgfields" style="padding:0px;"
						data-signer-id="1" data-document-id="1">
						<span class="col-xs-12 btn btn-style1">Name</span> <!-- <span class="closeIt hideIt">x</span> -->
					</div>
				
					<div id="signer-2" class="col-sm-6 col-sm-6 dragMe dragSigners drgfields" style="padding:0px;"
						data-signer-id="2" data-document-id="1">
						<span class="col-xs-12 btn btn-style1">Date</span> <!-- <span class="closeIt hideIt">x</span> -->
					</div>
				
					<div id="signer-3" class="col-sm-6 col-sm-6 dragMe dragSigners drgfields" style="padding:0px;"
						data-signer-id="3" data-document-id="1">
						<span class="col-xs-12 btn btn-style1">Signature</span> <!-- <span class="closeIt hideIt">x</span> -->
					</div>
	 	 		   </div>
              </div>
            </div>
         </div>
       </div>
   </div>
</div>
<script type="text/javascript" src="<%=serverUrl %>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=serverUrl %>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=serverUrl %>/js/additional-methods.js"></script>
<script src="<%=serverUrl %>/js/uploadfile.js"></script>
<script>
$(document).ready(function() {
	var options = {
	        beforeSend : function() {
	                $("#progressbox").show();
	                $("#progressbar").width('0%');
	                $("#groupsignsuccessalert").hide();
	    			$("#groupsignalert").hide();
	                $("#groupsignsendmsg").html("");
	                $("#groupsignsendsuccessmsg").html("");
	                $("#percent").html("0%");
	                $("#groupsignuploadpopupalert").hide();
	                $("#groupsignuploadpopupmessage").html("");
	                
	       },
	        uploadProgress : function(event, position, total, percentComplete) {
	                $("#progressbar").width(percentComplete + '%');
	                $("#percent").html(percentComplete + '%');
	                // change message text to red after 50%
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
		        		$('#uploadFileModel').modal('hide');
		        		$('body').removeClass('modal-open');
		        		$('.modal-backdrop').remove();
		        		$('#hideshow').css('pointer-events','none');
		        		$("#prepare_and_sign").prop('disabled', false);
		        		$("#ajaxuploadedfile").html('<div class="inner-addon left-addon"><i class="glyphicon icon-doc-pdf"></i><input type="text" class="form-control input-lg" placeholder="'+obj.fileName+'"><a href="javascript:delteAjaxUploadFile('+obj.fileId+',\''+obj.fileName+'\')" ><span class="icon-circle-x closy"></span></a></div>');
		        		responseMessage = obj.message;
		        		$("#groupsignsuccessalert").show();
		    			$("#groupsignalert").hide();
		    			$("#groupsignsendsuccessmsg").html(responseMessage);
		    			$("#groupsignuploadpopupalert").show();
		    			$("#groupsignuploadpopupmessage").html(responseMessage);
		        	}else if(obj.status == 'E'){
		        		responseMessage = obj.message;
		        		$("#groupsignsuccessalert").hide();
		        		$("#prepare_and_sign").prop('disabled', true);
		        		$("#groupsignalert").show();
		    			$("#groupsignsendmsg").html(responseMessage);
		    			$("#groupsignuploadpopupalert").show();
		    			$("#groupsignuploadpopupmessage").html(responseMessage);
				 	}else{
		        		responseMessage = obj.message;
		        		$("#groupsignsuccessalert").hide();
		        		$("#prepare_and_sign").prop('disabled', true);
		        		$("#groupsignalert").show();
		    			$("#groupsignsendmsg").html(responseMessage);
		    			$("#groupsignuploadpopupalert").show();
		    			$("#groupsignuploadpopupmessage").html(responseMessage);
		        	}
	        },
	        complete : function(response) {
	       },
	        error : function() {
        		$("#groupsignsuccessalert").hide();
    			$("#groupsignalert").show();
    			$("#groupsignsendmsg").html("ERROR: unable to upload files");
	        }
	};
	$('#sendEmail').prop('disabled', true);
	$("#UploadForm").ajaxForm(options);
	 jQuery.validator.addMethod("multiemail", function (value, element) {
	        if (this.optional(element)) {
	            return true;
	        }
	        var emails = value.split(','),
	            valid = true;
	        for (var i = 0, limit = emails.length; i < limit; i++) {
	            value = emails[i];
	            valid = valid && jQuery.validator.methods.email.call(this, value, element);
	        }
	        return valid;
	  }, "Please separate email addresses with a comma and do not use spaces.");


	
	$("#form1").validate({
		 errorElement:'div',
     	rules: {
     	recipient: {
     		required: true,
     	    multiemail:true,
     		},
     	cc:{
     		 multiemail:true
     	},	
     	title :"required",
     	message:"required"
     	
     },
     messages: {
    	 recipient:{
    		 required: "Please enter a valid recipient's email ID."
    	 },
    	 title:{
    		 required: "Please enter the Subject." 
    	 },
    	 message:{
    		 required: "Please enter a message for the recipient." 
    	 }
     }
 	})

}); 
function delteAjaxUploadFile(fileId,fileName)
{
	$("#groupsignsuccessalert").hide();
	$("#groupsignalert").hide();
	$("#groupsignsendmsg").html("");
	$("#groupsignsendsuccessmsg").html("");
	$("#groupsignuploadpopupalert").hide();
	$("#groupsignuploadpopupmessage").html("");
 	$.ajax({
		type : "POST",
		url : "deleteajaxuploadeddocument",
	    data: {'fileId':fileId,'fileName':fileName},
        success : function(response) {
        	if(response==1){
        		$("#prepare_and_sign").prop('disabled', true);
        		$("#UploadForm").show();
        		$("#ajaxuploadedfile").html("");
        		$('#groupfilename').html("");
        		$('#groupfileid').html("");
        		$('#percent').html("");
        		$('#myfile').val("");
        		$('#groupfilename').val("");
        		$('#signerjsondata').val("");
        		$('#fieldshtml').val("");
        		$('#hideshow').css('pointer-events','all');
    			$("#groupsignsuccessalert").show();
    			$("#groupsignalert").hide();
    			$("#groupsignsendsuccessmsg").html("File successfully deleted");
    			$('#prepare_and_sign').text('PREPARE & SIGN');
        	}else{
        		$("#prepare_and_sign").prop('disabled', false);
        		$("#groupsignsuccessalert").hide();
    			$("#groupsignalert").show();
    			$("#groupsignsendmsg").html("Error in File deletion.");
		  	}
		}
	}); 
}

function readTr(fileID){ 
	var groupfilename = $('#groupfilename').val();
	var groupfileid = fileID;//$('#groupfileid').val();
	var url = '?fileid='+groupfileid+'&fname='+escape(groupfilename)+'';
	if(groupfilename !="" || groupfilename.trim() !=""){
		var ext = groupfilename.split('.').pop();
		if(ext == "pdf"){
			$('#fillandsign').one('show.bs.modal', function(e) {
				$(e.currentTarget).find('.rederpdf').load('viewselfsign'+url);
			});
			$("#fillandsign").modal('show');
		}
		
		setTimeout(function(){
			$("#document-reader").append($("#fieldshtml").val());
		},1000);
	}
}
var x;
var y ;
$(document).ready(function(){
    $('.nav-tabs a').on('shown.bs.tab', function(event){
         x = $(event.target).text();         // active tab
         y = $(event.relatedTarget).text();  
    });
});

function modalPopBox(value){
	$("#imageField").val(value);
	$('#myModal').modal('show');
}

function addSignature(){
	var text;
	var fieldValue=$("#imageField").val();
	var val="";
	if(x=="My Signature") {  //my signature 
		var sign = document.getElementById('mySignature');
		dataURL = sign.getAttribute('src');
		sign.setAttribute('src', dataURL);
		$('#myModal').modal('hide');
		val= $("#field"+fieldValue).attr('src', dataURL);	
	}else
	if(x=="Upload") {  //upload 
		var sign = document.getElementById('show_update_sign');
			dataURL = sign.getAttribute('src');
			sign.setAttribute('src', dataURL);
		$('#myModal').modal('hide');
		val=$("#field"+fieldValue).attr('src', dataURL);
	}else
	if(x=="Draw"){  //draw 
		text = $('#colors_sketch')[0].toDataURL();
		dataURL = text;
		$('#myModal').modal('hide');
		val=$("#field"+fieldValue).attr('src', dataURL);	
	}else
	{  //draw 
		var dataURL = $("#myType").val();
		$('#myModal').modal('hide');
		val=$("#field"+fieldValue).attr('src', dataURL);	
	}
	
}
function saveSelfSignPDFData(){
	var contextPath=$("#contextPath").val();
	var generatorLength=$("#generator").val();
	
	var fileName=$("#groupfilename").val();
	var fileid=$("#groupfileid").val();
	$("#errorMsg").val('');
	$("#error-alert").addClass('hidden');
	if(generatorLength ==1){
		$("#error-alert").toggleClass("hidden");
		$("#errorMsg").html('Assign at least one field to yourself.');
		return false;
	}
	var jsonArray = [];
	for(var i=1; i<generatorLength; i++) {
		var item = {}
		    var fieldType=$("#field"+i).attr("type");
			if(fieldType!=null || fieldType!=undefined ){
				item ['docId'] =fileid; 
				item ['documentName'] = fileName;
				item ['top'] =$('#fieldPosition'+i).css("top")
				item ['left'] = $('#fieldPosition'+i).css("left")
				item ['fieldType'] = $("#field"+i).attr("type");
				item ['fieldName'] = $("#field"+i).attr("name");
				if($('#field'+i).val()=="" || $('#field'+i).val()==undefined ){
					if($("#field"+i).attr("type") == 'text'){
						$("#error-alert").toggleClass("hidden");
						$("#errorMsg").html('Enter name of signee.');
					}
					if($("#field"+i).attr("type") == 'date'){
						$("#error-alert").toggleClass("hidden");
						$("#errorMsg").html('Enter a date.');	
					}
					return false;
				}
				item ['fieldValue'] = $('#field'+i).val();
				item ['pageNumber'] = 1;  //handle page number coding in java
				item ['userId'] = 1;  
			}else{
				item ['docId'] =fileid;
				item ['documentName'] = fileName;
				var sign = document.getElementById('field'+i);
				var signature = sign.getAttribute('src');
				item ['top'] =$('#fieldPosition'+i).css("top")
				item ['left'] = $('#fieldPosition'+i).css("left")
				item ['fieldType'] = "image";
				item ['fieldValue'] = signature;
				if(item ['fieldValue'] == 'images/blue.jpg' || item ['fieldValue']==undefined){
					$("#error-alert").toggleClass("hidden");
					$("#errorMsg").html('Choose signature for the selected signee.');
					return false;	
				}
				item ['pageNumber'] = 1; //handle page number coding in java
				item ['userId'] = 1;  
			}
		jsonArray.push(item);
	}
	$("#jsonPDFData").val(JSON.stringify(jsonArray));
	$('#fillandsign').modal('hide');
	
	//start edit groupsign fields
	$("#fieldshtml").val("");
	var fieldsHTML = "";
	$("#document-reader > .dragMe").each(function() {
		fieldsHTML += $(this).prop("outerHTML");
	});
	$("#fieldshtml").val(fieldsHTML);
	$('#prepare_and_sign').text('RE-EDIT & SIGN');
	$('#sendEmail').prop('disabled', false);
	console.log(fieldsHTML);
	//end edit groupsign fields
	console.log("jsonArray Selfsign ---- "+JSON.stringify(jsonArray));
}

function saveSelfSign(){
	var valid = $("#form1").valid();
	if(valid == true){
	var contextPath=$("#contextPath").val();
	var jsonData=$("#jsonPDFData").val();
	var email=$("#email").val();
	var recipient=$("#recipient").val();
	var cc=$("#cc").val();
	var title=$("#title").val();
	var message=$("#emailsubject").val();
	var userId=$("#userId");

	console.log("jsonArray Object ---- "+JSON.stringify(jsonData));
	
	$.ajax({
		type : "POST",
		url : "ajax/saveSelfSign?email="+email+"&recipient="+recipient+"&cc="+cc+"&title="+title+"&message="+message+"&userId="+userId,
		dataType: 'json',
	    contentType: "application/json; charset=utf-8",
	    data: jsonData,
	    beforeSend: function () {
   			$("#groupsignsuccessalert").show();
			$("#groupsignalert").hide();
			$("#groupsignsendsuccessmsg").html("progress..");
	    },
	    complete: function () {
	    },
        success : function(response) {
         	if(response == '"success"'){
            	$("#hide_row").hide();
            	$("#groupsignsuccessalert").show();
				$("#groupsignalert").hide();
				var msg="You have successfully signed the document.Please check the status in Completed Documents section ";
    			$("#groupsignsendsuccessmsg").html(msg);
    				
            }else{
            	$("#groupsignsuccessalert").hide();
    			$("#groupsignalert").show();
    			var msg="There is network problem while saving document.";
    			$("#groupsignsendmsg").html(msg);
            }
		},
		 error : function(e) {  
		    alert('Error: ' + e);   
		}  
	 });
   }	
}


</script>
<script type="text/javascript">
    $(function () {
        $('#colors_sketch').sketch();
        $(".tools a").eq(0).attr("style", "color:#000");
        $(".tools a").click(function () {
            $(".tools a").removeAttr("style");
            $(this).attr("style", "color:#000");
        });
        $("#btnSave").bind("click", function () {
            var base64 = $('#colors_sketch')[0].toDataURL();
            $("#imgCapture").attr("src", base64);
            $("#imgCapture").show();
        });
    });
</script>
<input type="hidden" id="groupfilename" name="groupfilename" />
<input type="hidden" id="groupfileid" name="groupfileid" />
<input type="hidden" id="envelopeid" name="envelopeid" />
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="fieldshtml" value="" />
   </body>
</html>