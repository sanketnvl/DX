
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


	  <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/bootstrap.min.css" rel="stylesheet">
      <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/fonts/css/font-awesome.min.css" rel="stylesheet">
      <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/animate.min.css" rel="stylesheet">
      <!-- App Icons-->
      <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/styles.css" rel="stylesheet">
      <!-- Custom styling plus plugins -->
      <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/custom.css" rel="stylesheet">
      <script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/ui/js/jquery.min.js"></script>
      <link rel="stylesheet" href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/jquery.mCustomScrollbar.css">
 	  <link rel="stylesheet" href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/signaturepad.css">
	  <link href='https://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css'>
      <link rel="stylesheet" href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/selfsign.css"> 
      <link href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/ui/css/styles.css" rel="stylesheet">
	  <link rel="stylesheet" type="text/css" href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/style.css" />">
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
      .modal-headerH {
      border-bottom: none;
      min-height: 16.43px;
      padding: 20px;
      text-align: center;
      background-color:#fff;
      min-height:10%;
      }
      .modal-bodyZ{
      background-color:#fff;
      min-height:80%;
      }
      .modal-footerI {
      padding: 15px;
      text-align: center;
      border-top: none;
      background-color:#fff;
      min-height:10%;
      border-bottom-right-radius:13px;
      border-bottom-left-radius:13px; 
      }
      .closeJ {
      color: #fff;
      float: right;
      font-size: 27px;
      font-weight: 300;
      line-height: 1;
      opacity: 1;
      text-shadow: 0 1px 0 #fff;
      }
      .form-controlL {
      background-color: #00838f;
      background-image: none;
      border: 1px solid #fff;
      border-radius: 16px;
      box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
      color: #fff;
      display: block;
      font-size: 15px;
      height: 40px;
      line-height: 1.42857;
      padding: 6px 12px;
      transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
      width: 100%;
      }
      .btnM {
      background-color: #fff;
      border: 1px solid #54bd7a;
      border-radius: 15px;
      color: #54bd7a;
      font-size: 14px;
      font-weight: 400;
      letter-spacing: 1px;
      transition: all 0.4s ease 0s;
      line-height: 1.42857;
      margin-bottom: 0;
      padding: 6px 32px;
      text-align: center;
      vertical-align: middle;
      white-space: nowrap;
      font-size: 15px;
      }
      .btnM:hover {
      background-color:#54BD7A;
      color:#fff;
      }
   </style>
<%-- <jsp:include page="header.jsp" /> --%>

 
<!-- set project name dynamically -->
<body class="nav-md" >
   <input type="hidden" id="userId" value="<%=registration.getId()%>"/>
   <input type="hidden" id="contextPath" value="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/"/>
      <div class="container body" >
         <div class="main_container">
            <div class="col-md-3 left_col">
               <div class="left_col scroll-view">
                  <div class="navbar nav_title" style="border: 0;">
                     <a href="" class="site_title"><i class="icon-dashboard"></i> <span>eSign</span></a>
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
                          <!--  <p style="color:#5890CD;">Art Director</p> -->
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
                              <!-- <ul class="nav child_menu" style="display: none">
                                 <li><a href="#">Dashboard</a>
                                 </li>
                                 <li><a href="#">Dashboard2</a>
                                 </li>                  
                                 </ul> -->
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
                        <a id="menu_toggle"><i class="icon-menu"></i></a>&nbsp;&nbsp;&nbsp;<a href="#"><i class="icon-enlarge"></i></a>
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
                             <!--  <li>
                                 <a href="javascript:;">
                                 <span class="badge bg-red pull-right">50%</span>
                                 <span>Settings</span>
                                 </a>
                              </li>
                              <li>
                                 <a href="javascript:;">Help</a>
                              </li> -->
                              <li><a href="logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                              </li>
                           </ul>
                        </li>
                        <%-- <li role="presentation" class="dropdown">
                           <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                           <i class="icon-notification"></i>
                           <span class="badge bg-green">6</span>
                           </a>
                           <ul id="menu1" class="dropdown-menu list-unstyled msg_list animated fadeInDown" role="menu">
                              <li>
                                 <a>
                                 <span class="image">
                                 <img src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/images/ui/images/img.jpg" alt="Profile Image" />
                                 </span>
                                 <span>
                                 <span>John Smith</span>
                                 <span class="time">3 mins ago</span>
                                 </span>
                                 <span class="message">
                                 Film festivals used to be do-or-die moments for movie makers. They were where...
                                 </span>
                                 </a>
                              </li>
                             
                              <li>
                                 <div class="text-center">
                                    <a>
                                    <strong>See All Alerts</strong>
                                    <i class="fa fa-angle-right"></i>
                                    </a>
                                 </div>
                              </li>
                           </ul>
                        </li> --%>
                     </ul>
                  </nav>
               </div>
            </div>
            <!-- /top navigation -->
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col" style="background-color:#fff;" role="main">
               <!-- Page Header -->
               <div class="row" style="background:#CCCCCC;">
                  <div class="col-lg-12">
                     <h3 class="page-header">
                     </h3>
                  </div>
               </div>
               <!-- /.row -->
               <!-- Projects Row -->
     
      
            </div>
            <!-- /right_col -->
         </div></div>
         <!-- /page content -->
    
      <!-- /container body -->
      <!-- footer content -->
      <footer class="main-footer">
         <div class="container-fluid">
            <div class="row">
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                  <img class="img-responsive footer_A" src="images/Group 33.png" alt=""> 
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                  <p class="footer_B">Copyright &copy; 2016, SourceHOV</p>
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 social text-center">
                  <ul class="footer_ul footer_C">
                     <li><a href="#"><i class="fa fa-lg fa-facebook"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-twitter"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-google-plus"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-linkedin"></i></a></li>
                  </ul>
               </div>
            </div>
         </div>
      </footer>




