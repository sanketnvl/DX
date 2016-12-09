<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <jsp:include page="header.jsp"></jsp:include> --%>
<%@ page import="com.myexample.model.Registration,org.springframework.security.core.context.SecurityContextHolder,org.springframework.security.core.Authentication" %>


<link rel="stylesheet" href="<c:url value="css/bootstrap.min.css"/>" /> 
<link rel="stylesheet" href="<c:url value="css/signaturepad.css"/>">
<link rel="stylesheet" type="text/css"href="<c:url value="css/style.css" />">
<script src="<c:url value="js/jquery.min.js"/>"></script>
<script src="<c:url value="js/jquery-ui.js"/>"></script>
<script src="<c:url value="js/jquery.form.js"/>"></script>

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

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <!-- Meta, title, CSS, favicons, etc. -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>DrySign Groupsign</title>
      <!-- Bootstrap core CSS -->
      <%-- <link href="<c:url value="css/ui/css/bootstrap.min.css"/>" rel="stylesheet"> --%>
      <link href="<c:url value="css/ui/fonts/css/font-awesome.min.css"/>" rel="stylesheet">
      <link href="<c:url value="css/ui/css/animate.min.css"/>" rel="stylesheet">
      <!-- App Icons-->
      <link href="<c:url value="css/ui/css/styles.css"/>" rel="stylesheet">
      <!-- Custom styling plus plugins -->
      <link href="<c:url value="css/ui/css/custom.css"/>" rel="stylesheet">
      <%-- <script src="<c:url value="js/ui/js/jquery.min.js"/>"></script> --%>
      <!--[if lt IE 9]>
      <script src="../assets/js/ie8-responsive-file-warning.js"></script>
      <![endif]-->
      <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <style>
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
/* input[type=checkbox], input[type=radio] {
    margin-top: 1px\9;
    width: 35px;
    height: 34px;
    /* cursor: pointer; */
    /* -webkit-appearance: none; */
    appearance: none;
    margin: 0;
} */
@media (min-width: 992px)
.col-md-10 { width: 91.333333% !important;}
      
