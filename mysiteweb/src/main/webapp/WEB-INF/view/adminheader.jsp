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
      <title>DrySign - Dashboard</title>
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
      <link href="<%=appUrl %>/css/ui/css/bootstrap.min.css" rel="stylesheet">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
      <!-- custom style -->
      <link rel="stylesheet" href="<%=appUrl %>/css/drysign.css">
      <%-- <link rel="stylesheet" href="<%=appUrl %>/css/icons.css"> --%>
      <%-- <link rel="stylesheet" href="<%=appUrl %>/css/admindashboard.css"> --%>
      <link href="<%=appUrl %>/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
      <%-- <link rel="stylesheet" href="<%=appUrl %>/css/admindashboard.css"> --%>
      
   </head>
   <body class="hold-transition skin-blue sidebar-mini">
   <input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
      <div class="wrapper">
         <!-- Main Header -->
         <header class="main-header">
            <!-- Logo -->
            <a href="#" class="logo">
               <!-- mini logo for sidebar mini 50x50 pixels -->
               <span class="logo-mini"><b>D</b>S</span>
               <!-- logo for regular state and mobile devices -->
               <span class="logo-lg"><img src="<%=appUrl %>/images/logo.png" width="110" height="38" alt="Logo" title="Logo" /></span>
            </a>
            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
               <!-- Sidebar toggle button-->
               <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
               <span class="sr-only">Toggle navigation</span>
               </a>
               <!-- Navbar Right Menu -->
               <div class="navbar-custom-menu">
                  <ul class="nav navbar-nav">
                     <!-- Notifications Menu 
                     <li class="dropdown notifications-menu">
                     
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-bell-o"></i>
                        <span class="label label-warning">10</span>
                        </a>
                        <ul class="dropdown-menu">
                           <li class="header">You have 10 notifications</li>
                           <li>
                             
                              <ul class="menu">
                                 <li>
                                    
                                    <a href="#">
                                    <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                    </a>
                                 </li>
                                 
                              </ul>
                           </li>
                           <li class="footer"><a href="#">View all</a></li>
                        </ul>
                     </li>-->
                     <!-- User Account Menu -->
                     <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                       <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                           <!-- The user image in the navbar-->
                           <img src="<%=appUrl %>/images/user2-160x160.jpg" class="user-image" alt="User Image">
                           <!-- hidden-xs hides the username on small devices so only the image appears. -->
                           <span class="hidden-xs"><% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %> </span>
                        </a> 
                        <ul class="dropdown-menu">
                           <!-- The user image in the menu -->
                           <li class="user-header">
                              <img src="<%=appUrl %>/images/user2-160x160.jpg" class="img-circle" alt="User Image">
                              <p>
                                <% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %>
                                 <!-- <small>Member since Nov. 2012</small> -->
                              </p>
                           </li>
                           <!-- Menu Footer-->
                           <li class="user-footer">
                              <div class="pull-left">
                                 <a href="#" class="btn btn-default btn-flat">Profile</a>
                              </div>
                              <div class="pull-right">
                                 <a href="#" class="btn btn-default btn-flat">Sign out</a>
                              </div>
                           </li>
                        </ul>
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
                  <div class="pull-left image">
                    <%--  <img src="<%=appUrl %>/images/user2-160x160.jpg" class="img-circle" alt="User Image"> --%>
                  </div>
                  <div class="pull-left info">
                    <!--  <p><% if (registration != null) { %>
					 		<%=registration.getFirstName()%> <%=registration.getLastname()%> 
						   <% } %> </p>
                  
                     <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
                  </div>
               </div>
               <!-- Sidebar Menu -->
               <ul id="headernavigation" class="sidebar-menu">
                  <li><a href="view"><i class="icon-dashboard"></i>&nbsp;&nbsp;<span>Dashboard</span></a></li>
                  <li><a href="userlist"><i class="icon-dashboard"></i>&nbsp;&nbsp;<span>Users</span></a></li>
                  <li><a href="documenthistory"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>Documents</span></a></li>
                  <li><a href="webservicelogs"><i class="icon-completed-documents"></i>&nbsp;&nbsp;<span>WebService Logs</span></a></li>
               </ul>
               <!-- /.sidebar-menu -->
            </section>
            <!-- /.sidebar -->
         </aside>