<!-- Modal -->
<div id="myModalPDF" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content" style="border-radius: 0;border: 2px solid orange;">
      <div class="modal-header">
        <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
        
       		 <h4 class="modal-title"></h4>
       		
        <!-- Show Drag and Drop menu [textbox,checkbox,singature,date] start here -->
        		
        		<div class="row">
                     <div class="col-xs-12 col-sm-2 col-md-2 col-md-offset-8">
                        <a href="#" class="col-xs-12 btn btn-styleHG" onclick="goBack();" >Cancel</a>
                     </div>
                     <div class="col-xs-12 col-sm-2 col-md-2">
                        			   
                        			   
                 <form id="selfSignForm" action="redirectSelfSign" method="POST">
			   		<input type="hidden" name="docData" id="MetaData" value=""/>
			   		<input type="hidden" name="fileName" id="documentName" value="${filename}"/>
			   		<input type="hidden" name="fileId"  id="fileId" value="${fileid}"/>
			<a href="#" class="col-xs-12 btn btn-styleHG" onclick="saveSelfSignPDFData()" id="done">Continue</a>
				
				</form>
                     </div>
                  </div>

		<!-- Show Drag and Drop menu [textbox,checkbox,singature,date] end here -->
      </div>
      <div class="modal-body">
      <div class="row">
      <div class="col-sm-10 col-md-10">
      
              <!--Render PDF start here -->
			<div >
				<div class="wrapper" >
					${fileMsg} <input type="hidden" id="fileName" value="${filename}" />
					<div class="page" id="mygrid-wrapper-div">
						<div class='document-reader' id="document-reader">
							<c:forEach var="page"  begin="1" end="${numpages}">
								<div class="pageimg" id="${page}" data-doc-id="${page}">
									<img width="890"  src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/app/renderSelfsign?fileid=${fileid}&filename=${filename}&page=${page}" />
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		<!--Render PDF end here -->
      
      </div>
      
       <div class="col-sm-2 col-md-2" style="padding:0 25px;" id="draggable1">
       	  <div  class="row" style="">
               <div id="signer-1" 	data-signer-id="1" data-document-id="1" class="col-xs-12 btn dragMe dragSigners" style="border-radius:0;padding:10px 12px;">Name</div>
            </div>
            <div class="row" style="">
               <div id="signer-2" data-signer-id="2" data-document-id="1" class="col-xs-12 btn dragMe dragSigners" style="border-radius:0;padding:10px 12px;">Date</div>
            </div>
            <div class="row" style="">
                 <div id="signer-3" data-signer-id="3" data-document-id="1" class="col-xs-12 btn dragMe dragSigners" style="border-radius:0;padding:10px 12px;">Signature</div>
           </div>
           <!--  <div class="row" style="padding-top:15px;">
               <a href="#" class="col-xs-12 btn btn-primary" style="border-radius:0;padding:10px 12px; ">Check Mark</a>
            </div> -->
            
            
                                      
      </div>
      
      
      </div>
      

      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
      </div>
    </div>

  </div>
</div>

<!-- POP UP BOX for Signature start here -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
						<input class="form-control" id="typeSign" type="text" value="esign"><br><br>
						 <div class="row" id="selectType">
						</div>
					</div>
					
					<!-- DRAW -->
					<div role="tabpanel" class="tab-pane" id="draw">
						<div class="sigPad" id="linear"
							style="width: 404px; margin-top: 10px;">
							<ul class="sigNav">
								<li class="clearButton"><a href="#clear">Clear</a></li>
							</ul>
							<div class="sig sigWrapper" style="height: auto;">
								<div class="typed"></div>
								<canvas class="pad" width="400" height="250" id="drawSignature"></canvas>
								<input type="hidden" name="output" class="output">
							</div>
						</div>
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
<!-- POP UP BOX for Signature end here -->

<input type="hidden" id="myType" value="asd"/>
<input type="hidden" id="imageField" value=""/>
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="imageField" value=""/>
<input type="hidden" id="fileid" value="${fileid}"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/jquery-ui.js"></script>
<script type="text/javascript">
   function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
   }
   
   function goBack() {
	    window.history.go(-1);
	}
</script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/selfsign.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/numeric.js"></script> 
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/bezier.js"></script> 
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/signaturepad.js"></script> 
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/jsonmin.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/ui/js/bootstrap.min.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/ui/js/nicescroll/jquery.nicescroll.min.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/ui/js/custom.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/ui/js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script>
         $(document).ready(function(){
         	$('#hideshow').click(function() {        
         		 $('.content').toggle('show');
         	});
         });
          
      </script>
      <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/additional-methods.js"></script>
<script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/uploadfile.js"></script>
   </body>
</html>