</style>
     
   <body class="nav-md">
      <div class="container body">
         <div class="main_container">
            <div class="col-md-3 left_col">
               <div class="left_col scroll-view">
                  <div class="navbar nav_title" style="border: 0;">
                     <a href="#" class="site_title"><span>Drysign</span></a>
                  </div>
                  <div class="clearfix"></div>
                  <!-- menu prile quick info -->
                  <a href="profile">
                     <div class="profile">
                        <div class="profile_pic">
                           <img src="<%=picPath %>" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                           <span>Welcome,</span>
                           <h2>
                           <% if (registration != null) { %>
					 		<%=registration.getFirstName()%> 
						   <% } %> 
                           </h2>
                         
                        </div>
                     </div>
                  </a>
                  <!-- /menu prile quick info -->
                  <br />
                  <!-- sidebar menu -->
                  <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                     <div class="menu_section">
                        <ul class="nav side-menu">
                           <li class="">
                              <a href="web"><i class="icon-dashboard  fontIcon"></i> <span class="">&nbsp;DASHBOARD </span></a>
                              
                           </li>
                           <li><a href="selfSign"><i class="icon-self fontIcon"></i>&nbsp; SELF </a>
                           </li>
                           <li><a href="groupsign"><i class="icon-group fontIcon"></i>&nbsp; GROUP </a>
                           </li>
                           <li><a href="outforSignature"><i class="icon-group fontIcon"></i>&nbsp; OUT FOR SIGNATURE </a>
                           </li>
                           <li><a href="completedDocuments"><i class="icon-completed-documents fontIcon"></i>&nbsp; COMPLETED DOCUMENTS </a>
                           </li>
                        </ul>
                     </div>
                  </div>
                  <!-- /sidebar menu -->
               </div>
            </div>
            <!-- top navigation -->
            <div class="top_nav">
               <div class="nav_menu">
                  <nav class="" role="navigation">
                     <div class="nav toggle">
                        <a id="menu_toggle"><i class="icon-menu"></i></a>&nbsp;&nbsp;&nbsp;<!-- <a href="#"><i class="icon-enlarge"></i></a> -->
                     </div>
                     <ul class="nav navbar-nav navbar-right">
                        <li class="">
                           <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <img src="<%=picPath %>" alt="">
                           <% if (registration != null) { %>
					 		<%=registration.getFirstName()%> 
						   <% } %> 
                           <span class=" fa fa-angle-down"></span>
                           </a>
                           <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                              <li><a href="profile">  Profile</a>
                              </li>
                              
                              <li><a href="logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                              </li>
                           </ul>
                        </li>
                        
                     </ul>
                  </nav>
               </div>
            </div>
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col" style="background-color:#fff;" role="main">
               <!-- Page Header -->
               <div class="row" style="background:#CCCCCC;">
                  <div class="col-lg-3">
                     <h3 class="page-header">Group </h3>
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
                  <div class="col-xs-12 col-sm-8 col-md-12 portfolio-item">
                     <h4>
                        <a>Please attach your document.</a>
                        
                     </h4>
                     <br>
                     <div class="col-xs-12 col-sm-12 col-md-12" style="background-color:#F1EFF0;border:1px solid #ccc;padding:18px 0;">
                         <div class="row">
                           <div class="col-xs-12 col-sm-12 col-md-12">
                              <div class="col-xs-6 col-sm-6 col-md-5 col-md-offset-1 text-center">
                                 <a href="#" id="hideshow" class="btn btn-block btn-style1" data-toggle="modal" data-target="#uploadFileModel">UPLOAD FILES</a>
                              </div>
                              <div class="col-xs-3 col-sm-3 col-md-2 text-center" >
                                 <img src="<c:url value="images/ui/images/Google-Drive-Icon.png"/>" alt="" class="borDer" height="53px"> 
                              </div>
                              <div class="col-xs-3 col-sm-3 col-md-2 text-center">
                                 <img src="<c:url value="images/ui/images/dropbox.png"/>" alt=""  class="borDer" height="53px"> 
                              </div>
                           </div>
                        </div>
                        <div class="row pad1">
                           <div class="col-xs-12 col-sm-12 col-md-12">
                              <div class="col-xs-6 col-sm-6 col-md-5 col-md-offset-1 text-center">
                                 <a class="btn btn-block btn-style2" style="pointer-events:none">DRAG FILES</a>
                              </div>
                              <div class="col-xs-3 col-sm-3 col-md-2  text-center" >
                                 <img src="<c:url value="images/ui/images/Cloud.png"/>" alt=""  class="borDer" height="53px"> 
                              </div>
                              <div class="col-xs-3 col-sm-3 col-md-2  text-center">
                                 <img src="<c:url value="images/ui/images/box_logo.png"/>" alt=""  class="borDer" height="53px"> 
                              </div>
                           </div>
                        </div>
                        
                        <div class="row ">
                         <div class="col-xs-12 col-sm-12 col-md-12">
                         		<div class="btn col-xs-12 col-sm-12 col-md-9 col-md-offset-1">
                        		<div id="message"></div>
								<div id ="ajaxuploadedfile"></div>	
								</div>
								<button type="button" class="btn btn-style2 col-xs-12 col-sm-12 col-md-9 col-md-offset-1" style="display:none" id="prepare_and_sign"  onclick="readTr()">PREPARE & SIGN</button>
						</div>                        
                          
                        </div>
                     </div>
                  </div>
                  
                  
                  
                  
                  <div class="col-xs-12 col-sm-12 col-md-12 portfolio-item">
                     <h4>
                        <a>Who needs your Sign</a>
                     </h4>
                     <input type="radio"  name="signaturetype" onchange="signatureType(this)" value="Group Sign" checked="checked"> Group Sign
					 <input type="radio"  name="signaturetype"  onchange="signatureType(this)" value="Self Sign"> Self Sign and Send to Someone
					 <input type="radio"  name="signaturetype"  onchange="signatureType(this)" value="Sign"> Self Sign and Send Later

                     <br/>
                     
                    
                     
                     <div class="col-xs-12 col-sm-12 col-md-12">
                       
                           <fieldset>
                           
                           <!-- SELF SIGN -->
                            <div id="signatureself" style="display:none" class="emailsubmsg">
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
                     		</div>
                     		
                     		<!-- GROUP SIGN -->
                           <div id="signaturegroup">
                     
                     
                              <div class="form-group">
                                 <!-- <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-11">
                                       <input type="text" placeholder="SELF" class="form-control " name="title" readonly />
                                    </div>
                                     <input type="checkbox" name="self" id="selfsign" style="font-Size:33px;" checked /> 
                                    
                                 </div> -->
                              </div>
                              <div class="form-group">
                               
								<div class="row">
								<div class="col-xs-12 col-sm-6 col-md-2 padHH">
							         Include me <input type="checkbox" name="self" id="selfsign" style="font-Size:33px;" checked />
							       </div>
							       <div class="col-xs-12 col-sm-6 col-md-5">
							          <input type="hidden" placeholder="<% if(registration !=null){ out.print(registration.getFirstName());} %>" id="selfname" class="form-control " name="name" value="<% if(registration !=null){ out.print(registration.getFirstName());} %>" readonly>
							       </div>
							       <div class="col-xs-12 col-sm-6 col-md-5 padHH">
							          <input type="hidden" placeholder="<% if(registration !=null){ out.print(registration.getEmail());} %>"  id="selfemail"  class="form-control " name="email" value="<% if(registration !=null){ out.print(registration.getEmail());} %>" readonly>
							       </div>
							       
							    </div>
 
                              </div>
                              <div class="form-group">
                                 <!-- <div class="row">
                                    <div class="col-xs-8 col-sm-8 col-md-11">
                                       <input type="text" placeholder="Group" class="form-control " name="title" readonly/>
                                    </div>
                                    <div class="col-xs-2 col-sm-2 col-md-1">
                                       <span class="icon-box" style="font-Size:33px;"></span>
                                    </div>
                                 </div> -->
                              </div>
                              <div class="form-group emailsubmsg" id="signerslistdiv" >
								<table class="table" id="signers_list" style="border: 1px solid #bdbdbd;border-collapse: separate;">
					                <thead>
					                    <tr><th>Priority</th><th>Name</th><th>Email</th><th></th><th>&nbsp;</th></tr>
					                    
					                </thead>	
					                 
					                <tbody id="p_scents">
					                							                
										<tr><td class='priority'>1</td><td><input class="form-control" type="text" id="name_1" name="name_1" placeholder="Name" /></td><td><input class="form-control " id="email_1" type="text" name="email_1" placeholder="Email" /></td><td><a class='btn btn-delete btNNCross'>X</a></td></tr>											
					                </tbody>
							    </table>                              
                              
                                 <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                    <a  id="addScnt">Add More Signer</a>
                                      <!--  <input type="text" placeholder="Add more Signer" class="form-control " name="title" /> -->
                                    </div>
                                 </div>
                              </div>
                               
                              <div class="form-group">
                              <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">        
                                   <a  class="form-control" onclick="enableEdit()"  id="enableedit"  style="display:none;">Enable Edit.</a>
                                    
                                    </div>
                                 </div>
                              </div>
							</div>
							<br>
							<form role="form" id="groupsignsendform" class="emailsubmsg">
								    <div class="form-group">
									    <div class="row">
										    <div class="col-xs-12 col-sm-12 col-md-12">
										      <input type="hidden" id="signerjsondata" name="signerjsondata" />
										      <input type="hidden" id="groupfilename" name="groupfilename" />
										      <input type="hidden" id="groupfileid" name="groupfileid" />
										       <input type="hidden" id="envelopeid" name="envelopeid" />										  
										      <input type="hidden" id="grouploginuserid" name="grouploginuserid" value="<% if (registration != null) { out.print(registration.getId()); } %>" />
										    </div>
										    <div id="sign">
											    <div class="col-xs-12 col-sm-12 col-md-12">
											      	<input type="text" class="form-control" id="title" placeholder="Title" name="grouptitle" />
											    </div>
											    <div class="col-xs-12 col-sm-12 col-md-12"><br>
											    	<textarea class="form-control" rows="3" id="groupsignmessage" placeholder="Message" name="groupmessage"></textarea>
											    </div>
									    	</div>
									     </div> 
								     </div>
									<div class="row">
                                		<div class="col-xs-12 col-sm-4 col-sm-offset-6 col-md-4 col-md-offset-8">
								    		<button type="button" class="col-xs-12 btn btn-lg btn-primary" onclick="groupSignSend()">Save</button>
								    	</div>
                             		</div>
							</form>                                                         
                           </fieldset>
                       
                     </div>
                  </div>
               </div>
               <!-- /.row -->				
            </div>
            <!-- /right_col -->
         </div>
         <!-- /page content -->
      </div>
      <!-- /container body -->
      <!-- footer content -->
      <footer class="main-footer">
         <div class="container-fluid">
            <div class="row">
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                  <img class="img-responsive footer_A" src="<c:url value="images/ui/images/Group 33.png"/>" alt=""> 
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                  <p class="footer_B">Copyright &copy; 2016, SourceHOV</p>
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 social text-center">
                  <ul class="footer_ul footer_C">
                     <li><a ><i class="fa fa-lg fa-facebook"></i></a></li>
                     <li><a ><i class="fa fa-lg fa-twitter"></i></a></li>
                     <li><a ><i class="fa fa-lg fa-google-plus"></i></a></li>
                     <li><a ><i class="fa fa-lg fa-linkedin"></i></a></li>
                  </ul>
               </div>
            </div>
         </div>
      </footer>
      <!-- /footer content -->
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
					<input class="form-control" id="typeSign" type="text" value="esign"><br><br>
					<input type="hidden" id="generator" value="1" />
					 <div class="row" id="selectType">
						
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="profile">
					<div class="sigPad" id="linear"
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

				</div>
				<div role="tabpanel" class="tab-pane" id="messages">
				    
					<input type='file' id="asd" /><br><br>
					<img id="img" src="" height="300px" width="300px" />
				</div>
				<div role="tabpanel" class="tab-pane" id="settings">
					<div class="row">
						<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<input type="hidden" id="mysignatureflag" value=""/>
						
						<c:choose>
						    <c:when test="${not empty signatures}">
						       
						       <c:forEach items="${signatures }" var="sign">
		                     		<a class="thumbnail"> 
										<img id="mySignature${sign.id}" onclick="mySignatureGetId(${sign.id})" class="img-responsive" src="${sign.sign}" alt="">
									</a>
		                     	</c:forEach>
						             
						    </c:when>
						    <c:otherwise>
						       There is no signatures available.
						    </c:otherwise>
						</c:choose>     
						
						
							
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
             <h4 class="modal-title">Please select your file </h4>
          </div>
          <div class="modal-body">
            

             

	 
	 
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-md-12">
			 <input type="file" size="60" id="myfile" name="file" class="form-control required">
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



