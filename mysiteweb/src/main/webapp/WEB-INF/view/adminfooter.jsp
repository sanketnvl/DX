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
 
 <!-- /.content-wrapper -->
         <!-- Main Footer -->
      <!--    <footer class="main-footer">
            To the right
            <div class="social footer_div pull-right hidden-xs">
               <ul class="footer_ul">
                  <li><a href="#"><i class="fa fa-lg fa-facebook"></i></a></li>
                  <li><a href="#"><i class="fa fa-lg fa-twitter"></i></a></li>
                  <li><a href="#"><i class="fa fa-lg fa-google-plus"></i></a></li>
                  <li><a href="#"><i class="fa fa-lg fa-linkedin"></i></a></li>
               </ul>
            </div>
            Default to the left
            <strong>Copyright &copy; 2016 <a href="#">DrySign</a>.</strong> All rights reserved.
         </footer> -->
      </div>
      <!-- ./wrapper -->
      <!-- REQUIRED JS SCRIPTS -->
    <script src="<%=appUrl %>/js/ui/js/jquery.min.js"></script>
    <script src="<%=appUrl %>/js/ui/js/bootstrap.min.js"></script>
    <script src="<%=appUrl %>/js/jquery.dataTables.min.js"></script>
   	<script>
   	$(document).ready(function() {
   	 
   	// store url for current page as global variable
   		current_page = document.location.href
   	 	//alert(current_page);
	   	// apply selected states depending on current page
	   	if (current_page.match(/view/)) {
	   		
	   	$("ul#headernavigation li:eq(0)").addClass('active');
	   	} else if (current_page.match(/userlist/)) {
	   	$("ul#headernavigation li:eq(1)").addClass('active');
	   	} else if (current_page.match(/documenthistory/)) {
	   	$("ul#headernavigation li:eq(2)").addClass('active');
	   	}else if (current_page.match(/webservicelogs/)) {
	   	$("ul#headernavigation li:eq(3)").addClass('active');
	   	} /*  else if (current_page.match(/contact/)) {
	   	$("ul#headernavigation li:eq(4)").addClass('active');
	   	} */ else { // don't mark any nav links as selected
	   	$("ul#headernavigation li").removeClass('active');
	   	};
	   	 
	   	});
   	</script>
   </body>
</html>
