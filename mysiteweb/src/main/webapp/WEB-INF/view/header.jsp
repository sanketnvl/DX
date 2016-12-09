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

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>DrySign</title>
    
      <link rel="stylesheet" href="<%=appUrl %>/css/signaturepad.css" />
	  <link rel="stylesheet" type="text/css" href="<%=appUrl %>/css/style.css" />
 	  <link href="<%=appUrl %>/css/ui/css/bootstrap.min.css" rel="stylesheet">
      <link href="<%=appUrl %>/css/ui/fonts/css/font-awesome.min.css" rel="stylesheet">
      <link href="<%=appUrl %>/css/ui/css/animate.min.css" rel="stylesheet">
     
     <link href="<%=appUrl %>/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
     
      <link href="<%=appUrl %>/css/ui/css/styles.css" rel="stylesheet">
     
      <link href="<%=appUrl %>/css/ui/css/custom.css" rel="stylesheet">
	  <link rel="stylesheet" href="<%=appUrl %>/css/ui/css/circle.css">
      <script src="<%=appUrl %>/js/ui/js/jquery.min.js"></script>
      <script src="<%=appUrl %>/js/jquery.form.js"></script>
      <script src="<%=appUrl %>/js/jquery-ui.js"></script>
      <script src="<%=appUrl %>/js/jquery.dataTables.min.js"></script>
      <script src="<%=appUrl %>/js/jsonmin.js"></script>
      
      
	  <link rel="stylesheet" href="<%=appUrl %>/css/jquery.signaturepad.css">
      <link href='https://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css'>
		<script src="<%=appUrl %>/js/numeric-1.2.6.min.js"></script> 
		<script src="<%=appUrl %>/js/bezier.js"></script> 
		<script src="<%=appUrl %>/js/jquery.signaturepad.js"></script> 
		<script src="<%=appUrl %>/js/groupsign.js"></script>
		<script type="text/javascript" src="<%=appUrl %>/js/bootstrap-filestyle.min.js"> </script>
		<link href="<%=appUrl %>/css/ui/fonts/Edwardian_Scr_ITC_TT.ttf" rel="stylesheet" type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="<%=appUrl %>/css/jquery.mloading.css">
		<script src="<%=appUrl %>/js/jquery.mloading.js"></script>
		
      <!--[if lt IE 9]>
      <script src="../assets/js/ie8-responsive-file-warning.js"></script>
      <![endif]-->
      <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      <script>
    //ajax display loader image start
      $(document).bind("ajaxStart.mine", function() {
    	//$('.loader').css('display', '');
      	//$('.loader').show();
    	  $("body").mLoading();
      });
	
      //ajax display loader image stop
      $(document).bind("ajaxStop.mine", function() {
      	//$('.loader').css('display', 'none');
         // $('.loader').hide();
    	  //$("body").mLoading();
    	  $("body").mLoading('hide');
    	  
    	  
    	 
      }); 
	
      function showtab(){
    	  var checkvalue=$("#checktab").val();
    	  if(checkvalue == 'true'){
    		  $('#img_lg').hide();
    		  $('#img_lg_m').show();
    		  $("#checktab").val('false');
    	  } else if(checkvalue == 'false'){
    		  $('#img_lg').show();
    		  $('#img_lg_m').hide();
    		  $("#checktab").val('true');
    	  }
      }
      </script>
      <style>
      .loader {
		
			position: fixed;
			left: 0px;
			top: 0px;
			width: 100%;
			height: 100%;
			z-index: 9999;
			background: url('<%=appUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgb(249,249,249);
		}
		
	
      </style>
   </head>
   <input type="hidden" id="checktab" value="true"/>
   <div class="loader" style="display:none"></div>
   <body class="nav-md">
      <div class="container body">
         <div class="main_container">
            <div class="col-md-3 left_col">
               <div class="left_col scroll-view">
                  <div class="navbar nav_title" style="border: 0;">
                     
                     <a href="#" id="img_lg" class="site_title"><img src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/images/logo.png" width="200px" height="auto" alt="Logo" title="Logo" /></a>
                      <a href="#" id="img_lg_m" style="display: none;" class="site_title"><img src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/images/logo_m.png" width="50px" height="auto" alt="Logo" title="Logo" /></a>
                  </div>
                  
                  
                  <div class="clearfix"></div>
                  <!-- menu prile quick info -->
                 <!--  <a href="profile">
                      <div class="profile">
                        <div class="profile_pic">
                           <img src="<%=picPath %>" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                           <span>Welcome,</span>
                           <h2>
                          <%--  <% if (registration != null) { %>
					 		<%=registration.getFirstName()%> 
						   <% } %>  --%>
                           </h2>
                        
                        </div>
                     </div>
                  </a>  -->
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
                           <li><a href="outforSignature"><i class="icon-completed-documents fontIcon"></i>&nbsp; OUT FOR SIGNATURE </a>
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
                        <a id="menu_toggle" onclick="showtab();"><i class="icon-menu"></i></a>&nbsp;&nbsp;&nbsp;<!-- <a href="#"><i class="icon-enlarge"></i></a> -->
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
                             
                              <li><a href="<%=appUrl %>/logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                              </li>
                           </ul>
                        </li>
                        
                     </ul>
                  </nav>
               </div>
            </div>
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col" style="background-color:#EBEBEB;" role="main">