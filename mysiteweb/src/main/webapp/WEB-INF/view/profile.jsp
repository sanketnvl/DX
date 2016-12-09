
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="com.myexample.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>


<% Authentication auth = SecurityContextHolder.getContext().getAuthentication(); %>
<% Registration registration = (Registration)auth.getPrincipal(); %>
<% 
String fileName="user.png";
String picFlag="0";
if(registration.getPhoto() != null) 
	{
		fileName = registration.getPhoto();
		picFlag = "1";
	}
String picPath = "images/profile/"+fileName;
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
 <jsp:include page="header.jsp" />
 	  <script src="<%=appUrl %>/js/signaturepopup.js"></script> 
	  <link rel="stylesheet" href="<%=appUrl %>/css/signaturepopup.css">
	  	<script src="<%=appUrl %>/js/groupsign.js"></script>
	  <input type="hidden" id="imageField" value=""/>
<input type="hidden" id="fieldLength" value=""/>
<input type="hidden" id="myType" value="asd"/>
<input type="hidden" id="initial" value="0.0"/>
               <!-- Page Header -->
               <div class="row" style="background:#CCCCCC;">
                  <div class="col-lg-3">
                     <h3 class="page-header">Profile</h3>                    
                  </div>
                  <div class="profilealertclass col-lg-5">
				   		
					  	<div class="alert alert-success" style="display:<c:choose><c:when test="${not empty updateStatus}">block</c:when><c:otherwise>none</c:otherwise></c:choose>">
					    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
					    	<span class="alert fade in" >Your profile has been updated successfully.</span>
					  	</div> 
					  	
			   		</div>
               </div>
               <!-- /.row -->
               <!-- Projects Row -->
               <div class="row rowpad PadP">
                  <div class="col-xs-12 col-sm-4 col-md-4" style="background:#ffffff;margin:0 5px;">
                     <div class="row" style="padding-top:20px;">
                        <div class="here">
                           <div class="here-bottom">
                           	 
                              <div class="show-image">
                              <img  src="<%=picPath %>" height="auto" width="160px" alt="" style="border-radius: 78px;">
                              
                              </div>
                               <h4 style="color:#4C88C7;padding-top:10px;">
		                           <% if (registration != null) { %>
							 		<%=registration.getFirstName()%> 
								   <% } %> 
                           </h4>
                             <!--  <h6 style="color:#4C88C7;">Art Director</h6> -->
                           </div>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-md-12 text-center">
                        <% if(picFlag.equals("1")){ %>
                              	<!-- <input class="deletepic"  data-toggle="modal" data-target="#deletepicprompt" type="button" value="X" /> -->
                              	<h6><a  class="hyper_link" data-toggle="modal" data-target="#deletepicprompt" href="#"><u>Delete Pic</u></a></h6>
                              <% } %>
                              
                           <h6><a  class="hyper_link" data-toggle="modal" data-target="#changepicModel" href="#"><u>Change Pic</u></a></h6>
                        <h6><a  class="hyper_link" data-toggle="modal" data-target="#changepwdModel" href="#"><u>Change Password</u></a></h6>
                        </div>
                     </div>
                     <div class="divider"></div>
                     <div class="row" style="padding-top:50px;">
                        <div class="row">
                           <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                              <div style="font-size:16px;"><a ><span class="icon-mail" style="font-size:18px;"></span>&nbsp;&nbsp; 
							<% if (registration != null) { %>
							 		<%=registration.getEmail()%> 
								   <% } %> 
