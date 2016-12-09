<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
 <jsp:include page="header.jsp" />
 

<script src="<%=appUrl %>/js/1.0/document.js"></script> 
<script src="<%=appUrl %>/js/1.0/jquery.form.js"></script> 

 <style>
 .col-md-12 .center .square_2{
	cursor:pointer 
 }
 .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    border-top: 0px solid #ddd;
}
 </style>
 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper bg_wrap">
  	<ol class="breadcrumb" style="background-color:#F1F0F0">
		  <li class="breadcrumb-item"><a href="#">DrySign</a></li>
		  <li class="breadcrumb-item active" style="color:#2c3d4f;">Document</li>
	</ol>

		<div class="doc-error col-lg-4" style="float: left;width: 100%;">
		     <div class="alert alert-danger fade in " style="display:none;" id="doc-error-msg">
				<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
				<span class="alert fade in" id="doc-error-msg-text"></span>
			</div>
			<div class="alert alert-success" style="display:none;" id="doc-success-msg">
		 		<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
		 		<span class="alert fade in" id="doc-success-msg-text"></span>
			</div> 
		</div>

    <div class="wizard">
      <div class="wizard-inner">
        <div class="connecting-line"></div>
        <ul class="nav nav-tabs" role="tablist">
          <li role="presentation" class="active"> <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" > <span class="round-tab"> <i class="fa fa-cloud-upload" aria-hidden="true"></i> </span> <b>Upload Doucument</b> </a> </li>
          <li role="presentation" class="disabled"> <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" > <span class="round-tab"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> </span> <b>Add Signees & Prepare Document</b> </a> </li>
          <!-- <li role="presentation" class="disabled"> <a href="#step3" data-toggle="tab" aria-controls="step3" role="tab" > <span class="round-tab"> <i class="fa fa-newspaper-o" aria-hidden="true"></i> </span> <b>Prepare Document</b> </a> </li> -->
          <li role="presentation" class="disabled"> <a href="#complete" data-toggle="tab" aria-controls="complete" role="tab" > <span class="round-tab"><i class="fa fa-commenting-o" aria-hidden="true"></i> </span> <b>Add Subject & message </b> </a> </li>
        </ul>
      </div>
   
      <div class="tab-content accordion"> 
        <!-- Personal Information -->
        <div class="tab-pane active" role="tabpanel" id="step1">
          <div class="step1">
            <section class="content contentdoc">
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Get your document signed</h3>
                        <p class="para1">Select Option</p>
                        <hr class="hr_line">
                      </div>
                    </div>
                    <div class="row xy row_2">
                      <div class="col-md-12 center">
                        <div class="square_2 " id="signtype1">
                          <div class="radio">
                            <input type="radio" name="signtype" id="selftype">
                          </div>
                          <!-- <input type="checkbox" id="test1" class="add-attr" tabindex="1" checked/>
                                 <label for="test1"></label> --> 
                          <span class="icon-self icon_2"></span>
                          <p class="para3">Self Sign</p>
                        </div>
                     
                        <div class="square_2" id="signtype2">
                          <div class="radio">
                            <input type="radio" name="signtype"  id="grouptype">
                          </div>
                          <!-- <input type="checkbox" id="test12" tabindex="1" />
                                 <label for="test12"></label>
                                 <input type="checkbox" style="left: 151px;position: absolute;top: -8px;" name="vehicle" value="Bike">	 --> 
                          <span class="icon-group icon_2"></span>
                          <p class="para3">Group Sign</p>
                        </div>
                      </div>
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <hr>
                      </div>
                    </div>
                    <div class="row">
                    <form id="UploadForm" action="ajaxupload" method="post" enctype="multipart/form-data">
						<input type="hidden" name="signtype" value="G">
						<input type="hidden" id="loginuserid" name="loginuserid" value="<% if (registration != null) { out.print(registration.getId()); } %>" /> 
	                    <div class="col-xs-12">  <h3 class="head3_1">Upload  document</h3></div>
	                      <div class="col-xs-12">
	                       
		                    <div class="">
		                    <input  onchange="docUpload()" type="file" name="file" id="myfile" class="inputfile inputfile-6" data-multiple-caption="{count} files selected" placeholder="Upload your PDF" />
		                    <label for="myfile"><span></span> <strong>
		                   <i class="fa fa-folder-open" aria-hidden="true"></i>
		                   Upload File </strong></label>
		                   
		                  </div>
		                  </div>
	                  </form>
	                  <div id="ajaxuploadedfile"></div>
                  </div>
                  
                    <ul class="list-inline text-center">
                      <li>
                        <button type="button" class="btn btn-primary next-step" onclick="next(1,2,1)">Save and Continue <i class="fa fa-caret-right text-right" aria-hidden="true"></i></button>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </section>
          </div>
          
          <!-- button --> 
          
        </div>
        
        <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="step2">
          <div class="step2">
            <section class="content contentdoc">
              <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                  <div class="signature">
                    <div class="row row_1">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <h3 class="head3_1">Get your document signed</h3>
                      </div>
                    </div>
                    <div class="row xy">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <p class="para4"><span class="pull-left">Include Me  </span>
                        <span class="pull-right">
                          <input type="checkbox" id="test120" class="add-attr" tabindex="3" checked/>
                          <label for="test120"></label>
                          </span>
                        </p>
                      </div>
                      <div class="col-md-6 col-sm-6 col-xs-6 col-480 margB20 vx">
                        <input type="text" name="name" id="selfname" class="form-control " value="<% if(registration !=null){ out.print(registration.getFirstName());} %>" id="field1" readonly>
                      </div>
                      <div class="col-md-6 col-sm-6 col-xs-6 col-480 margB20 vx">
                        <input type="email" name="email"   id="selfemail" class="form-control " value="<% if(registration !=null){ out.print(registration.getEmail());} %>" id="field2" readonly>
                      </div>
                    </div>
                    
                  
                    <div class="row">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                        <p class="para1">Add Signees</p>
                        <p class="para4">Group</p>
                      </div>
                    </div>
                    <div class="row xy">
                      
                    </div>
                    <div id="signerslistdiv">
                    <table class="table" id="signers_list">
                    <tbody id="p_scents">
                    	<tr class="row disttop2"><td class="numberingcls priority">1</td><td><div class=""><input type="text" class="form-control " placeholder="Name" id="name_1" name="name_1"></div></td><td><div class=""><input type="email" class="form-control " placeholder="Email" id="email_1" type="text" name="email_1"></div></td><td><div class="col-md-1 col-sm-1 col-xs-1 close-btn"> <a class="btn btn-delete btNNCross"><i class="fa fa-times-circle" aria-hidden="true"></i></a> </div></td></tr>
                     </tbody>
                    </table>
                    </div>
                  
                    
                    <div class="row disttop2">
                    <div class="col-md-12 col-sm-12" style="margin-bottom:10px;">
                              <div class="numbering"><button id="addScnt" class="icon-plus"></button></div>
                           </div>
                    </div>
                    
                    <div class="">
                      <div class="col-sx-12">
                       <!-- <div class="para4">Prepare Document </div>-->
                        <div class="text-left">
                          <button type="button" class="btn btn-info prepare-doc" onclick="window.location='Prepare_Document_view.html'"  value="Prepare docs for signing">Prepare docs for signing</button>
                        </div>
                      </div>
                    </div>
                    <ul class="list-inline text-center">
                      <li>
                        <button type="button" class="btn btn-primary prev-step"><i class="fa fa-caret-left text-left" aria-hidden="true"></i>Previous</button>
                      </li>
                      <li>
                        <button type="button" class="btn btn-primary next-step"  onclick="next(1,2,1)">Save and continue<i class="fa fa-caret-right text-right" aria-hidden="true"></i></button>
                      </li>
                    </ul>
                  </div>
                </div>
                <!-- Buttons --> 
                
              </div>
            </section>
          </div>
        </div>
        
        <!-- Profestional Information -->
        <div class="tab-pane" role="tabpanel" id="complete">
          <div class="step4">
            <section class="content contentdoc">
              <div class="signature">
                <div class="row">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                    <p class="para4">Add Subject & message </p>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                    <form role="form">
                      <div class="form-group">
                        <div class="row">
                          <div class="col-xs-12 col-sm-12 col-md-12">
                            <input type="text" class="form-control" id="title" placeholder="Subject" name="grouptitle">
                            <input type="hidden" id="signerjsondata" name="signerjsondata">
                            <input type="hidden" id="groupfilename" name="groupfilename">
                            <input type="hidden" id="groupfileid" name="groupfileid">
                            <input type="hidden" id="envelopeid" name="envelopeid">
                            <input type="hidden" id="grouploginuserid" name="grouploginuserid" value="34">
                            <input type="hidden" id="fieldshtml">
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <textarea class="form-control" rows="8" id="groupsignmessage" placeholder="Message" name="groupmessage"></textarea>
                      </div>
                      <div class="row">
                      </div>
                    </form>
                  </div>
                </div>
              
                <div class="row">
                  <div class="col-xs-12">
                    <div class="para4">Preview Document </div>
                    <div class="text-center">
                      <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" value="Prepare Document"> Review</button>
                    </div>
                  </div>
                </div>
                <ul class="list-inline text-center">
                  <li>
                 <button type="button" class="btn btn-primary prev-step"><i class="fa fa-caret-left text-left" aria-hidden="true"></i>Previous</button>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#successfull" >Save &amp; finish</button>
                  </li>
                </ul>
              </div>
            </section>
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
      
    </div>
    
    <!-- Main content -->
    <section class="content contentdoc"> </section>
    <!-- /.content --> 
  </div>
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog"> 
      
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Review Your Document</h4>
        </div>
        <div class="modal-body">
          <div class="container-fluid">
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 1 - Self Sign:  </div>
              </div>
              <div class="col-xs-12">              	
                
                <table cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <tr>
                	
                    <td><strong>Document Name</strong></td>
                    <td> Example.pdf</td>
               </tr>
              <tr>
                	
                    <td><strong>Requested by</strong></td>
                    <td>Sanket navale</td>
                    </tr>
                </table>
               
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 2  - Signers </div>
              </div>
             <div class="col-xs-12">              	
               
                <table cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <tr>
                <th>Priority</th>
                <th>Name</th>
                <th>Email ID</th>
                </tr>
                <tr>
                	<td  class="text-right">1</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
               </tr>
              <tr>
                	
                    <td  class="text-right">2</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
                    </tr>
                        <tr>
                	
                    <td  class="text-right">3</td>
                    <td>snaket navale</td>
                    <td>Sanketnavale@gmail.com</td>
                    </tr>
                </table>
                
              </div>
            </div>
            <div class="row">
              <div class="col-xs-12">
                <div class="para4">Step 3 - Add a subject and message for the recipient </div>
              </div>
             <div class="col-xs-12">              	
               
                <table cellpadding="0" cellspacing="0" width="100%;" class=" table table-bordered">
                <tr>
                	
                    <td><strong>Subject</strong></td>
                    <td> Text</td>
               </tr>
              <tr>
                	
                    <td><strong>Message</strong></td>
                    <td>Test</td>
                    </tr>
                </table>
               
              </div>
            </div>
            
          </div>
        </div>
        <div class="modal-footer text-center">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <div id="successfull" class="modal fade" role="dialog">
    <div class="modal-dialog"> 
      
      <!-- Modal content-->
      <div class="modal-content" style="width:400px; max-width: 90%; margin: 0 auto">
        <div class="modal-body">
          <div class="container-fluid">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <br/>
            <p class="text-center" ><img src="<%=appUrl %>/images/1.0/successfull.png" style="width:75px"/></p>
            <p class="text-center">Successfully sent the document for signing to the intended signees in the order of priority. </p>
            <p>Please verify your dcoument in out for signature link</p>
          </div>
        </div>
      </div>
    </div>
  </div>
<jsp:include page="footer.jsp" />

