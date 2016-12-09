<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="en">
   <head>
      <title>DrySign-Registration</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="<c:url value="/css/ui/css/bootstrap.min.css" />" rel="stylesheet">
      <script src="<c:url value="js/ui/js/jquery.min.js" />"></script>
      <link href="<c:url value="css/ui/css/bootstrap.min.css"/>" rel="stylesheet">
      <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" href="<c:url value="css/ui/fonts/css/font-awesome.min.css" />">
       <link rel="stylesheet" href="<c:url value="css/login.css" />">
      
       <script src="<c:url value="js/jquery.validate.min.js"/>"></script>
     <!--  <style>
      .bg {
			    background: url(<c:url value="images/ui/images/24x7-support-service.jpg" />) -200px fixed;
			    background-size: cover;
			    -webkit-background-size: cover;
			    -moz-background-size: cover;
			    -o-background-size: cover;
			}
			.error{color:red !important;}
      </style> -->
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
			<img src="images/loginscroll-1.png" class="img-responsive" alt="image1" >
		  </div>

		  <div class="item">
			<img src="images/loginscroll-2.png" class="img-responsive"  alt="image2" >
		  </div>
		
		  <div class="item">
			<img src="images/loginscroll-3.png" class="img-responsive" alt="image3">
		  </div>

		</div>
		 
		 </div>
		 	
		 </div>
         <div class="login">
            <div class="wrapper-lg">
              <div class="text-center"><a href="index"><img class="iMg" src="<c:url value="images/ui/images/E-Sign_Square.png" />"  alt="Logo" title="Logo" /></a></div>
               <div class="login-info">
               		
               		<c:if test="${not empty msg}" >
  						<c:choose>
						    <c:when test="${msg=='1'}">
							<div class="alert alert-success fade in">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
    							Thank you for registering with DrySign. <br/><br/>

								You have been sent an email with a link to verify your account. Please click on this link to complete your registration with DrySign.   
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
               		
               		
               		
                   
                     
                     <form:form name="registration" action="registration" method="POST" class="login-form" role="form" id="register">
                            <p>Sign Up</p>
                           <div class="form-group has-feedback">
                              <label class="" for="form-username">First Name</label>        
                              <form:input path="firstName" value="${firstName}" placeholder="" class="form-username form-control"/>
    						  <form:errors path="firstName" class="sperrors"  />
                           </div>
                           <div class="form-group has-feedback">
                              <label class="" for="form-username">Last Name</label> 
                              <form:input path="lastname" value="${lastname}" placeholder="" class="form-username form-control" />
    						  <form:errors path="lastname" class="sperrors"  />
                              
                           </div>
                           <div class="form-group has-feedback">
                              <label class="" for="form-username">Email</label>
                              <form:input path="email" value="${email}" placeholder="" class="form-username form-control" />
    						  <form:errors path="email" class="sperrors"  />
                           </div>
                           <div class="form-group has-feedback">
                              <label class="" for="form-password">Password</label>
                              <form:password path="password" value="${password}"  placeholder="" class="form-password form-control" id="password"/>
                              <!-- <span id="result"></span> -->
    						  <form:errors path="password" class="sperrors"  />
                           </div>
                           <div class="form-group has-feedback">
                              <label class="" for="form-password">Confirm Password</label>
                              <form:password path="confirmpassword" value="${confirmpassword}" placeholder="" class="form-username form-control"/>
    						  <form:errors path="confirmpassword" class="sperrors" />
                           </div>
                           
                          
                     <div class="row">
                        <div class="col-md-12 text-right">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <button type="submit" class="btn myBtn" style="font: 18px roboto;color: #fff;max-width: 100%;width: 120px;">REGISTER</button>
                       </div>
                        <div class="col-md-12 user-pass">
                           <!-- <div class="col-xs-6 col-sm-6 col-md-6">			<a href="#" class="">Forgot username?</a></div>
                           <div class="col-xs-6 col-sm-6 col-md-6">			<a href="#" class="">Forgot password?</a> </div> -->
                        </div>
                     </div>
                           
                           
						    <!-- <a href="Dashboard.html" class="btn col-md-12 btn-warning"  style="padding:25px;border-radius:0;font-weight:bold;" role="button">GET STARTED</a> -->
 							
 	
 							<!-- <input name="submit" type="submit" value="GET STARTED" class="btn col-md-12 btn-warning"  style="padding:25px;border-radius:0;font-weight:bold;" role="button"> -->                       
                        </form:form>
                     
                  
               </div>
                  <div class="l-footer" style="margin-bottom: 12px;bottom:-60px;">
               <p>Already have account? <a href="login">Login</a></p>
               <!--  <div class="text-center"><img src="images/SourceHOV.png" alt="Logo" title="Logo"/></div> -->
            </div>
               
            </div>
          <!--   <div class="l-footer" style="margin-top:60px;">
               <p>Already have account? <a href="login">Login</a></p>
                <p>Copyright © 2016,SourceHOV</p>
            </div> -->
            
         </div>
      </section>
     <!-- Javascript -->
      <script src="<c:url value="js/ui/js/bootstrap.min.js"/>"></script>
      <!--[if lt IE 10]>
      <script src="<c:url value="assets/js/placeholder.js"/>"></script>
      <![endif]-->
      
      <script>

	$().ready(function() {

		$("#register").validate({
			rules: {
				firstName: "required",
				lastname: "required",
				username: {
					required: true,
					minlength: 2
				},
				password: {
					required: true,
					minlength: 8
				},
				confirmpassword: {
					required: true,
					minlength: 8,
					equalTo: "#password"
				},
				email: {
					required: true,
					email: true
				}

			},
			messages: {
				firstName: "Please enter your First Name",
				lastname: "Please enter your Last Name",
				username: {
					required: "Please enter a Username",
					minlength: "Your Username must consist of at least 2 characters"
				},
				password: {
					required: "Please provide a Password",
					minlength: "Your Password must be at least 8 characters long"
				},
				confirmpassword: {
					required: "Please provide a confirm Password",
					minlength: "Your Password must be at least 8 characters long",
					equalTo: "Please enter the same Password as above"
				},
				email: "Please enter a valid Email Address"

			},
			
			
			
		});


	});
	</script>
      
   </body>
</html>