&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
                           </div>
                        </div>
                       <!--  <div class="row" style="padding-top:10px;">
                           <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                              <div style="font-size:16px;margin-bottom:50px;"><a href="#"><span class="icon-attachment"></span>&nbsp;&nbsp; example@mail.com&nbsp;&nbsp;&nbsp;&nbsp;<span class="icon-pins"></span></a></div>
                           </div>
                        </div> -->
                     </div>
                  </div>
                  <div class="col-xs-12 col-sm-7 col-md-7" style="background:#ffffff;margin:0 5px;">
                  
                  
                  
                  
                  
                  
                  
                  
                     <div class="row" style="padding-top:20px;">
                        <div class="col-xs-12 col-sm-12 col-md-10 col-md-offset-1" style="margin-top:10px;">
                        
                        
                        
                           <form:form name="profile" action="profile" method="POST" class="login-form" role="form">
                           <div class="form-group">
                              <label class="" for="form-username">First Name*</label>                        
                              <form:input path="firstName" value="${firstName}" placeholder="First Name" class="form-username form-control"/>
    						  <form:errors path="firstName" class="sperrors"  />
                           </div>
                           <div class="form-group">
                              <label class="" for="form-username">Last Name*</label>
                              <form:input path="lastname" value="${lastname}" placeholder="Last Name" class="form-username form-control" />
    						  <form:errors path="lastname" class="sperrors"  />     
                           </div>
                           
                           <div class="form-group">
                              <label class="" for="form-username">Phone*</label>
                              <form:input path="phone" value="${phone}" placeholder="phone" class="form-username form-control" />
    						  <form:errors path="phone" class="sperrors"  />     
                           </div>
                           
                           <div class="form-group">
                              <label class="" for="form-username">Country*</label>
                              <form:input path="country" value="${country}" placeholder="country" class="form-username form-control" />
    						  <form:errors path="country" class="sperrors"  />     
                           </div>
                           
                            <div class="form-group">
                              <label class="" for="form-username">State*</label>
                              <form:input path="state" value="${state}" placeholder="state" class="form-username form-control" />
    						  <form:errors path="state" class="sperrors"  />     
                           </div>
                           
                            <div class="form-group">
                              <label class="" for="form-username">PinCode*</label>
                              <form:input path="pincode" value="${pincode}" placeholder="pincode" class="form-username form-control" />
    						  <form:errors path="pincode" class="sperrors"  />     
                           </div>
                           
                           
                           <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
 							
 							<input name="submit" type="submit" value="Update" class="btn btn-primary"  role="button">                       
                        </form:form>
                        
                        
                        
                        
                        
                        
                        
                        </div>
                     </div>
                    
                     <div class="row" style="padding-top:20px;">
                        <div class="divider"></div>
                        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My Signatures </h4>
                         <div class="col-xs-12 col-sm-12 col-md-12">
                           <button data-toggle="modal" data-target="#createsignature" id="addScnt" class="form-control" value="Add Signee" style="width: 212px;" onclick="clearmessages()">Create Signature</button>
                         </div>
                         
                         
                        <div class="divider"></div>
                     </div>
                     <div class="row" style="padding-top:20px;">
						<c:choose>
						    <c:when test="${not empty signatures}">
						       
						       <c:forEach items="${signatures }" var="sign">
		                     		<div class="col-xs-12 col-sm-6 col-md-6 text-center signaturewrapper" id="signaturewrapper${sign.id}">
		                           		<img src="${sign.sign}" style="padding:15px;" alt="Cinque Terre" width="100%" height="100px"><a onclick="deletesign(${sign.id})"  class="deletesign">X</a>	
		                        	</div>
		                     	</c:forEach>
						             
						    </c:when>
						    <c:otherwise>
						       There is no signatures available.
						    </c:otherwise>
						</c:choose>                      
                     	
                        
                        <!-- <div class="col-xs-12 col-sm-6 col-md-6 text-center">
                           <img src="images/Group_33.png" style="padding:15px;" alt="Cinque Terre" width="100%" height="auto">	
                        </div> -->
                     </div>
                  </div>
                  <!-- /.row -->
                  <!-- Modal pic -->
                  <div class="modal fade" id="changepicModel" role="dialog">
                     <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Change Your Profile Picture </h4>
                           </div>
                           <div class="modal-body">
                              <form class="form-horizontal" role="form" id="changeprofilepicture" action="changeprofilepic" method="post" enctype="multipart/form-data">
                                 <div class="form-group">
                                    <div class="col-xs-12">
                                       <input type="file" class="form-control" id="profilepic" name="profilepic" placeholder="Profile Pic"/> 
                                       <!-- <input type="submit" value="Save"> -->
                                    </div>
                                 </div>
                              </form>
                           </div>
                           <div class="modal-footer">
                           	  <!-- <div id="progressbar"></div>
         					  <div id="percent">0%</div> -->
         					  <div class="col-xs-12">
				  					<div class="alert alert-danger fade in col-xs-12" style="display:none;text-align: center;" id="changepicmessageerroralert">
										<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
										<div id="changepicmessageerror"></div>
								   	</div>
								   	<div class="alert alert-success" style="display:none;text-align: center;" id="changepicmessagesuccessalert">
								    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
								    	<div id="changepicmessage"></div>
								  	</div>                           
			                   </div>
                           	  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                              <button type="button" class="btn btn-primary" onclick="$('form#changeprofilepicture').submit();" >Save</button>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="modal fade" id="changepwdModel" role="dialog">
                     <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                           <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Change Your Password </h4>
                           </div>
                           <div class="modal-body">
                              <form class="form-horizontal" role="form">
                                 <div class="form-group">
                                    <div class="col-xs-12">
                                       <input type="password" class="form-control" id="oldpassword" placeholder="Old Password"/>
                                    </div>
                                 </div>
                                 <div class="form-group">
                                    <div class="col-xs-12">
                                       <input type="password" class="form-control" id="newpassword" placeholder="New Password"/>
                                    </div>
                                 </div>
                                 <div class="form-group">
                                    <div class="col-xs-12">
                                       <input type="password" class="form-control" id="confirmpassword" placeholder="Confirm Password"/>
                                    </div>
                                 </div>
                              </form>
                           </div>
                           <div class="modal-footer">
                           		<div class="col-xs-12">
				  					<div class="alert alert-danger fade in col-xs-12" style="display:none;text-align: center;" id="changepwdmessagealert">
										<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
										<div id="changepwdmessage"></div>
								   	</div>
								   	<div class="alert alert-success" style="display:none;text-align: center;" id="changepwdmessagealertsuccess">
								    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
								    	<div id="changepwdmessagesuccess"></div>
								  	</div>                           
			                   </div>
			                   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                           <button type="button" class="btn btn-primary" onclick="changePassword()" >Save</button>
                           </div>
                        </div>
                     </div>
                  </div>
                  
                  