<script src="<c:url value="js/jsonmin.js"/>"></script>
<script src="<c:url value="js/bootstrap.min.js"/>"></script>
      
      
      
      <%-- <script src="<c:url value="js/ui/js/bootstrap.min.js"/>"></script> --%>
      <script src="<c:url value="js/ui/js/nicescroll/jquery.nicescroll.min.js"/>"></script>
      <script src="<c:url value="js/ui/js/custom.js"/>"></script>

      
      
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
function readTr(){ 
	var table = document.getElementById("signers_list");
	var priority;
	var name;
	var email;
	var users=[];
	var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var groupfilename = $('#groupfilename').val();
	var groupfileid = $('#groupfileid').val();
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
								errormsg = "Please enter valid email.";
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
			
			 if($('#selfsign').is(':checked')){
				 $("#popoversigner").append(new Option("me("+$('#selfname').val()+")", "0"));
			}
			
			var duplicate = $('#selfemail').val();
			for (var key in users) {
				console.log(users[key]['priority']);
				console.log(users[key]['name']);
				console.log(users[key]['email']);
				
				if(duplicate == users[key]['email'])
				{
					errormsg = "Email: "+users[key]['email'] +" is duplicate.";
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
			$('#fillandsign').on('show.bs.modal', function(e) {
				$(e.currentTarget).find('.rederpdf').load('groupsignrender'+url);
			});
			$("#fillandsign").modal('show'); 

			
		
			
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
		        		$('#hideshow').css('pointer-events','none');
		        		$("#prepare_and_sign").show();
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
		        		$("#prepare_and_sign").hide();
		    			$("#groupsignalert").show();
		    			$("#groupsignsendmsg").html(responseMessage);
		    			$("#groupsignuploadpopupalert").show();
		    			$("#groupsignuploadpopupmessage").html(responseMessage);

		        	}else{
		        		responseMessage = obj.message;
		        		$("#groupsignsuccessalert").hide();
		        		$("#prepare_and_sign").hide();
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
	        		$("#prepare_and_sign").hide();
	        		$("#UploadForm").show();
	        		$("#ajaxuploadedfile").html("");
	        		$('#groupfilename').html("");
	        		$('#groupfileid').html("");
	        		$('#percent').html("");
	        		$('#myfile').val("");
	        		$('#groupfilename').val("");
	        		$('#signerjsondata').val("");
					
	        		$('#hideshow').css('pointer-events','all');
	    			$("#groupsignsuccessalert").show();
	    			$("#groupsignalert").hide();
	    			$("#groupsignsendsuccessmsg").html("File successfully deleted");
	        		
	        	}else{
	        		$("#prepare_and_sign").show();
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
		errormsg = "Please Prepare & sign document.";
		count++;
	}else if(title == "" || title.trim() ==""){	
		errormsg = "Document Title cannot be empty.";
		count++;
	}else if(groupfilename == "" || groupfilename.trim() =="" || groupfileid == "" || groupfileid.trim() ==""){	
		errormsg = "Please upload files.";
		count++;
	}else if(grouploginuserid == "" || grouploginuserid.trim() ==""){	
		errormsg = "Your login id invalid.";
		count++;
	}else if(groupsignmessage == "" || groupsignmessage.trim() ==""){	
		errormsg = "Document Message cannot be empty.";
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
	$("#signerslistdiv").css({ 'pointer-events': "all" });
	$("#signerslistdiv").css({ 'background-color': "white" });
	$("#signerjsondata").val("");
	$("#enableedit").hide();
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


function signatureType(check)
{
	var sign = check.value;
	if(sign == "Self Sign")
	{
		$("#signatureself").show();
		$("#signaturegroup").hide();
		$("#sign").show();
	}else if(sign == "Group Sign")
	{
		$("#signaturegroup").show();
		$("#signatureself").hide();
		$("#sign").show();
	}else if(sign == "Sign")
	{
		$("#signaturegroup").hide();
		$("#signatureself").hide();
		$("#sign").hide();
		
	}
}

</script>
 
			   
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
											<select id="popoversigner" onchange="popoverDropdown(this)" ></select>
									</div>	                                    
                                 </div>
                              </div>
                           </div>
                           <div class="col-xs-12 col-sm-4 col-md-4">
                              <div class="row">
                                 <div class="col-xs-12 col-sm-6 col-md-6">
                                    <a  class="col-xs-12 btn btn-styleHG" data-dismiss="modal">Cancel</a>
                                 </div>
                                 <div class="col-xs-12 col-sm-6 col-md-6">
                                    <a  class="col-xs-12 btn btn-styleHG" onclick="popupSubmit()">Continue</a>
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
                                 <div style="background-color:#fff;overflow:auto;height:500px;" class="rederpdf">
                                    
                                 </div>
                              </div>
                              <div class="col-xs-12 col-sm-2 col-md-2 modalX">
                                 
                                 
                                 
								 <div class="col-sm-12 shape" id="draggable1">
								
									<div id="signer-1" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1"
										data-signer-id="1" data-document-id="1">
										<span class="col-xs-12 btn btn-style1">Name</span> <!-- <span class="closeIt hideIt">x</span> -->
									</div>
								
									<div id="signer-2" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1"
										data-signer-id="2" data-document-id="1">
										<span class="col-xs-12 btn btn-style1">Date</span> <!-- <span class="closeIt hideIt">x</span> -->
									</div>
								
									<div id="signer-3" class="col-sm-6 col-sm-6 dragMe dragSigners row pad1"
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
   </body>
</html>