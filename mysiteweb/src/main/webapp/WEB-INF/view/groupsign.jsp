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
.popover-title {
    padding: 0 !important;
    }
    .popover-content{
     padding: 0 !important;
    }
    .popoversignerclass{ 
     padding: 10px !important;
    }
    .buttons, button, .btn {
    	margin-bottom: 5px;
	}
  /*   .popover.right>.arrow {
    left: 1px !important;
    } */
   .btNNCross{
       border: 1px solid #ccc;
    	border-radius: 0;
   }

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
      .alert {padding: 7px;margin: 13px;}
      
      .ui-sortable tr {
	cursor:pointer;
}
		
.ui-sortable tr:hover {
	background:rgba(244,251,17,0.45);
}
.shape {
    width: 100%;
}
.input-lg {
font-size: 11px !important;
    }
.closy {
    left: 14px;
    }
input[type=checkbox], input[type=radio] {
    margin-top: 1px\9;
    width: 35px;
    height: 34px;
    /* cursor: pointer; */
    /* -webkit-appearance: none; */
    appearance: none;
    margin: 0;
}
@media (min-width: 992px)
.col-md-10 { width: 91.333333% !important;}
      

/* end only demo styles */

.checkbox-custom, .radio-custom {
    opacity: 0;
    position: absolute;   
}

.checkbox-custom, .checkbox-custom-label, .radio-custom, .radio-custom-label {
    display: inline-block;
    vertical-align: middle;
    margin: 5px;
    cursor: pointer;
}

.checkbox-custom-label, .radio-custom-label {
    position: relative;
    left: -4px;
    top: -6px;
}

.checkbox-custom + .checkbox-custom-label:before, .radio-custom + .radio-custom-label:before {
    content: '';
    background: #fff;
    border: 1px solid #ccc;
    display: inline-block;
    vertical-align: middle;
    width: 35px;
    height: 35px;
    /* padding: 2px; */
    /* margin-right: 10px; */
    text-align: center;
}

.checkbox-custom:checked + .checkbox-custom-label:before {
    content: "\f00c";
    font-family: 'FontAwesome';
    color: #ccc;
    padding: 4px 0px;
    font-size: 17px;
}

.radio-custom + .radio-custom-label:before {
    border-radius: 50%;
}

.radio-custom:checked + .radio-custom-label:before {
    content: "\f00c";
    font-family: 'FontAwesome';
    color: #bbb;
}

.checkbox-custom:focus + .checkbox-custom-label, .radio-custom:focus + .radio-custom-label {
  outline: 1px solid #ddd; /* focus style */
}

.icon-span-filestyle{display:none;}

</style>
               <!-- Page Header -->
               <div class="row" style="background:#CCCCCC;">
                  <div class="col-lg-3">
                     <h3 class="page-header">Group Sign</h3>
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
               <div class="row rowpad groupDiv">
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
                        		<span id="showSteps" style="margin-left:-12px;"><strong>Step 3</strong>: Prepare and Sign</span>
	                   		 </h4>
	                   		 <br>
						   </div>     
                     
                     <div class="col-xs-12 col-sm-12 col-md-12" style="background-color:#F1EFF0;border:1px solid #ccc;padding: 14px 1px 42px 0px;">
                     	
                     
                                 <div class="row ">
                       		 
                         <div class="col-xs-12 col-sm-12 col-md-12">
                         	
                         		<div class="btn col-xs-12 col-sm-12 col-md-8 col-md-offset-2" style="margin-top:10px;">
                        		<div id="message"></div>
								<div id ="ajaxuploadedfile"></div>	
								</div>
							
								<button type="button" class="btn btn-style2 col-xs-12 col-sm-12 col-md-8 col-md-offset-2" style="width: 255px;margin:2px 78px" id="prepare_and_sign"  onclick="readTr(document.getElementById('groupfileid').value)" disabled>PREPARE & SIGN</button>
					
						</div>     
						                
                          
                        </div>
                        
                        </div>
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                  </div>
                  <div class="col-xs-12 col-sm-12 col-md-7 portfolio-item">
                     <h4 style="padding-left: 10px;">
                        <span><Strong>Step 2</Strong>: Signees required for this document</span>
                     </h4>
                     <br>
                     <div class="col-xs-12 col-sm-12 col-md-12">
                       
                           <fieldset>
                              <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-11">
                                       <input type="text" placeholder="INCLUDE ME" class="form-control " name="title" readonly />
                                    </div>