<div class="modal fade" id="createsignature" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index:100000;">
<div class="modal-dialog" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				 <li role="presentation" class="active"><a href="#type" aria-controls="home" role="tab" data-toggle="tab">Type</a></li> 
				 <li role="presentation"><a href="#profile"
					aria-controls="profile" role="tab" data-toggle="tab">Draw</a></li>
				 <li role="presentation"><a href="#messages"aria-controls="messages" role="tab" data-toggle="tab">Upload</a></li>
				
			</ul>
		</div>
		<div class="modal-body">
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="type">
					<input class="form-control" id="typeSign" type="text" value="<%=registration.getFirstName()%>  <%=registration.getLastname()%>"><br><br>
					<input type="hidden" id="generator" value="1" />
					 <div class="row" id="selectType">
						
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="profile">
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
							<canvas class="pad" width="400" height="250" id="can"></canvas>
							<input type="hidden" name="output" class="output">
						</div>
					</div> --%>

				</div>
				<div role="tabpanel" class="tab-pane" id="messages">
				    <form id="update_sign">
				    	<div class="form-group">
						    <label for="exampleInputFile"></label>
						   <input type='file' name="fileimage" id="upload_sign" />
						    <p class="text-danger">Please upload your files(Support only .gif,jpg,jpeg and file size max 10MB) .</p>
						  </div>
					</form>
					<img id="show_update_sign" src="" height="300px" width="300px" />
				</div>
				
			</div>
		</div>
		<div class="modal-footer">
			<div class="groupsigneralertclass fulllength col-lg-4">
	                   <div class="alert alert-danger fade in " style="display:none;" id="savesignerror">
							<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
							<span class="alert fade in" id="savesignerrormsg"></span>
				   		</div>
					  	<div class="alert alert-success" style="display:none;" id="savesignsuccess">
					    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
					    	<span class="alert fade in" id="savesignsuccessmsg"></span>
					  	</div> 
			</div>
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" onclick="saveMySignature();" class="btn btn-primary">Save</button>
			</div>
		</div>
	</div>
</div>
 
 
 
 
 <div class="modal fade" id="deletepicprompt" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index:100000;">
<div class="modal-dialog" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<h4 class="modal-title">Are you sure want to delete?</h4>
			
		</div>
		
		<div class="modal-footer">
			
			<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			<button type="button" onclick='deleteProfilePic("<%=picPath %>")' class="btn btn-primary">Delete</button>
			</div>
		</div>
	</div>
