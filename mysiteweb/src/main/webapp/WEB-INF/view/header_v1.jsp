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
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>DrySign - document Self</title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="<%=appUrl %>/css/1.0/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="<%=appUrl %>/css/1.0/fileinput.css" media="all" rel="stylesheet" type="text/css" />
<!-- custom style -->
<link rel="stylesheet" href="<%=appUrl %>/css/1.0/icons.css">
<link rel="stylesheet" href="<%=appUrl %>/css/1.0/drysign1.0.css">

<!--  data tables -->
<link href="<%=appUrl %>/css/1.0/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
<script src="<%=appUrl %>/js/1.0/jquery.min.js"></script>
<script src="<%=appUrl %>/js/1.0/jquery.dataTables.min.js"></script>
<style>
.loader {
          position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=appUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
        }
</style>
</head>
<div class="loader"></div>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper"> 
  <!-- Main Header -->
<header class="main-header"> 
  <!-- Logo --> 
  <a href="#" class="logo"> 
  <!-- mini logo for sidebar mini 50x50 pixels --> 
  <span class="logo-mini"><b>D</b>S</span> 
  <!-- logo for regular state and mobile devices --> 
  <span class="logo-lg"><img class="img-responsive" src="<%=appUrl %>/images/1.0/drysignlogo.png" height="auto"  alt="logo"> </span> </a> 
  <!-- Header Navbar -->
  <nav class="navbar navbar-static-top" role="navigation"> 
    <!-- Sidebar toggle button--> 
    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span class="sr-only">Toggle navigation</span> </a> 
    <!-- Navbar Right Menu -->
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
       <!--  <li class="dropdown notifications-menu"> 
          Menu toggle button 
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-notification" style="color:#fff;font-size:22px;"></i> <span class="label label-warning">10</span> </a>
          <ul class="dropdown-menu">
            <li class="header">You have 10 notifications</li>
            <li> 
              Inner Menu: contains the notifications
              <ul class="menu">
                <li> 
                  start notification 
                  <a href="#"> <i class="fa fa-users text-aqua"></i> 5 new members joined today </a> </li>
                end notification
              </ul>
            </li>
            <li class="footer"><a href="#">View all</a></li>
          </ul>
        </li> -->
        <li><a href="#">  <% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %></a></li>
        <li> 
          <a href="<%=appUrl %>/logout" class="dropdown-toggle"> <i class="icon-log-out" style="color:#fff;font-size:22px;"></i><span style="color:#fff;font-size:14px;position:relative;top:-6px;left:10px;">Log out</span> </a> 
        </li>
      </ul>
    </div>
  </nav>
</header>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar"> 
  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar"> 
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel">
      <%-- <div class="pull-left image"> <img src="<%=appUrl %>/images/1.0/user2-160x160.jpg" class="img-circle" alt="User Image"> </div>
      <div class="pull-left info">
        <p>Alex Waugh</p>
        <!-- Status --> 
        <a href="#"><i class="fa fa-circle text-success"></i> Online</a> </div> --%>
    </div>
    <!-- Sidebar Menu -->
    <ul id="headernavigation" class="sidebar-menu">
      <li><a href="web"><i class="icon-dashboard"></i>&nbsp;&nbsp;<span>DASHBOARD</span></a></li>
      <li><a href="document"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>DOCUMENT</span></a></li>
      <li><a href="outforSignature"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>OUT FOR SIGNATURE</span></a></li>
      <li><a href="completedDocuments"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>COMPLETED DOCUMENTS</span></a></li>
      <li><a href="draft"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>DRAFT</span></a></li>
     
    </ul>
    <!-- /.sidebar-menu --> 
  </section>
  <!-- /.sidebar --> 
</aside>