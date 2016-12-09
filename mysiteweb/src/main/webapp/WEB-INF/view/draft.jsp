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
 <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper bg_wrap">
   <ol class="breadcrumb" style="background-color:#F1F0F0">
		  <li class="breadcrumb-item"><a href="#">DrySign</a></li>
		  <li class="breadcrumb-item active" style="color:#2c3d4f;">Draft</li>
		</ol>
    <img src="<%=appUrl %>/images/1.0/construction.jpg"/>DRAFT
  </div>
<jsp:include page="footer.jsp" />