</div>
                  
                  
<jsp:include page="footer.jsp" />
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/additional-methods.js"></script>
<script src="<%=appUrl %>/js/uploadfile.js"></script>
      <script>
      $("#asd").change(readImage);
      
         $( document ).ready(function() {
         $(".profile").click(function(){
         $(".profile").find(".profile_pic").find(".img-circle").css("background","#FDB551");
         $(".profile_info").find("span").css("color","#FDB551");
         });
         });
         
         function changePassword(){
        	 
        	 $("#changepwdmessagealert").hide();
        	 $("#changepwdmessagealertsuccess").hide();
        	 var oldpassword = $('#oldpassword');
        	 var newpassword = $('#newpassword');
        	 var confirmpassword = $('#confirmpassword');
        	 
        	 if(oldpassword.val() != "" && oldpassword.val().trim() != "")
        	 {
        		 
        		 $("#changepwdmessage").html("");
        	 }else{
        		 oldpassword.focus();
        		 $("#changepwdmessagealert").show();
        		 $("#changepwdmessage").html("Enter Old password");
        		 return false;
        	 }
 
        	 
        	 if(newpassword.val() != "" && newpassword.val().trim() != "")
        	 {
        		 
        		 $("#changepwdmessage").html("");
        	 }else{
        		 newpassword.focus();
        		 $("#changepwdmessagealert").show();
        		 $("#changepwdmessage").html("Enter New password");
        		 return false;
        	 }

        	 
        	 if(confirmpassword.val() != "" && confirmpassword.val().trim() != "")
        	 {
        		 
        		 $("#changepwdmessage").html("");
        	 }else{
        		 confirmpassword.focus();
        		 $("#changepwdmessagealert").show();
        		 $("#changepwdmessage").html("Enter Confirm password");
        		 return false;
        	 }
        	 
        	 
        	 if(newpassword.val() == confirmpassword.val()){

        		 $("#changepwdmessage").html("");
        	 }else{
        		 $("#changepwdmessagealert").show();
        		 $("#changepwdmessage").html("The New and Confirm password are not matching.");
        		 return false;
        	 }
        	 

                 $.ajax({
                     type : "POST",
                     url : "changepassword",
                     data : {"oldpassword":oldpassword.val().trim(),"newpassword":newpassword.val().trim(),"confirmpassword":confirmpassword.val().trim()},
                     beforeSend : function() {
                    	 $("#changepwdmessage").html("loading..");
                     },
                     complete: function () {
                    	 //$("#changepwdmessage").html("");
                     },
                     success : function(response) {
                    	 if(response == 1){
                    		 $("#changepwdmessagealert").hide();
                           	 $("#changepwdmessagealertsuccess").show();
                        	 $("#changepwdmessagesuccess").html("Your password has been changed successfully. ");                   		 

                    	 }else{
                    		 $("#changepwdmessagealertsuccess").hide();
                           	 $("#changepwdmessagealert").show();
                        	 $("#changepwdmessage").html(response);                   		 
                    	 }
 
                     }
                 });
         }
         
         
         //Change profile picture
