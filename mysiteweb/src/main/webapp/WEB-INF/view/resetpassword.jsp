<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
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
       <title>DrySign Reset Password</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      
      <link href="<%=appUrl %>/css/ui/css/bootstrap.min.css" rel="stylesheet">
      <script src="<%=appUrl %>/js/ui/js/jquery.min.js"></script>
      <link href="<%=appUrl %>/css/ui/css/bootstrap.min.css" rel="stylesheet">
      <script src="<%=appUrl %>/js/jquery.min.js"></script>
      <link rel="stylesheet" href="<%=appUrl %>/css/ui/fonts/css/font-awesome.min.css">
      <link rel="stylesheet" href="<%=appUrl %>/css/login.css">
     <%--  <style>
      .bg {
			    background: url(<%=appUrl %>/images/ui/images/24x7-support-service.jpg) -200px fixed;
			    background-size: cover;
			    -webkit-background-size: cover;
			    -moz-background-size: cover;
			    -o-background-size: cover;
			}
			.error{color:red !important;}
      </style> --%>
       <style>
		  .carousel-inner > .item > img,
		  .carousel-inner > .item > a > img {
			  width: 100%;
			  margin: auto;
			  height:100vh;
		  }
		     .carousel-inner>.item {
	    -webkit-transition: 0.5s ease-in-out left;
	    transition: 0.2s ease-in-out left;
	    -webkit-transition: 0.5s, ease-in-out, left;
	    -moz-transition: .5s, ease-in-out, left;
	    -o-transition: .5s, ease-in-out, left;
	    transition: .5s, ease-in-out, left;
	    }
	    
	    .error{color:red !important;}
	  </style>
   </head>
   <body class="bg">
      <section>
         <div class="loginA">
			 <div id="myCarousel" class="carousel slide" data-ride="carousel">
			 	<!-- Indicators -->
			<ol class="carousel-indicators">
			  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			  <li data-target="#myCarousel" data-slide-to="1"></li>
			  <li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
	
			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
			  <div class="item active">
				<img src="<%=appUrl %>/images/loginscroll-1.png" class="img-responsive" alt="image1" >
			  </div>
	
			  <div class="item">
				<img src="<%=appUrl %>/images/loginscroll-2.png" class="img-responsive"  alt="image2" >
			  </div>
			
			  <div class="item">
				<img src="<%=appUrl %>/images/loginscroll-3.png" class="img-responsive" alt="image3">
			  </div>
	
			</div>
			 
			 </div>
		 	
		 </div>
         <div class="login">
            <div class="wrapper-lg">
               <div class="text-center"><a href="<%=appUrl %>/index"><img src="<%=appUrl %>/images/ui/images/E-Sign_Square.png" width="160" height="auto" alt="Logo" title="Logo" /></a></div>
               
               <div class="login-info">
               
          		
               <c:if test="${not empty msg}" >
  						<c:choose>
						    <c:when test="${msg=='1'}">
							<div class="alert alert-success fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							Your password has been reset, Kindly login to continue.
    							
							</div> 						       
						    </c:when>    
						    <c:otherwise>
							<div class="alert alert-danger fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							${msg }
    						</div>
						    </c:otherwise>
						</c:choose>
              </c:if>
               
               
               
                <c:if test="${not empty flag}" >
  						<c:choose>
						    <c:when test="${flag=='1'}">
								
							<c:if test="${msg ne 1 }">
							               <form:form name="resetpassword" action="resetpassword" method="POST" class="login-form" role="form">                           
							                           <p>Reset Password</p>
							                           <div class="form-group has-feedback">
							                              <label class="" for="form-password">Password</label>
							                              <!-- <input type="password" name="form-password" placeholder="Password" class="form-password form-control" id="form-password"> -->
							                              <form:password path="password" value="${password}"  placeholder="" class="form-password form-control" id="form-password"/>
							    						  <form:errors path="password" class="error"  />
							                           </div>
							                           <div class="form-group has-feedback">
							                              <label class="" for="form-password">Confirm Password</label>
							                              <!-- <input type="password" name="form-password" placeholder="Confirm Password" class="form-password form-control" id="form-password"> -->
							
							                              <form:password path="confirmpassword" value="${confirmpassword}" placeholder="" class="form-username form-control" id="form-username"/>
							    						  <form:errors path="confirmpassword" class="error" />
							                           </div>
													    <!-- <a href="Dashboard.html" class="btn col-md-12 btn-warning"  style="padding:25px;border-radius:0;font-weight:bold;" role="button">GET STARTED</a> -->
							 							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							 							<form:hidden path="email" value="${email}"/>
							 							<form:hidden path="userid" value="${userid}"/>
							 							<form:hidden path="token" value="${token}"/>
							 					<div class="row">
							                        <div class="col-md-12 text-right">  <button type="submit" class="btn myBtn" style="font: 18px roboto-Regular;color: #fff;max-width: 100%;width: 180px;">RESET PASSWORD</button></div>
							                        
							                     </div>
							 							                       
							                </form:form>
							</c:if>								
											       
						    </c:when>    
						    <c:otherwise>
							<div class="alert alert-danger fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							Invalid reset password link.
    						</div>
						    </c:otherwise>
						</c:choose>
              </c:if>
               
               
               
               
                  
               </div>
            </div>
            <div class="l-footer">
               <p>Login here? <a href="<%=appUrl %>/login">Login</a></p>
              <!--  <div class="text-center"><img src="<%=appUrl %>/images/SourceHOV.png" alt="Logo" title="Logo"/></div> -->
          
            </div>
         </div>
      </section>
      
      
      
   <script src="<%=appUrl %>/js/ui/js/bootstrap.min.js"></script>
   <script src="<%=appUrl %>/js/ui/js/nicescroll/jquery.nicescroll.min.js"></script>
   <script src="<%=appUrl %>/js/ui/js/custom.js"></script>
      
      

      
   </body>
</html>

