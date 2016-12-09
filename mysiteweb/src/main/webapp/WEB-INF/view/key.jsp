<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <jsp:include page="outer_header.jsp" />
 
<style>
header{background: white;}
.navbar {min-height: 100px;background: #d4d4d4 !important;color: #333;}
.navbar-default .nav > li>a, .navbar-default .nav>li>a:focus {color: #292626 !important;}
</style>
<section>
      <style>
	body {
	  min-height: 2000px;
	  padding-top: 70px;
	}
	.error {
	    color:red;
	}	
	
	</style>

	 <script src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/jquery.min.1.12.4.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/css/jquery.minicolors.css">
  	<script type="text/javascript" src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/jquery.minicolors.min.js"></script>
     <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
     <script type= "text/javascript" src = "<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/js/countries.js"></script>
     <link href="<c:url value="css/buttonLoader.css" />" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
 <input type="hidden" id="contextPath" value="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/"/>
    <!-- Fixed navbar -->
<!--     <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">DrySign</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="../navbar/">Default</a></li>
            <li><a href="../navbar-static-top/">Static top</a></li>
            <li class="active"><a href="./">Fixed top <span class="sr-only">(current)</span></a></li>
          </ul>
        </div>/.nav-collapse
      </div>
    </nav> -->

    <div class="container">

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h3><strong>REST API Development center</strong></h3>
        <p>DrySign is an application which provides electronic signature technology 
        <br>
        and Digital Transaction Management (DTM) services in order to facilitate electronic exchange of contracts and signed documents. 
        </p>
       
        <p class="text-center">
          <a class="btn btn-lg btn-primary" href="#" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target=".bs-example-modal-lg" role="button">Get An API key</a>
        </p>
        
        
      </div>
      
      <div class="row">
		 
		 <!--  <div class="col-md-8">
		  	 <table class="table table-bordered">
			    <thead>
			      <tr>
			        <th>Firstname</th>
			        <th>Lastname</th>
			        <th>Email</th>
			      </tr>
			    </thead>
			    <tbody>
			      <tr>
			        <td>John</td>
			        <td>Doe</td>
			        <td>john@example.com</td>
			      </tr>
			      <tr>
			        <td>Mary</td>
			        <td>Moe</td>
			        <td>mary@example.com</td>
			      </tr>
			      <tr>
			        <td>July</td>
			        <td>Dooley</td>
			        <td>july@example.com</td>
			      </tr>
			    </tbody>
			  </table>
		  </div>
		   <div class="col-md-4">.</div> -->
		   
		    <h2>DrySignJavaSDK.jar</h2>
		    <hr>
            <p style="font-size: 18px;">To start using the DrySign Java SDK, download the jar file <br>
            from https://drysign.me/download/DrySignJavaSDK.jar add it to the class path.<br><br>
            After importing the jar file you can create a java class with main method. Initialize the Config as shown in the examples. <br>
        	pass the client id and client secret you received.
            </p>
		   
		   
		   <h3>Request Token</h3>
		   <hr>
		   <div style='background:#FFFFFF; font-family: Courier New, Courier; font-size: 10pt; COLOR: #000000; padding-bottom: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px;'><strong><font color='#7f0055'>public</font></strong>&nbsp;<strong><font color='#7f0055'>void</font></strong>&nbsp;requestToken(){
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;String&nbsp;randomEmail&nbsp;=&nbsp;&nbsp;<font color='#2a00ff'>"xyz@gmail.com"</font>&nbsp;;
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User&nbsp;user=<strong><font color='#7f0055'>new</font></strong>&nbsp;User();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user.setEmail(randomEmail);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user.setPassword(<font color='#2a00ff'>"fakePassword"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Config&nbsp;config&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;Config(&nbsp;<font color='#2a00ff'>"Your&nbsp;Client&nbsp;Id"</font>&nbsp;,&nbsp;<font color='#2a00ff'>"Your&nbsp;Client&nbsp;Secret"</font>&nbsp;);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UserManager&nbsp;userManager=<strong><font color='#7f0055'>new</font></strong>&nbsp;UserManager();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Oauth2Token&nbsp;requestedToken=userManager.getToken();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;System
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.out.println(&nbsp;<font color='#2a00ff'>"Access&nbsp;Token"</font>&nbsp;
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+&nbsp;requestedToken.getAccessToken());
<br/>&nbsp;&nbsp;&nbsp;&nbsp;}<div style='text-align:right;BORDER-TOP: #ccc 1px dashed'></div></div>
	  </div>
      
      
       <h3>Create Document</h3>
		   <hr>
<div style='background:#FFFFFF; font-family: Courier New, Courier; font-size: 10pt; COLOR: #000000; padding-bottom: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px;'>&nbsp;&nbsp;&nbsp;&nbsp;
<br/>&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color='#7f0055'>public</font></strong>&nbsp;<strong><font color='#7f0055'>void</font></strong>&nbsp;createAndUpdateDocument()&nbsp;{
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DrySignClient&nbsp;client&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;DrySignClient();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Document&nbsp;document&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;Document();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document.setFilePath(<font color='#2a00ff'>"D:/PDF/exam_reg_form.pdf"</font>);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='#3f7f5f'>//&nbsp;create&nbsp;document
</font><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document&nbsp;=&nbsp;client.createDocument(document);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document.setSignerEmail(<font color='#2a00ff'>"abc@gmail.com"</font>);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;System.out.println(<font color='#2a00ff'>"EnvelopeID&nbsp;:&nbsp;"</font>&nbsp;+&nbsp;document.getEnvelopeId());
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='#3f7f5f'>//&nbsp;Field&nbsp;for&nbsp;name
</font><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DocumentField&nbsp;documentField&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;DocumentField();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setFieldType(<font color='#2a00ff'>"text"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setFieldName(<font color='#2a00ff'>"name"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setxPosition(100);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setyPosition(100);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setFieldHeight(20);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setFieldWidth(200);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;documentField.setPageNumber(1);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='#3f7f5f'>//&nbsp;Field&nbsp;for&nbsp;date
</font><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DocumentField&nbsp;date&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;DocumentField();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setFieldType(<font color='#2a00ff'>"text"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setFieldName(<font color='#2a00ff'>"date"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setxPosition(200);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setyPosition(200);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setFieldHeight(20);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setFieldWidth(200);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;date.setPageNumber(1);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='#3f7f5f'>//&nbsp;Field&nbsp;for&nbsp;sign
</font><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DocumentField&nbsp;sign&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;DocumentField();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setFieldType(<font color='#2a00ff'>"image"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setFieldName(<font color='#2a00ff'>"sign"</font>);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setxPosition(300);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setyPosition(300);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setFieldHeight(40);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setFieldWidth(200);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sign.setPageNumber(1);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;List<DocumentField>&nbsp;fieldList&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;ArrayList<DocumentField>();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fieldList.add(documentField);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fieldList.add(date);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fieldList.add(sign);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document.setDocumentFields(fieldList);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='#3f7f5f'>//&nbsp;update&nbsp;Document
</font><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document&nbsp;=&nbsp;client.updateDocument(document);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;System.out.println(document);
<br/>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;}
<br/>&nbsp;&nbsp;&nbsp;&nbsp;<div style='text-align:right;BORDER-TOP: #ccc 1px dashed'></div></div> 


		   <h3>Download Document</h3>
		   <hr>
		   <div style='background:#FFFFFF; font-family: Courier New, Courier; font-size: 10pt; COLOR: #000000; padding-bottom: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px;'><strong><font color='#7f0055'>public</font></strong>&nbsp;<strong><font color='#7f0055'>void</font></strong>&nbsp;downloadDocument(String&nbsp;documentId){
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DrySignClient&nbsp;client&nbsp;=&nbsp;<strong><font color='#7f0055'>new</font></strong>&nbsp;DrySignClient();
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color='#7f0055'>boolean</font></strong>&nbsp;flag&nbsp;=&nbsp;client.downloadDocument(documentId);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;System.out.println(<font color='#2a00ff'>"Download:&nbsp;"</font>+&nbsp;flag);
<br/>&nbsp;&nbsp;&nbsp;&nbsp;}<div style='text-align:right;BORDER-TOP: #ccc 1px dashed'></div></div>
      <hr>
    </div> <!-- /container -->

	<!-- Pop up -->
	<div class="modal fade bs-example-modal-lg" id="modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	     	<div class="modal-header">
		        <button type="button" class="close" onclick="hideClose();" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title"><strong>Get An API Key</strong></h4>
		      </div>
		      <div class="modal-body">
		       	<div class="row">
				  <div class="col-md-1"></div>
				  <div class="col-md-10">
		
					
           			<div id="success-alert" class="alert alert-success hidden" role="alert">
				     <button type="button" class="close" data-dismiss="alert" aria-label="Close">    
				        <span aria-hidden="true">&times;</span>
				     </button> 
				     <span id="successMsg"></span>
				    </div>
				    <div id="error-alert" class="alert alert-danger hidden" role="alert">
				     <button type="button" class="close" data-dismiss="alert" aria-label="Close">    
				        <span aria-hidden="true">&times;</span>
				     </button> 
				     <span id="errorMsg"></span>
				    </div>
              		
					<form:form commandName="command" class="form-horizontal" action="formregisterkey" method="post" id="formregisterkey">
					 <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">First Name*</label>
					    <div class="col-sm-10">
					      <!-- <input type="text" class="form-control" name="firstName" id="firstName" placeholder="FirstName"> -->
					     <form:input path="firstName" value="${firstName}" placeholder="FirstName" class="form-control"/>
					  	</div>
					  </div>
					   <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">Last Name*</label>
					    <div class="col-sm-10">
					       <form:input path="lastname" value="${lastname}" placeholder="LastName" class="form-control"/>
					  	</div>
					  </div>
					   <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">Email*</label>
					    <div class="col-sm-10">
					      <form:input path="email" value="${email}" placeholder="Email" class="form-control"/>
					  	  </div>
					  </div>
					   <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">Mobile*</label>
					    <div class="col-sm-10">
					      <form:input path="phone" value="${phone}" placeholder="Mobile" class="form-control" maxlength="10"/>
					  	</div>
					  </div>
					   <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">Country*</label>
					    <div class="col-sm-10">
					      <form:select path="country"  placeholder="Country" class="form-control"/>
					  	 </div>
					  </div>
					  <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">State*</label>
					    <div class="col-sm-10">
					      <form:select path="state" id="state"  placeholder="State" class="form-control"/>
					  	 </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">Zip Code*</label>
					    <div class="col-sm-10">
					      <form:input path="pincode" value="${pincode}" placeholder="zip code" class="form-control"/>
					  	 </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">Company*</label>
					    <div class="col-sm-10">
					      <form:input path="companyName" value="${companyName}" placeholder="Company" class="form-control"/>
					  	 </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">ProjectName*</label>
					    <div class="col-sm-10">
					      <form:input path="project" value="${project}" placeholder="ProjectName" class="form-control"/>
					  <%-- 	    <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
				 --%>	    </div>
					  </div>
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">Theme</label>
					    <div class="col-sm-4">
					      <form:input path="theme" id="hue-demo" value="#b01919" placeholder="Theme" class="form-control demo"/>
					  <%-- 	    <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
				 --%>	    </div>
				 <div class="col-sm-6">
				
				 </div>
					  </div>
	
					     <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">Link</label>
					    <div class="col-sm-10">
					    Do you want register your signer(s) with DrySign ?<br>
					    	<form:select path="linktodrysign" id="linktodrysign"  placeholder="linktodrysign" class="form-control">
					    		<option value="YES" selected>YES</option>
					    		<option value="NO">NO</option>
					    	</form:select>
					       
					  <%-- 	    <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
				 --%>	    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					      <div class="checkbox">
					        <label>
					       <!--    <input type="checkbox"> Accept terms and conditions -->
					        </label>
					      </div>
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					    	<input id="submitId" type="submit" class="btn btn-primary has-spinner" value="Get API Key">
					    	<input type="button" class="btn btn-warning" onclick="hideClose();"  value="Close">
					    </div>
					  </div>
					</form:form>
				  </div>
				  <div class="col-md-1"></div>
				  
				</div>
		      </div>
		      <div class="modal-footer">
		      <!--   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
		       
		     </div>
	    </div>
	  </div>
	</div>
	</section>
	<!-- Modal -->
<div class="modal fade bs-example-modal-sm" id="successMessage" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" style="margin:220px auto" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background: #e1e1e1;border-radius: 4px;">
      	
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title">Message</h4>
	  </div>
      <div class="modal-body">
      	<div class="alert alert-success" role="alert">You have successfully registered with DrySign.Your credentials sent on your Email ID</div>
      </div>
      <div class="modal-footer">
        <button type="button" onclick="closeBar();" class="btn btn-primary">OK</button>
        
      </div>
    </div>
  </div>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
	 <!-- Bootstrap Core JavaScript -->
<script src="<c:url value="js/ui/index/js/bootstrap.min.js"/>"></script>
      
 <script type="text/javascript">
 function hideClose(){
	 document.getElementById("formregisterkey").reset(); 	
	 $('#modal').modal('hide');
	 $("#formregisterkey").validate().resetForm();
	 $('.error').removeClass("error");

   
 }

$('#state').append('<option value="" selected="selected">Select State</option>');

populateCountries("country", "state"); 
function closeBar(){
	var contextPath=$("#contextPath").val();
	window.location.href=contextPath+'login';
}
	$(document).ready(function() {
 
		$('#formregisterkey').submit(function(e) {
			$("#errorMsg").val("");
			var frm = $('#formregisterkey');
			e.preventDefault();
 
			var valid = $("#formregisterkey").valid();
			 if(valid == true){
				    var data = {}
				    var Form = this;
				    
				    //Gather Data also remove undefined keys(buttons)
				    $.each(this, function(i, v){
				            var input = $(v);
				        data[input.attr("name")] = input.val();
				        delete data["undefined"];
				    });
		        $.ajax({
		            contentType : 'application/json; charset=utf-8',
		            type: frm.attr('method'),
		            url: frm.attr('action'),
		            crossDomain: true,
		            dataType : 'json',
		            data : JSON.stringify(data),
		            beforeSend : function() {
						$('#submitId').buttonLoader('start');
				    },
				    complete : function() {
						$("#submitId").buttonLoader('stop');
					},
		            success : function(callback){
		            	//alert("Response :"+callback.msg);
		            	$("#errorMsg").val('');
		            	$("#successMsg").val('');
		            	$("#success-alert").addClass('hidden');
		            	$("#error-alert").addClass('hidden');
		                if(callback.msg== '1' || callback.msg== 1){
		                	$("#success-alert").toggleClass("hidden");
		                	$('#successMessage').modal('show');
		                	$('#success-alert').hide();
		                	//$("#successMsg").html('You have successfully registered.Please verify your account by email.');
		                }else{
		                	$("#error-alert").toggleClass("hidden");
		                	$("#errorMsg").html(callback.msg);
		                	if(callback.msg =="This Email is Already exists."){
		                		
		                	}else{
		                	document.getElementById("formregisterkey").reset();
		                	}
		                }
		                
		                
		            },
		            error : function(){
		                $(this).html("Error!");
		            }
		        });
			 }
		});
		
		$("#formregisterkey").validate({
	 		 errorElement:'div',
	         rules: {
	         	firstName: {
	         		required: true,
	         		lettersonly: true 
	         		},
	            lastname: {
	             		required: true,
	             		lettersonly: true 
	             	},
	            email: {
	             		required: true,
	             		email: true
	             	},
	            phone: {
	             		required: true,
	             		number: true,
	             		minlength: 10,
	             		maxlength:10,
	             	},
	            country: {
	              		required: true,
	              	}, 	
	            state: {
	               		required: true,
	               	},
	            pincode: {
	               		required: true,
	               		number: true
	               	}, 
	            companyName: {
	               		required: true,
	               	},
	             project: {
	               		required: true,
	               	} 	
	             	
	         	
	         },
	         messages: {
	        	 firstName: "Please enter your First Name",
	        	 lastname: "Please enter your Last Name",
	        	 email: "Please enter an email address",
	        	 phone: {
	                 required: "Please enter your Mobile Number",
	                 minlength: "Your Mobile Number must be 10 characters"
	             },
	             companyName:"Please enter your Company Name",
	             project:"Please enter Project Name",
	             country:"Please select your Country",
	             state:"Please select your State",
	             pincode:{
	            	 required: "Please enter your Zip Code",
	            	 number:"Please enter number only"
	             }
	         }
	     })
	     
	     jQuery.validator.addMethod("lettersonly", function(value, element) {
       	  return this.optional(element) || /^[a-z]+$/i.test(value);
       	}, "Letters only please"); 
         
	});
</script>
<script type="text/javascript">
$(function(){
	
	//successMessage
	 $("#successMessage").modal({
	      show: false,
	      backdrop: 'static'
	  });
  var colpick = $('.demo').each( function() {
    $(this).minicolors({
      control: $(this).attr('data-control') || 'hue',
      inline: $(this).attr('data-inline') === 'true',
      letterCase: 'lowercase',
      opacity: false,
      change: function(hex, opacity) {
        if(!hex) return;
        if(opacity) hex += ', ' + opacity;
        try {
          console.log(hex);
        } catch(e) {}
        $(this).select();
      },
      theme: 'bootstrap'
    });
  });
  
  var $inlinehex = $('#inlinecolorhex h3 small');
  $('#inlinecolors').minicolors({
    inline: true,
    theme: 'bootstrap',
    change: function(hex) {
      if(!hex) return;
      $inlinehex.html(hex);
    }
  });
});
</script>
<script src="<c:url value="js/jquery.buttonLoader.js" />"></script>
  </body>
</html>