$(document).ready(function() {
        			var options = {
        			        beforeSend : function() {
        			                $("#progressbox").show();
        			                // clear everything
        			                $("#progressbar").width('0%');
        			                $("#message").empty();
        			                $("#percent").html("0%");
        			        },
        			        uploadProgress : function(event, position, total, percentComplete) {
        			                $("#progressbar").width(percentComplete + '%');
        			                $("#percent").html(percentComplete + '%');

        			                // change message text to red after 50%
        			                if (percentComplete > 50) {
        			                $("#changepicmessage").html("<font color='red'>File Upload is in progress</font>");
        			                }
        			        },
        			        success : function(response) {
        			        	console.log(response);
        			        	var obj = JSON.parse(response);
        			        	if(obj.status == 'S'){
        			        		$('#groupfilename').val(obj.fileName);
        			        		$('#groupfileid').val(obj.fileId);
        			        		$("#UploadForm").hide();
        			        		
        			        		$("#changepicmessageerroralert").hide();
        			        		$("#changepicmessagesuccessalert").show();
        			        		$("#changepicmessage").html("Your profile picture has been changed.");
        			        		
        			        		setTimeout(function(){window.location.reload(1);}, 1000);
        			        	}else{
        			        		$("#changepicmessageerroralert").show();
        			        		$("#changepicmessagesuccessalert").hide();
        			        		$("#changepicmessageerror").html(obj.message);
        			        	}
        			        },
        			        complete : function(response) {
        			        	

        			        },
        			        error : function() { 
        			        	$("#changepicmessageerroralert").show();
    			        		$("#changepicmessagesuccessalert").hide();
    			        		$("#changepicmessageerror").html(responseMessage);
        			        }
        			};
        			
        			$("#changeprofilepicture").ajaxForm(options);
			

}); 
         
         function deletesign(signId)
         {
        	 
        	 $.ajax({
                 type : "POST",
                 url : "deletesignature",
                 data : {"signId":signId},
                 beforeSend : function() {
                	 $("#changepwdmessage").html("loading..");
                 },
                 complete: function () {
                	 //$("#changepwdmessage").html("");
                 },
                 success : function(response) {
                	 if(response == 1){
                		 $("#changepwdmessagealert").hide();
                       	 $("#profilealertclass").show();
                       	 $("#signaturewrapper"+signId).hide();
                    	 $("#profilealertclass").html("Your signature has been deleted successfully. ");                   		 
                    	 window.location.href = "";
                	 }else{
                		 $("#changepwdmessagealertsuccess").hide();
                       	 $("#changepwdmessagealert").show();
                    	 $("#changepwdmessage").html(response);                   		 
                	 }

                 }
             });
        	 
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

function clearmessages(){
	$("#savesignerror").hide();
	$("#savesignsuccess").hide();
	$("#savesignerrormsg").html("");
	$("#savesignsuccessmsg").html("");
}       
function saveMySignature(){
			$("#savesignerror").hide();
			$("#savesignsuccess").hide();
			$("#savesignerrormsg").html("");
			$("#savesignsuccessmsg").html("");
     		var text;
     		var fieldValue=$("#imageField").val();
     		var val="";
     		var dataURL;
     		if(x=="My Signature") {  //my signature 
     			var signId = $("#mysignatureflag").val();
     			var sign = document.getElementById('mySignature'+signId);
     			dataURL = sign.getAttribute('src');
     			sign.setAttribute('src', dataURL);
     			
     			val= $("#field"+fieldValue).attr('src', dataURL);
     			$("#field"+fieldValue).attr('data', dataURL);
     		}else
     		if(x=="Upload") {  //upload 
     			var sign = document.getElementById('show_update_sign');
     			dataURL = sign.getAttribute('src');
     			sign.setAttribute('src', dataURL);
     			val=$("#field"+fieldValue).attr('src', dataURL);
     			$("#field"+fieldValue).attr('data', dataURL);
     			$("#mysignatureflag").val("");
     		}else
     		if(x=="Draw"){  //draw 
     			text = $('#colors_sketch')[0].toDataURL();
     			dataURL = text;
     			val=$("#field"+fieldValue).attr('src', dataURL);
     			$("#field"+fieldValue).attr('data', dataURL);
     			$("#mysignatureflag").val("");
     		}else
     		{   
     			var dataURL = $("#myType").val();
     			//$('#createsignature').modal('hide');
     			val=$("#field"+fieldValue).attr('src', dataURL);
     			$("#field"+fieldValue).attr('data', dataURL);
     			$("#mysignatureflag").val(""); 
     			/* $("#savesignerror").show();
     			$("#savesignsuccess").hide();
     			$("#savesignerrormsg").html("Please select signature."); */
     		}

     		if(dataURL !=null)
     		{
     		
     			$.ajax({  
           	     type : "POST",   
           	     url : $("#contextPath").val()+"app/savesignature",   
           	     dataType: 'json',
           	     data: {"dataURL":dataURL},
           	     success : function(response) 
           	     {
           	    	$("#savesignerror").hide();
         			$("#savesignsuccess").show();
         			$("#savesignsuccessmsg").html("Signature has been saved successfully.");
         			setTimeout(function() {
         		   		$('#createsignature').modal('hide');
         		  		location.href="";
         			}, 2000);
         				
           	     },  
           	     error : function(e) {  
           	      alert('Error: ' + e);   
           	     }  
           	    });  	
     		}     		
}       


	function deleteProfilePic(picName)
	{ 	
		$.ajax({  
      	     type : "POST",   
      	     url : $("#contextPath").val()+"app/deleteprofilepic",
      	     data: {"picName":picName},
      	     success : function(response) 
      	     {
      	    	 if(response == 1)
      	    	 {
      	    		location.href="";	 
      	    	 }
      	    	
      	     },  
      	     error : function(e) {  
      	      alert('Error: ' + e);   
      	     }  
      	    });  	
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
      