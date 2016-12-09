<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ page import="com.myexample.model.Registration, org.springframework.security.core.context.SecurityContextHolder, org.springframework.security.core.Authentication" %>

<!DOCTYPE html>
<html lang="en">
   <head>
       <title>DrySign-Login</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      
      <link href="<c:url value="/css/ui/css/bootstrap.min.css" />" rel="stylesheet">
      <script src="<c:url value="js/ui/js/jquery.min.js" />"></script>
      <link href="<c:url value="css/ui/css/bootstrap.min.css"/>" rel="stylesheet">
      <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" href="<c:url value="css/ui/fonts/css/font-awesome.min.css" />">
      <link rel="stylesheet" href="<c:url value="css/login.css" />">
      <link href="<c:url value="css/buttonLoader.css" />" rel="stylesheet">
      
      <!-- <style>
      .bg {
			    background: url(<c:url value="images/loginscroll-3.png" />) -200px fixed;
			    background-size: cover;
			    -webkit-background-size: cover;
			    -moz-background-size: cover;
			    -o-background-size: cover;
			    width: 100%;
			    margin: auto;
			    height: 100vh;
			}
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
   <body>
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
                
          		<% String username = ""; %>
               			<c:if test="${not empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}" >
               			<div class="alert alert-danger fade in">
						    <a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>

						   
						     <c:set var="errormsg" value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}"/>
							 <%
							    String errormsgstr = (String)pageContext.getAttribute("errormsg");  
							 	String[] errMsgArray = errormsgstr.split(",");
							 	username = errMsgArray[0];
							 	out.print(errMsgArray[1]);
							  %>  
						    
						 <c:remove var = "SPRING_SECURITY_LAST_EXCEPTION" scope = "session" />    
						</div> 
               			</c:if>
               
               
                  <form name="f" action="j_spring_security_check.action" method="POST" role="form">
                   <p>Sign In</p>
                     <div class="form-group has-feedback">
                        <label>Email</label>
                        <input type="text" placeholder="" class="form-control" name="username" id="form-username" value="<%=username%>">
                     </div>
                     <div class="form-group has-feedback">
                        <div class="input-group">
                           <label>Password</label>
		                   <!--  <i onclick="toggle_password('form-password')" id="showhide" class="fa fa-eye pull-right"  aria-hidden="true"></i> -->
<!-- 							<i class="fa fa-eye pull-right" data-toggle="password"></i> -->
                           <input type="password" placeholder="" class="form-control" name="password"  id="form-password" data-toggle="password">
                            <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						    
                        </div>
                     </div>
                     <!-- <div class="row">
                        <div class="col-xs-12">
                           <div class="checkbox checkbox-primary">
                              <input type="checkbox" id="checkbox2">
                              <label for="checkbox2"> Remember Me </label>
                           </div>
                        </div>
                     </div> -->
                     <div class="row">
                        <div class="col-md-12 text-right">  <button type="submit" class="btn myBtn" style="font: 18px roboto-Regular;color: #fff;max-width: 100%;width: 100px;">LOGIN</button></div>
                        <div class="col-md-12 user-pass">
                           <!-- <div class="col-xs-6 col-sm-6 col-md-6">			<a href="#" class="">Forgot username?</a></div> -->
                           <div class="col-xs-6 col-sm-6 col-md-6 text-left" style="padding:0px;">	<a href="#" class="link1" onclick="forgotPasswordModel()">Forgot your password?</a>	 </div>
                           <div class="col-xs-6 col-sm-6 col-md-6 text-right" style="padding:0px;">	<a href="termsandconditions" class="link1">Terms & Conditions</a>	 </div>
                        </div>
                     </div>
                     <!-- /.col -->
                     
          
                  </form>
               </div>
                     <div class="l-footer" style="margin-bottom:12px;padding-top:50px;bottom: -260px;">
               <p>Need an account? <a href="registration">Register</a></p>
            <!--   <div class="text-center"><img src="images/SourceHOV.png" alt="Logo" title="Logo"/></div>  -->
            </div>
            </div>
         
         </div>
      </section>
      
      
      
      
      
      
      <div class="modal fade" id="forgotpwdModel" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content" style="position: relative;left: -157px;top: 100px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Forgot Password</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<div class="col-xs-12">
							<div class="alert alert-danger fade in" style="display:none;text-align:center;margin: 0px;" id="forgotpwdModelalert">
						    	<a class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
								<div id="forgotpwdmessage"></div>
							</div> 
							<div class="alert alert-success" style="display:none;" id="forgotpwdModelsuccessalert">
						    	<a  class="close" data-hide="alert" aria-label="close" onclick="$(this).parent().hide();">&times;</a>
						    	<div id="forgotpwdsuccessmessage"></div>
						  	</div> 
							<input type="email" class="form-control" id="forgotemail" placeholder="Enter your email here" style="margin-top: 5px;"/>
								
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				
<!-- 				<button type="button" class="btn btn-primary bTN" onclick="forgotPassword()">Submit</button>
 -->
 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
 <a href="#" id="frgtbtn" class="btn" role="button" onclick="forgotPassword()" style="color: white;background-color: #337ab7;border-color: #2e6da4;">Send Reset E-mail</a>			
 </div>
		</div>
	</div>
</div>
      
      
      
      
      

      
      
   <script src="<c:url value="js/ui/js/bootstrap.min.js" />"></script>
   <script src="<c:url value="js/bootstrap-show-password.js" />"></script>
   <script src="<c:url value="js/ui/js/nicescroll/jquery.nicescroll.min.js" />"></script>
   <script src="<c:url value="js/ui/js/custom.js" />"></script>
   <script src="<c:url value="js/jquery.buttonLoader.js" />"></script>

<script>

	function forgotPasswordModel()
	{
		$("#forgotpwdModelsuccessalert").hide();
		$("#forgotemail").show();
		$("#frgtbtn").show();
		$("#forgotpwdModelalert").hide();
		$("#forgotpwdmessage").html("");
		$("#forgotemail").val("");
		$('#forgotemail').attr('value','');
		$('#forgotpwdModel').modal('show');
	}
  
	function forgotPassword() 
	{
		$("#forgotpwdModelsuccessalert").hide();
		$("#forgotemail").show();
		$("#frgtbtn").show();
		$("#forgotpwdModelalert").hide();
		$("#forgotpwdmessage").html("");
		var forgotemail = $('#forgotemail');

		if (forgotemail.val() != "" && forgotemail.val().trim() != "") {

			$("#forgotpwdmessage").html("");
		} else {
			forgotemail.focus();
			$("#forgotpwdModelalert").show();
			$("#forgotpwdmessage").html("Enter your registered email.");
			return false;
		}
		
		

		$.ajax({
			type : "POST",
			url : "app/ajax/forgotpassword",
			data : {
				"forgotemail" : forgotemail.val().trim()
			},
			beforeSend : function() {
				$("#forgotpwdmessage").html("loading..");
				$('#frgtbtn').buttonLoader('start');
			},
			complete : function() {
				$("#frgtbtn").buttonLoader('stop');
			},
			success : function(response) {
				
				if(response == 1){
					$("#forgotpwdModelsuccessalert").show();
					$("#forgotemail").hide();
					$("#frgtbtn").hide();
					$("#forgotpwdsuccessmessage").html("A link to reset your password has been sent to your email ID. Please check your email. Thank you.");
				}else{
					$("#forgotpwdModelalert").show();
					$("#forgotpwdmessage").html(response);

				}

			}
		});
	}
</script>
      
   </body>
</html>