<!--                                      <input type="checkbox" name="self" id="selfsign" style="font-Size:33px;margin: 0px 3px;" checked /> 
 -->                                     
                                        <input id="checkbox-3" class="checkbox-custom" name="checkbox-3" type="checkbox" checked>
            							<label for="checkbox-3"class="checkbox-custom-label"></label>    
                                     <!-- <span class="icon-box" style="font-Size:33px;"></span> -->
                                    <!-- <div class="col-xs-2 col-sm-2 col-md-1">
                                    
                                       <span class="icon-box" style="font-Size:33px;"></span>
                                    </div> -->
                                    <!-- <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div> -->
                                 </div>
                              </div>
                              <div class="form-group">
                                <!--  <div class="row">
                                    <div class="col-xs-12 col-sm-6 col-md-6">
                                       <input type="text" placeholder="Name" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6 padHH">
                                       <input type="text" placeholder="email@example.com" class="form-control " name="title" />
                                    </div>
                                 </div> -->
								<div class="row">
							       <div class="col-xs-12 col-sm-6 col-md-6">
							          <input type="text" placeholder="<% if(registration !=null){ out.print(registration.getFirstName());} %>" id="selfname" class="form-control " name="name" value="<% if(registration !=null){ out.print(registration.getFirstName());} %>" readonly>
							       </div>
							       <div class="col-xs-12 col-sm-6 col-md-6 padHH">
							          <input type="text" placeholder="<% if(registration !=null){ out.print(registration.getEmail());} %>"  id="selfemail"  class="form-control " name="email" value="<% if(registration !=null){ out.print(registration.getEmail());} %>" readonly>
							       </div>
							    </div>
 
                              </div>
                              <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-11">
                                       <input type="text" placeholder="Group" class="form-control " name="title" readonly/>
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
<!--                                    <span class="icon-box" style="font-Size:33px;position: relative;left: -8px;top: -2px;"></span>

 -->     
   										<input id="checkbox-1" class="checkbox-custom" name="checkbox-1" type="checkbox" checked>
            							<label for="checkbox-1" style="left:-12px;" class="checkbox-custom-label"></label>                                   </div>
                                    <!-- <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div> -->
                                 </div>
                              </div>
                              <div class="form-group" id="signerslistdiv" >
                              
								<table class="table" id="signers_list">
							                <thead>
							                    <tr><th>Priority</th><th>Name</th><th>Email</th><th></th><th>&nbsp;</th></tr>
							                </thead>
							                <tbody id="p_scents">
							                
												<tr><td class='priority'>1</td><td><input class="form-control" type="text" id="name_1" name="name_1" placeholder="Name" /></td><td><input class="form-control " id="email_1" type="text" name="email_1" placeholder="Email" /></td><td><a class='btn btn-delete btNNCross'>X</a></td></tr>
											
							                </tbody>
							    </table>                              
                              
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                    <button id="addScnt" tabindex="" class="form-control" value="Add Signee" style="width: 158px;background-color: #5890CD;color: #fff;"  ><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add Signee</button>
                                      <!--  <input type="text" placeholder="Add more Signer" class="form-control " name="title" /> -->
                                    </div>
                                 </div>
                              </div>
                               
                              <div class="form-group">
                              <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">        
                                   <button  class="form-control" onclick="enableEdit()"  id="enableedit"  style="display:none;width: 158px;background-color: #5890CD;color: #fff;">Enable Edit Signers</button>
                                    
                                    </div>
                                 </div>
                              </div>
                              <!-- <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-5">
                                       <input type="text" placeholder="Name" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-8 col-sm-4 col-md-5 padHH">
                                       <input type="text" placeholder="email@example.com" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-5">
                                       <input type="text" placeholder="Name" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-8 col-sm-4 col-md-5 padHH">
                                       <input type="text" placeholder="email@example.com" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-5">
                                       <input type="text" placeholder="Name" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-8 col-sm-4 col-md-5 padHH">
                                       <input type="text" placeholder="email@example.com" class="form-control " name="title" />
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-x" style="font-Size:33px;"></span>
                                    </div>
                                 </div>
                              </div> -->
                              
                              
                              <h4><strong>Step 4:</strong> Add a subject and message for the recipient</h4><br>
								<form role="form" id="groupsignsendform">
									    <div class="form-group">
									    <div class="row">
									    <div class="col-xs-12 col-sm-12 col-md-12">
									      <input type="text" class="form-control" id="title" placeholder="Subject" name="grouptitle" />
									      <input type="hidden" id="signerjsondata" name="signerjsondata" />
									      <input type="hidden" id="groupfilename" name="groupfilename" />
									      <input type="hidden" id="groupfileid" name="groupfileid" />
									       <input type="hidden" id="envelopeid" name="envelopeid" />										  
									      <input type="hidden" id="grouploginuserid" name="grouploginuserid" value="<% if (registration != null) { out.print(registration.getId()); } %>" />
									      <input type="hidden" id="fieldshtml" />
									    </div>
									     </div>
									     </div>
									    <div class="form-group">
									       <textarea class="form-control" rows="8" id="groupsignmessage" placeholder="Message" name="groupmessage"></textarea>
									    </div>
										
										
										<div class="row">
                                 		<div class="col-xs-12 col-sm-4 col-sm-offset-6 col-md-4 col-md-offset-8">
										
									    	<button type="button" class="col-xs-12 btn btn-lg btn-primary" style="border-radius:0px;" onclick="groupSignSend()">Send</button>
									    	
									    </div>
                              			</div>
								</form>                              
                              
                              
                              
                             <!--  <div class="form-group">
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                       <input type="text" placeholder="Document Title" class="form-control " name="title" />
                                    </div>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <textarea rows="8" name="form-about-yourself" placeholder="Message(optional)" 
                                    class="form-control" id="form-about-yourself"></textarea>
                              </div>
                              <div class="row">
                                 <div class="col-xs-12 col-sm-4 col-sm-offset-6 col-md-4 col-md-offset-8">
                                    <a href="#" class="col-xs-12 btn btn-lg btn-primary">Send</a>
                                 </div>
                              </div> -->
                           </fieldset>
                       
                     </div>
                  </div>
              

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index:100000;">
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
				 <li role="presentation"><a href="#settings"
					aria-controls="settings" role="tab" data-toggle="tab">My Signature</a></li>
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
					<%-- <div class="sigPad" id="smoothed-variableStrokeWidth"
						style="width: 404px; margin-top: 10px;">
						<ul class="sigNav">
							<li class="clearButton"><a href="#clear">Clear</a></li>
						</ul>
						<div class="sig sigWrapper" style="height: auto;">
							<div class="typed"></div>
							<canvas class="pad" width="400" height="250" id="can"></canvas>
							<input type="hidden" name="output" class="output">
						</div>
					</div>
 --%>
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
				<div role="tabpanel" class="tab-pane" id="settings">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-6 thumb ">
						<input type="hidden" id="mysignatureflag" value=""/>
						
						<c:choose>
						    <c:when test="${not empty signatures}">
						       
						       <c:forEach items="${signatures }" var="sign">
		                     		<a class="thumbnail mysignaturethumbnail"> 
										<img id="mySignature${sign.id}" onclick="mySignatureGetId(${sign.id})" class="img-responsive" src="${sign.sign}" alt="">
									</a>
		                     	</c:forEach>
						             
						    </c:when>
						    <c:otherwise>
						       There is no signatures available.
						    </c:otherwise>
						</c:choose>     
						
						
							<!-- <a class="thumbnail"> 
							<img id="mySignature" class="img-responsive" src="data:image/png;base64,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" alt="">
							</a> 
							<a class="thumbnail"> 
							<img id="mySignature" class="img-responsive" src="data:image/png;base64,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" alt="">
							</a>  -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" onclick="addSignature();" class="btn btn-primary">Add</button>
			</div>
		</div>
	</div>
</div>
<!-- upload files model -->
 <div class="modal fade" id="uploadFileModel" role="dialog">
    <div class="modal-dialog">
       <!-- Modal content-->
       <div class="modal-content">
       
 <form id="UploadForm" action="ajaxupload" method="post" enctype="multipart/form-data">
          <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal">&times;</button>
             <h4 class="modal-title">Please select a file. </h4>
          </div>
          <div class="modal-body">
	 
	 
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-md-12">
			<input type="file" size="60" id="myfile" name="file" class="filestyle">
			<input type="hidden" name="signtype" value="G">
			<input type="hidden" id="loginuserid" name="loginuserid" value="<% if (registration != null) { out.print(registration.getId()); } %>" /> 
			 
		</div>
	</div>	 
    </div>
          <div class="modal-footer">
                 <div class="alert alert-danger fade in " style="display:none;text-align: center;" id="groupsignuploadpopupalert">
					<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
					<div id="groupsignuploadpopupmessage"></div>
		   		</div>
          
          	  
            <!--  <button type="button" class="btn btn-primary" onclick="changePassword()" >Save</button> -->
            <div class="col-xs-12 col-sm-2 col-md-2 pull-right padHH">
				<input type="submit" value="Save" class="form-control btn btn-primary">
			</div>
          </div>
          </form>	
       </div>
    </div>
 </div>
<div class="modal fade" id="fillandsign" role="dialog">
                  <div class="modal-dialog modal-dialogK">
                   
                     <div class="modal-content modal-contentG">
                        <div class="modal-header modal-headerH">
                           <div class="col-xs-12 col-sm-8 col-md-8">
                              <div >
                                 <div  role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:100%">
                                    <!-- <span class="sr-only">70% Complete</span> -->
                                    
					                   <div class="alert alert-danger fade in " style="display:none;text-align:center;margin: 0px;" id="groupsignpopupalert">
											<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
											<div id="allsignermust"></div>
								   		</div>
				                                    
                                    
									
											<div id="popover-content" class="hide">
												<select class="popoversignerclass" id="popoversigner" onchange="popoverDropdown(this)" ></select>
											</div>	                                    
                                 </div>
                              </div>
                           </div>
                           <div class="col-xs-12 col-sm-4 col-md-4">
                              <div class="row">
                                 <div class="col-xs-12 col-sm-6 col-md-6">
                                    <a  class="col-xs-12 btn btn-styleHG" data-dismiss="modal">Close</a>
                                 </div>
                                 <div class="col-xs-12 col-sm-6 col-md-6">
                                    <a  class="col-xs-12 btn btn-styleHG" onclick="popupSubmit()">Save & Close</a>
                                    <!-- <div  class="col-sm-1 col-sm-1 popupSubmit" >
											<span><button type="button" onclick="popupSubmit()" id="done" class="btn btn-default dropdown-toggle" >Done</button>	</span>
									</div> -->
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
                                 <!-- <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Signature</a>
                                 </div>
                                 <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Check Mark</a>
                                 </div>
                                 <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Date</a>
                                 </div>
                                 <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Text</a>
                                 </div>
                                 <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Done</a>
                                 </div>
                                 <div class="row pad1">
                                    <a href="#" class="col-xs-12 btn btn-style1">Close</a>
                                 </div> -->
                                 
                                 
								 <div class="col-sm-12 shape" id="draggable1">
								<p class="text-center"><strong>Fields Available</strong></p>
									<div id="signer-1" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1 drgfields"
										data-signer-id="1" data-document-id="1">
										<span class="col-xs-12 btn btn-style1" >Name</span> <!-- <span class="closeIt hideIt">x</span> -->
									</div>
								
									<div id="signer-2" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1 drgfields"
										data-signer-id="2" data-document-id="1">
										<span class="col-xs-12 btn btn-style1">Date</span> <!-- <span class="closeIt hideIt">x</span> -->
									</div>
								
									<div id="signer-3" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1 drgfields"
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




<script type="text/javascript">

$(document).ready(function() {
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

	
    document.getElementById("checkbox-1").disabled = true;
	
});

//Renumber table rows
function renumber_table(tableID) {
	$(tableID + " tr").each(function() {
		count = $(this).parent().children().index($(this)) + 1;
		$(this).find('.priority').html(count);
	});
}



//addmore
$(function() {
        var scntDiv = $('#p_scents');
        var i = $('#p_scents p').size() + 1;
        
        $('#addScnt').on('click', function() {
        		var priority = parseInt($('#signers_list tr:last-child td:first-child').html()) + 1
                $('<tr><td class="priority">'+priority+'</td><td><input class="form-control " type="text" id="name_'+priority+i+'" name="name_'+priority+i+'" placeholder="Name" /></td><td><input class="form-control " id="email_'+priority+i+'" type="text" name="email_' + priority+i +'" placeholder="Email" /></td><td><a class="btn btn-delete btNNCross">X</a></td></tr>').appendTo(scntDiv);
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


//read all tr
function readTr(fileID){ 
	var table = document.getElementById("signers_list");
	var priority;
	var name;
	var email;
	var users=[];
	var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var groupfilename = $('#groupfilename').val();
	var groupfileid = fileID;//$('#groupfileid').val();
	var url = '?fileid='+groupfileid+'&fname='+escape(groupfilename)+'';
	
	var errormsg = "";
	$("#groupsignsuccessalert").hide();
	$("#groupsignalert").hide();
	
	if(groupfilename !="" || groupfilename.trim() !=""){
		var ext = groupfilename.split('.').pop();
		if(ext == "pdf"){
			

			
			
			for (var i = 1, row; row = table.rows[i]; i++) {

				var item = {};
				for (var j = 0, col; col = row.cells[j] ; j++) {
					
						if(j==0){
							priority = col.innerHTML;
							if(priority ==""){
								return false;
							}else{
								item['priority'] = priority;
							}
						}else if(j==1){
							name = document.getElementById($(col.innerHTML).attr("id")).value;
							if(name =="" || name.trim()=="")
							{
								errormsg = "Please enter signer name.";
								$("#groupsignalert").show();
								$("#groupsignsendmsg").html(errormsg);
								document.getElementById($(col.innerHTML).attr("id")).focus();
								return false;
							}else{
								item['name'] = name;
							}
						}else if(j==2){
							email = document.getElementById($(col.innerHTML).attr("id")).value;
							if(email =="" || email.trim()==""  )
							{
								errormsg = "Please enter signer email.";
								$("#groupsignalert").show();
								$("#groupsignsendmsg").html(errormsg);
								document.getElementById($(col.innerHTML).attr("id")).focus();
								return false;
							}else if(!regex.test(email))
							{
								errormsg = "Please enter a valid email ID for the signee.";
								$("#groupsignalert").show();
								$("#groupsignsendmsg").html(errormsg);
								document.getElementById($(col.innerHTML).attr("id")).focus();
								return false;

							}else{
								item['email'] = email;
							}
						
						}
						
					
					 
			   } 
				users.push(item);
				
				
				
			}

			
			$("#popoversigner option").remove();
			$("#popoversigner").append(new Option("Select Signer", ""));
			
			 if($('#checkbox-3').is(':checked')){
				 $("#popoversigner").append(new Option("me("+$('#selfname').val()+")", "0"));
			}
			
			var duplicate = $('#selfemail').val();
			for (var key in users) {
				/* console.log(users[key]['priority']);
				console.log(users[key]['name']);
				console.log(users[key]['email']); */
				
				if(duplicate == users[key]['email'])
				{
					errormsg = "Email ID entered is already chosen, Please correct the email address.";//"Email: "+users[key]['email'] +" is duplicate.";
					$("#groupsignalert").show();
					$("#groupsignsendmsg").html(errormsg);
					$('#email_'+users[key]['priority']).focus();
					return false;
				}else{
					duplicate = users[key]['email'];
				}
				
				$("#popoversigner").append(new Option(users[key]['name'], users[key]['priority']));
				
			}

			$('#groupsignpopupalert').hide();
			$('#allsignermust').html("");

			
			$('#fillandsign').one('show.bs.modal', function(e) {
				$(e.currentTarget).find('.rederpdf').load('groupsignrender'+url);
			});
			$("#fillandsign").modal('show');
			
			$('#prepare_and_sign').text('RE-EDIT & SIGN');
			setTimeout(function(){
				$("#document-reader").append($("#fieldshtml").val());
			},1000);
			
			
		
			
		}else{
			errormsg = "Only pdf documents are allowed.";
			$("#groupsignalert").show();
			$("#groupsignsendmsg").html(errormsg);
			return false;
		}
	}else{
		errormsg = "Please upload pdf documents.";
		$("#groupsignalert").show();
		$("#groupsignsendmsg").html(errormsg);
		return false;
	}  
	
	
	$("#groupsignalert").hide();
	
	

}




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
	                	/* $("#groupsignsuccessalert").hide();
		    			$("#groupsignalert").show();
		    			$("#groupsignsendmsg").html("File Upload is in progress");
		    			$("#groupsignuploadpopupmessage").html("File Upload is in progress"); */
		    			
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
	$("#UploadForm").ajaxForm(options);

	
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
	
function groupSignSend(){
	
	$("#groupsignsuccessalert").hide();
	$("#groupsignalert").hide();
	$("#groupsignsendmsg").html("");
	$("#groupsignsendsuccessmsg").html("");

	
	var count = 0;
	var title = 			$('#title').val();
	var signerjsondata = 	$('#signerjsondata').val();
	var groupfilename = 	$('#groupfilename').val();
	var groupfileid = 		$('#groupfileid').val();
	var grouploginuserid =  $('#grouploginuserid').val();
	var groupsignmessage = 	$('#groupsignmessage').val();
	var envelopeid 		 =  $("#envelopeid").val();
	var errormsg =			"";
	var signatureid = $("#mysignatureflag").val();
	
	if(signerjsondata == "" || signerjsondata.trim() ==""){	
		errormsg = "Please prepare the document and add the names of all the signees.";
		count++;
	}else if(title == "" || title.trim() ==""){	
		errormsg = "Please enter the Subject.";
		count++;
	}else if(groupfilename == "" || groupfilename.trim() =="" || groupfileid == "" || groupfileid.trim() ==""){	
		errormsg = "Please upload files.";
		count++;
	}else if(grouploginuserid == "" || grouploginuserid.trim() ==""){	
		errormsg = "Your login id invalid.";
		count++;
	}else if(groupsignmessage == "" || groupsignmessage.trim() ==""){	
		errormsg = "Please enter a message for the recipient.";
		count++;
	}else if (envelopeid == "" || envelopeid.trim() == ""){
		errormsg = "Document envelope id cannot be empty.";
		count++;
	}
	
	
	
	if(count == 0)
	{
		$("#groupsignalert").hide();
		$.ajax({
			type:"POST",
			url: "groupsignsend",
			data:{'title':title,'signerjsondata':signerjsondata,'groupfilename':groupfilename,'groupfileid':groupfileid,'grouploginuserid':grouploginuserid,'groupsignmessage':groupsignmessage,'envelopeid':envelopeid,'signatureid':signatureid},
		    beforeSend: function () {
	   			$("#groupsignsuccessalert").show();
				$("#groupsignalert").hide();
				$("#groupsignsendsuccessmsg").html("progress..");

		    },
		    complete: function () {
	   			/* $("#groupsignsuccessalert").show();
				$("#groupsignalert").hide();
				$("#groupsignsendsuccessmsg").html("complete.."); */

		    },
		    success : function(response) 
		    {
	   			$("#groupsignsuccessalert").show();
				$("#groupsignalert").hide();
				$("#groupsignsendsuccessmsg").html(response);
		        $(".groupDiv").html("");
			}
		});
	}else{
		$("#groupsignsuccessalert").hide();
		$("#groupsignalert").show();
		$("#groupsignsendmsg").html(errormsg);
	}
	
}	

function enableEdit(){
	
	if (confirm("While editing signers, You lost your prepare positions data?")) {
		$("#signerslistdiv").css({ 'pointer-events': "all" });
		$("#signerslistdiv").css({ 'background-color': "white" });
		$("#signerjsondata").val("");
		$("#fieldshtml").val("");
		$("#enableedit").hide();
	   
	  }
	
}



$('#groupsignsendform').on('keyup keypress', function(e) {
	  var keyCode = e.keyCode || e.which;
	  if (keyCode === 13) { 
	    e.preventDefault();
	    groupSignSend();
	    return false;
	  }
});	


function mySignatureGetId(signatureId)
{
	$("#mysignatureflag").val(signatureId);
}
$('#groupsignmessage').keypress(function(event) {
	  if (event.which == 13) {
	    event.preventDefault();
	      var s = $(this).val();
	      $(this).val(s+"\n");
	  }
});
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
<script type="text/javascript" src="<%=serverUrl %>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=serverUrl %>/js/additional-methods.js"></script>
<script src="<%=serverUrl %>/js/uploadfile.js"></script>
 <jsp:include page="footer.jsp" />