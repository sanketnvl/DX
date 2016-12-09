<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
	
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DrySign-Document</title>
<link rel="stylesheet" type="text/css" href="<%=serverUrl %>/css/style.css">
<link rel="stylesheet" href="<%=serverUrl %>/css/bootstrap.min.css"> 
<link href="<%=serverUrl %>/css/ui/fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="<%=serverUrl %>/css/ui/css/animate.min.css" rel="stylesheet">

<!-- POP UP CSS -->
<link href="<%=serverUrl %>/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=serverUrl %>/css/icons.css">
<link rel="stylesheet" href="<%=serverUrl %>/css/popupstyle.css">

     
<script src="<%=serverUrl %>/js/jquery.min.1.12.4.js"></script>

<script src="<%=serverUrl %>/js/jquery-ui.js"></script>
<script src="<%=serverUrl %>/js/json2.js"></script>
<link rel="stylesheet" href="<%=serverUrl %>/css/closeicon.css">
<link rel="stylesheet" href="<%=serverUrl %>/css/scroll.css">
<link href='https://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css'>
<link href="<%=serverUrl %>/css/buttonLoader.css" rel="stylesheet" type="text/css">
<style>
::-webkit-input-placeholder { /* WebKit, Blink, Edge */
    color:    white;
}
:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
   color:    #white;
   opacity:  1;
}
::-moz-placeholder { /* Mozilla Firefox 19+ */
   color:    #white;
   opacity:  1;
}
:-ms-input-placeholder { /* Internet Explorer 10-11 */
   color:    #white;
}
.selected{
    box-shadow:9px 11px 28px -12px #080808;
}

/*input:focus {
    background-color: #286090 !important;
    color:black !important;
}*/
/* 
.clearable input:focus {
    background-color: #ffa !important ;
    color:black !important;
} */
input{
color:black !important;
}
.progress {
    height: 20px;
    margin-bottom: 20px;
    overflow: hidden;
    background-color: #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
    box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
}
.progress-bar {
    float: left;
    width: 0;
    height: 100%;
    font-size: 12px;
    line-height: 20px;
    color: #fff;
    text-align: center;
    background-color: #656565;
    -webkit-box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
    box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
    -webkit-transition: width .6s ease;
    -o-transition: width .6s ease;
    transition: width .6s ease;
}
.selfsign-control {
    display: block;
    width: 100%;
    height: 18px;
    border: none;
    border-radius: 2px;
    margin: 0;
    left: 0;
    position: absolute;
    background: #ccc;
    white-space: pre;
    transition: none !important;
    -webkit-transition: none !important;
    font-size: 15px;
    font-family: NimbusSansL, Helvetica, Arial, sans-serif !important;
    z-index: 1020;
    -moz-box-shadow: inset 0px 1px 1px #AAA;
    -webkit-box-shadow: inset 0px 1px 1px #AAA;
    box-shadow: none;
    outline: none;
    resize: none;
    color: #000;
    line-height: 30px !important;
    font-size: 13px !important;
}

.progress3 .bar {
    float: left;
    width: 0;
    height: 100%;
    font-size: 12px;
    color: #ffffff;
    text-align: center;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    background-color: #1b4214;
    background-image: -moz-linear-gradient(top, #149bdf, #0480be);
    background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#149bdf), to(#0480be));
    background-image: -webkit-linear-gradient(top, #149bdf, #0480be);
    background-image: -o-linear-gradient(top, #149bdf, #0480be);
    background-image: linear-gradient(to bottom, #149bdf, #0480be);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff149bdf', endColorstr='#ff0480be', GradientType=0);
    -webkit-box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.15);
    -moz-box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.15);
    box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.15);
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-transition: width 0.6s ease;
    -moz-transition: width 0.6s ease;
    -o-transition: width 0.6s ease;
    transition: width 0.6s ease;

}

.progress3 {
    height: 20px;
    margin-bottom: 20px;
    overflow: hidden;
    background-color: #FAB653;
    background-image: -moz-linear-gradient(top, #f5f5f5, #f9f9f9);
    background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#f5f5f5), to(#f9f9f9));
    background-image: -webkit-linear-gradient(top, #f5f5f5, #f9f9f9);
    background-image: -o-linear-gradient(top, #f5f5f5, #f9f9f9);
    background-image: linear-gradient(to bottom, #f5f5f5, #f9f9f9);
    background-repeat: repeat-x;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fff5f5f5', endColorstr='#fff9f9f9', GradientType=0);
    -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
    -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
    box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
}
.navbar-default {
   	background-color: #5890CD;;
    border-radius: 0;
    color: #fff;
}
#show_progress{ background: #d9e3eb url(<%=serverUrl %>/images/linen-dark-blue.jpg) center top repeat fixed;}
body{ background: #d9e3eb url(<%=serverUrl %>/images/linen-dark-blue.jpg) center top repeat fixed;height:100vh;} 
#base{
  padding:10px;
  background:#eee;
}
textarea:focus {
   background-color: #ffa !important;
}
/* #dvLoading
{
  
   height: 100px;
   width: 100px;
   position: fixed;
   z-index: 1000;
   left: 50%;
   top: 50%;
   margin: -25px 0 0 -25px;
   background:  url('images/ajax-loader_1.gif') 
                50% 50% 
                no-repeat;
} 

#show_landing{
	position:absolute;
    bottom:0;
    left:0;
    right:0;
    top:0;  
    opacity:0.5;
    background-color:#000;
    color:#fff;
    z-index:9999;
}*/

.loader {
		
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 99999;
	background: url('<%=serverUrl %>/images/ajax-loader_1.gif') 50% 50% no-repeat rgba(43, 40, 40, 0.37);
}

.mysignaturethumbnail {
    height: 71px;
    overflow: hidden;
    width: 132px;
    float: left;
    margin: 4px;
}

	
</style>
 <script type="text/javascript">
   function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
   }
</script>
<script>

/* $(window).load(function(){
	 // $('#dvLoading').fadeOut(500);
	}); */

$(document).ready(function(){
	var url='${redirecturl}';
	var decodedUrl = decodeURIComponent(url);
	$("#redirecturl").val(decodedUrl);
	$("#show_progress").show();
	$('#modalMessage').modal('hide');
	$("#show_landing").hide();
});
	
	
//ajax display loader image start
$(document).bind("ajaxStart.mine", function() {
	$('.loader').css('display', '');
	$('.loader').show();
});

//ajax display loader image stop
 $(document).bind("ajaxStop.mine", function() {
	$('.loader').css('display', 'none');
    $('.loader').hide();
}); 

</script>
</head>
<body>

<div id="show_progress">
 <div id="show_progress" class="container">
 
	 <div class="row" style="padding-top:220px;">
            <div class="col-md-12 col-xs-12 text-center"><h3>
            <c:choose>
			    <c:when test="${param.projectname=='null'}">
			        DrySign 
			        <br />
			    </c:when>    
			    <c:otherwise>
			       <%= request.getParameter("projectname") %>
			        <br />
			    </c:otherwise>
			</c:choose>
        	  
            </h3> 
            </div>
	</div>
  	<div class="row">
            <div class="col-md-6 col-md-offset-3 col-xs-6 col-xs-offset-3 text-center">
            	<div class="progress3" id="front-progress">
    	 		 <div class="bar" id="progress"></div>
    	 		 
            </div>
             <div class="col-md-12 col-xs-12 text-center">
             <span>Powered by DrySign</span>
             </div>
            
	  	   </div>
	  </div>
  </div>	
</div>
<div id="show_landing">
<input type="hidden" id="contextPath" value="<%=serverUrl %>/"/>

<div class="navbar navbar-default navbar-fixed-top">
<div class="row" id="sprogressbar">
            <div class="col-md-2 col-sm-2 col-xs-12 text-center">
        	  <h3><a href="#" style="color:#fff"><strong>
        	  <c:choose>
			    <c:when test="${param.projectname=='null'}">
			        DrySign 
			        <br />
			    </c:when>    
			    <c:otherwise>
			       <%= request.getParameter("projectname") %>
			        <br />
			    </c:otherwise>
			</c:choose>
			<div id="output"></div>
        	  </strong><%-- <img class="image_" src="<%=serverUrl %>/images/logo.png" height="auto" width="140" alt="Logo" title="Logo" /> --%></a></h3>
          	</div>
          	<c:if test="${empty fileMsg}">
            <div class="col-md-8 col-sm-8 col-xs-12">
                <br>
            	<div class="progress">
			    <div class="progress-bar" id="progress_bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
			    </div>
			  </div>
            </div>
            <div class="col-md-2 col-sm-2 col-xs-12 aliGn">
             <br>
             <span id="displayFinish">
             		<button type="button" onclick="saveDocumentSign();" style="position: relative;top: -6px;width: 95px;" id="finish" class="btn btn-success" >Finish</button>
					<button type="button" id="guide" class="btn btn-warning" >Guide Me</button>
			 </span>
            </div>
            </c:if>
            <input type="hidden" id="projectname" value="<%= request.getParameter("projectname") %>"/>
            <input type="hidden" id="linktodrysign" value="<%= request.getParameter("linktodrysign") %>"/>
            <input type="hidden" id="theme" value="<%= request.getParameter("theme") %>"/>
   			<input type="hidden" id="signername" value="<%= request.getParameter("signername") %>"/>
       </div>     
</div>
<div class="loader" style="display:none"></div>
	<div id="container">
	<div>
		<input type="hidden" id="fileMsg" value="${fileMsg}"/>
	   <c:if test="${not empty fileMsg}">
           <div class="col-md-6 col-md-offset-3 col-xs-6 col-xs-offset-3 error alert-box" style="padding: 25px 30px 25px 30px;">${fileMsg}</div>
       </c:if>
		<div class="wrapper wrapGH">
			 <input type="hidden" id="fileName" value="${filename}" />
				<div class="page">
					<div class='document-reader' id="document-reader">
						<c:forEach var="page" begin="1" end="${numpages}">
							<div class="pageimg" id="page_${page}" data-doc-id="${page}">
								 <img  width="890" src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/img?fileid=${fileid}&filename=${filename}&page=${page}" />
							</div>
		 				</c:forEach>
					</div>
					<div style="display:none;" class="nav_down" id="nav_down"></div>  
					  
				</div>
			
		 
		</div>
		
		<!-- <div style="display:none;" class="nav_up" id="nav_up"></div> -->
		
	</div>
</div>
<div id="footer-wrapper">
	<footer id="footer"><p><br> Copyright&copy;2016 DrySign. All rights reserved.</p></footer>
</div>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					 <li role="presentation" class="active"><a href="#type" aria-controls="home" role="tab" data-toggle="tab">Type</a></li> 
					 <li role="presentation"><a href="#profile"
						aria-controls="profile" role="tab" data-toggle="tab">Draw</a></li>
					 <!-- <li role="presentation"><a href="#messages"aria-controls="messages" role="tab" data-toggle="tab">Upload</a></li> -->
					<li id="showmysignature" role="presentation"><a href="#mysignature" 
					aria-controls="#mysignature" role="tab" data-toggle="tab">My Signature</a></li>
				</ul>
			</div>
			<div class="modal-body">
				
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="type">
						<div id="signature-type-error" style="color:red;">
						</div>
						<input class="form-control" id="typeSign" type="text" value="Type Your Signature"><br><br>
						 <div class="row" id="selectType">
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="profile">
						<div id="signature-draw-error" style="color:red;">
						</div>
						<div class="tools">
						<a href="#colors_sketch" data-tool="marker">Marker</a> <a href="#colors_sketch" data-tool="eraser">
						Eraser</a>
						</div>
						<canvas id="colors_sketch" width="500" height="200"></canvas>
					</div>
					<div role="tabpanel" class="tab-pane" id="messages">
					  	<form id="update_sign">
					    	<div class="form-group">
							    <label for="exampleInputFile"></label>
							   <input type='file' name="fileimage" id="upload_sign" />
							    <p class="text-danger">Please upload your files(Support only .gif,jpg,jpeg and file size max 10MB) .</p>
							  </div>
						</form>
						<img id="show_update_sign" src="" height="300px" width="300px" />
					</div>
					<div role="tabpanel" class="tab-pane" id="mysignature">
						<div id="signature-mysigntaure-error" style="color:red;">
						</div>
						<div class="row" id="showMySinature">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" onclick="addSignature();" class="btn btn-primary">Add</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade bs-example-modal-sm" id="modalMessage" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" style="margin:150px auto;" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background: #e1e1e1;border-radius: 4px;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h5 class="modal-title" id="myModalLabel">Hi <strong> <%= request.getParameter("signername") %>,</strong></h5>
      </div>
      <div class="modal-body">
       	<p class="bg-warning">
       	 You are invited to sign this document in DrySign.
      	</p>
		<p class="alert alert-danger"> &nbsp;&nbsp;&nbsp;<i class="fa fa-stop"></i>&nbsp;<span id="requiredCount"></span> Required Fields</p>
		<!-- <p class="bg-warning">Click "Guide Me" to see required places</p> -->
		
      </div>
      <div class="modal-footer">
        <button type="button" data-dismiss="modal" aria-label="Close" class="btn btn-primary">OK</button>
        
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade bs-example-modal-sm" id="successMessage" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
  <div class="modal-dialog modal-sm" style="margin:220px auto" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background: #e1e1e1;border-radius: 4px;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h5 class="modal-title" id="myModalLabel">Hi<strong> <%= request.getParameter("signername") %>,</strong></h5>
      </div>
      <div class="modal-body" style="padding:10px;">
      	<p class="text-center"><img src="<%=serverUrl %>/images/successfull.png"/ width="50px" height="50px"></p>
      	<div >You have successfully signed the document</div>
      </div>
      <div class="modal-footer">
        <p class="text-center"><button type="button" onclick="closeBar();" class="btn btn-warning">OK</button></p>
        
      </div>
    </div>
  </div>
</div>

<!-- Existing user Pop up(1) -->
<div class="modal fade" id="existUserPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document" style="width: 450px; max-width:80%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title text-left"><img src="<%=serverUrl %>/images/logo2.png" width="93px;"></h4>
      </div>
     <div class="modal-body">
	     <p> <strong>Hi <%= request.getParameter("signername") %></strong>,</p>
	     <p>It seems that you are already registered with DrySign! </p>
		 <p>Would you like to use your DrySign account and signature(s) associated with <strong><%= request.getParameter("email") %></strong>?.</p>
	 </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-primary" onclick="showloginpopup();">Sign In To DrySign
		</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Continue</button>
      </div>
    </div>
   </div> 
</div>
<div class="modal fade" id="existUserPopUp1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="width: 450px; max-width:80%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title text-left"><img src="<%=serverUrl %>/images/logo2.png" width="93px;"></h4>
      </div>
     <div class="modal-body">
      <div class="alert alert-info">Please enter your credentials to sign into DrySign</div>
	      <form class="">
		  <div class="form-group">
		    <label for="email">User Name:</label>
		    <input type="text" class="form-control" id="email" value="<%= request.getParameter("email") %>" readonly>
		  </div>
		  <div class="form-group">
		    <label for="pwd">Password:</label>
		  <input type="password" class="form-control" id="spassword" placeholder="Password" onchange="enablePassword();">
		  </div>
		    <div  id="login_info" style="display:none">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			</div>
			<div id="login_error" class="" style="display:none;color:red">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			</div>
	      </form>
     </div>
  	 <div class="modal-footer text-center">
        <button type="button" id="qsign" class="btn btn-primary has-spinner" onclick="quickSign();" >Sign In </button>
        <button type="button" class="btn btn-secondary"  data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div> 
</div>

<!-- First time user -->
<div class="modal fade" id="notExistUserPopUp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <div class="modal-dialog" role="document" style="width: 450px; max-width:80%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title text-left"><img src="<%=serverUrl %>/images/logo2.png" width="93px;"></h4>
      </div>
     <div class="modal-body">
     <p> <Strong>Hi <%= request.getParameter("signername")%></Strong>,</p>
     <p>Would you like to register with DrySign?.</p>
	 <p>By registering with DrySign, you will be able to create and use your personalized digital signature(s).</p>
	 </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-primary"  data-dismiss="modal" onclick="showregisterpopup();">Register and continue 
		</button>
        <button type="button" class="btn btn-secondary"  data-dismiss="modal">Continue without registering</button>
      </div>
    </div>
  </div> 
</div>

<div class="modal fade" id="notExistUserPopUp1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="width: 450px; max-width:80%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title text-left"><img src="<%=serverUrl %>/images/logo2.png" width="93px;"></h4>
      </div>
      <div class="modal-body" >
       <div class="alert alert-info" id="qtitle">You are almost there! Please set up your account to proceed.</div>
		<form class="" id="quickRegister">
		  <div class="form-group">
			<label for="firstName">First Name:</label>
			<input type="text" class="form-control" id="firstName" value="<%= request.getParameter("signername")%>" readonly/>
		  </div>
		   <div class="form-group">
			<label for="lastName">Last Name:</label>
			<input type="text" class="form-control" id="lastName" value=""/>
		  </div>
		   <div class="form-group">
			<label for="email">Email:</label>
			<input type="email" class="form-control" id="email" value="<%= request.getParameter("email") %>" readonly/>
		  </div>
		   <div class="form-group">
			<label for="password">Password:*</label>
			<input type="password" class="form-control" id="dpassword" onchange="enablerPassword();"/>
		  </div>
	  	</form>
		 <div  id="register_info" class="alert alert-success" style="display:none">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			</div>
			 <br>
			<div id="register_error" class="alert alert-danger" style="display:none">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			</div>
        </div>
      <div class="modal-footer text-center" id="rfooter">
        <button type="button" class="btn btn-primary" id="qregister"  onclick="quickRegister();">Register </button>
        <button type="button" class="btn btn-secondary" id="qcancel" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-secondary" id="qcontinue" data-dismiss="modal" style="display:none">Continue</button>
      </div>
    </div>
  </div> 
</div>

<input type="hidden" id="fname" value="${filename}" />
<input type="hidden" id="fileid" value="${fileid}" />
<input type="hidden" id="email" value="${email}" />
<input type="hidden" id="token" value="${token}" />
<input type="hidden" id="redirecturl" value="" />
<input type="hidden" id="envelopeid" value="${envelopeid}" />
<input type="hidden" id="imageField" value=""/>
<input type="hidden" id="fieldLength" value="0"/>
<input type="hidden" id="myType" value=""/>
<input type="hidden" id="initial" value="0.0"/>
<input type="hidden" id="setIndexPixel" value="0"/>
<input type="hidden" id="checkFlag" value="true"/>
<input type="hidden" id="isLogin" value="false"/>
<input type="hidden" id="mysignatutreVal" value=""/>
<input type="hidden" id="progresscount" value=""/>
<input type="hidden" id="drawBase64" value="data:image/png;base64,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">

<script src="<%=serverUrl %>/js/sketch.min.js" type="text/javascript"></script>
<script src="<%=serverUrl %>/js/jquery.buttonLoader.js"></script>
<script type="text/javascript">

function showloginpopup(){
	$('#qsign').prop("disabled", true);
	$('#existUserPopUp').modal('hide');
	$('#existUserPopUp1').modal('show');
}

function showregisterpopup(){
	
	$('#qregister').prop("disabled", true);
	$('#notExistUserPopUp').modal('hide');
	$('#notExistUserPopUp1').modal('show');
}

function enablerPassword(){
	var password=$("#dpassword").val();
	if(password ==''){
		$("#qregister").prop('disabled',true);
	}else{
		$("#qregister").prop('disabled',false);
	}
}

function enablePassword(){
	var password=$("#spassword").val();
	if(password ==''){
		$("#qsign").prop('disabled',true);
	}else{
		$("#qsign").prop('disabled',false);
	}
    
    event.preventDefault();
}

function quickSign(){
	 $('#login_error').hide();
	 var email = '${email}';
	 var password =$("#spassword").val();
	 var contextPath=$("#contextPath").val();
	
	 $.ajax({
	        type: "POST",
	        url: contextPath + "ajax/quickSign",
	        data: "email=" + email + "&password=" + password,
	        global: false,
	        beforeSend : function() {
				//$("#forgotpwdmessage").html("loading..");
				$('#qsign').buttonLoader('start');
		   },
			complete : function() {
				//$("#changepwdmessage").html("");
				$("#qsign").buttonLoader('stop');
			},
	        success: function(response){
	            // we have the response
	            if(response.status == "SUCCESS"){
	            	var successInfo="Sucess!.You can use your existing signatures from DrySign for sign document.";
	            	//$('#login_info').html(successInfo);
	            	$('#existUserPopUp1').modal('hide');
	            	$('#showmysignature').show();
	            	var mysignInfo=""; 
	            	for(i =0 ; i < response.result.length ; i++){
	                    //alert(response.result[i].id);
	                    
	                    $("#showMySinature").append('<div class="col-lg-3 col-md-3 col-xs-6 thumb"><a onclick="getMySignatureData('+response.result[i].id+')" class="thumbnail mysignaturethumbnail" class="myimgselect'+response.result[i].id+' thumbnail" style="height: 57px;"> <img id="myimg'+response.result[i].id+'"  class="img-responsive" src='+response.result[i].sign+' alt=""></a></div>');
	                    //$("#showMySinature").html('<a class="thumbnail mysignaturethumbnail"><img class="img-responsive" src="'+response.result[i].sign+'" alt=""></a>');
	                 }
	                $('#spassword').val('');
	                $('#quickSign').hide();
	                $('#sign-header').hide();
	              
	                $('#login_error').hide('slow');
	                $('#login_info').show('slow');
	                $('#showsignfinish').show();
	                $('#isLogin').val(true);
	                
	                
	                 
	             }else{
	            	 var signData=response;
	 	    	 	$("#selectType").empty();
	     		 	 $.each( signData, function( key, value ) {
	     		 		$('#login_error').html(value);
	 	    		 });
	                 $('#login_info').hide('slow');
	                 $('#login_error').show('slow');
	             }
	         },
	         
	         error: function(e){
	             alert('Error: ' + e);
	         }
	    });
	 
}
function quickRegister() {
    // get the form values
    
    var email = '${email}';
    var firstName=$("#signername").val();
    var password =$("#dpassword").val();
    var contextPath=$("#contextPath").val();
    $.ajax({
        type: "POST",
        url: contextPath + "ajax/quickRegister",
        data: "email=" + email + "&firstName="+firstName+"&password=" + password,
        global: false,
        beforeSend : function() {
			//$("#forgotpwdmessage").html("loading..");
			$('#qregister').buttonLoader('start');
	   },
		complete : function() {
			//$("#changepwdmessage").html("");
			$("#qregister").buttonLoader('stop');
		},
        success: function(response){
            // we have the response
            if(response.status == "SUCCESS"){
            	var successInfo="Thank you for registering with DrySign.";
            	$('#register_info').html(successInfo);
                $('#dpassword').val('');
                $('#quickRegister').hide();
                $('#qregister').hide();
                $('#qtitle').hide();
                $('#qcancel').hide();
                $('#qcontinue').show();
                $('#register-header').hide();
                $('#register_error').hide('slow');
                $('#register_info').show('slow');
                $('#showregisterfinish').show();
                 
             }else if(response.status == "PROBLEM" || response.status == "EXIST" || response.status == "FAIL"){
                 errorInfo = "";
                 for(i =0 ; i < response.result.length ; i++){
                     errorInfo += "<br>" + (i + 1) +". " + response.result[i].code;
                 }
                 $('#register_error').html("Error info " + errorInfo);
               	 $('#register_info').hide('slow');
                 $('#register_error').show('slow');
             }
         },
         error: function(e){
             alert('Error: ' + e);
         }
    });
    
}
 
 $(function () {
     $('#colors_sketch').sketch();
     $(".tools a").eq(0).attr("style", "color:#000");
     $(".tools a").click(function () {
         $(".tools a").removeAttr("style");
         $(this).attr("style", "color:#000");
     });
     $("#btnSave").bind("click", function () {
         var base64 = $('#colors_sketch')[0].toDataURL();
         $("#imgCapture").attr("src", base64);
         $("#imgCapture").show();
     });
 });
</script>
<script type="text/javascript">
$(function(){
  getFieldData();
  getSigntype();
  $("#finish").hide()
  $("#successMessage").modal({
      show: false,
      backdrop: 'static'
  });
  
});


function slide_progress(completeness){
	 $('#progress_bar').attr('aria-valuenow', (completeness)).css('width',(completeness)+"%");
	 if(completeness >= 100){
			$("#guide").hide();
			$("#finish").show()
			//$("#done").html("Finish");
	 }
}


function progressdata(textValue){
	var completeness = $("#progresscount").val();
	//var completeness = 5;
	var tcompleteness=parseFloat(100)/parseFloat(completeness);
	$(".page input[id][name$='document_field']").each(function () {
		//alert(this.value);
		if (this.value == "") {
			 completeness--;
		}
	});
	
	slide_progress(completeness*tcompleteness);
}
</script>

<c:if test="${empty fileMsg}">
<script>
//get field data position pixles
function getFieldData(){
	var contextPath=$("#contextPath").val();
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = mm+'/'+dd+'/'+yyyy;
	
	 $.ajax({  
	     type : "GET",   
	     url : contextPath+"app/ajax/getApplicationFieldData",   
	      data : {"fname":$("#fname").val(),"fileid":$("#fileid").val(),"email":$("#email").val()},  
	  	  dataType: 'json',
	      contentType: "application/json; charset=utf-8",
	     success : function(response) {  
	    	  if(response){       
	    		$("#fieldLength").val(response.length)
	    		var count=1;
	    		//$("#requiredCount").html(response.length)  
	    		for ( var key =0; key < response.length; ++key) 
	    		{
	    		  // alert(response[key].fieldValue);
	    		   
	    		   if( response[key].fieldType =='image'){
    			       var sum=0.00;
    			   	   if(response[key].pageNumber == 1 ){
    			    	   sum=sum;
    			       }else  if(response[key].pageNumber > 1 ){
    			    	   sum=1152*(response[key].pageNumber-1);
    			       }
		    			var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
		    			var y=parseFloat(sum)+parseFloat(response[key].yPosition);
		    			newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="selfsign-control" type="image" src=""  style="overflow:hidden;position:absolute;absolute position opacity:0.6;transparency filter:alpha(opacity=60);margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;top:'+y+'px;height:'+response[key].fieldHeight+'px;font-size:20px;background-color:#ffa;text-align: center;border-color: #b5b3b3" name="document_field" id="field_'+key+'" value="" data-toggle="modal" onclick="modalPopBox('+key+');"><input type="hidden" id="imageField'+key+'" value="'+key+'" />');
		    			newTextBoxDiv.appendTo("#document-reader");
		    			//progress bar code is here
		    			$("#requiredCount").html(count);
	    			   	$("#progresscount").val(count);
	    			   	count++;
			    	}else if(response[key].fieldType =='text' && response[key].fieldName =='date'){
			    		  var sum=0.00;  
			    		  if(response[key].pageNumber == 1 ){
			    	    	   var sum=0.00;
	    			    	   sum=sum;
	    			       }else  if(response[key].pageNumber > 1 ){
	    			    	   sum=1152*(response[key].pageNumber-1);
	    			      }
			    			var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
			    			var y=parseFloat(sum)+parseFloat( response[key].yPosition);
			    			newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="clearable" placeholder="DD/MM/YYYY" type="text" placeholder="'+ response[key].fieldName+'"  style="display: block;width: 100%;height: '+ response[key].fieldHeight+'px;border-radius: 2px;border: 0px solid transparent;border-radius: 4px;margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;text-align: left;border-color: #b5b3b3;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;transition: none !important;-webkit-transition: none !important;font-size: 15px;font-family: NimbusSansL, Helvetica, Arial, sans-serif !important;z-index: 1020;-moz-box-shadow: inset 0px 1px 1px #AAA;-webkit-box-shadow: inset 0px 1px 1px #AAA; box-shadow: none;outline: none;white-space: pre;" name="document_field" id="field_'+key+'" onchange="progressdata(this.value);"  placeholder="DD/MM/YYYY"  value="'+today+'" readonly>');
			    			newTextBoxDiv.appendTo("#document-reader");
			    	} 
			    	else if(response[key].fieldType =='text'){
		    		  var sum=0.00;  
		    		  if(response[key].pageNumber == 1 ){
		    	    	   var sum=0.00;
    			    	   sum=sum;
    			       }else  if(response[key].pageNumber > 1 ){
    			    	   sum=1152*(response[key].pageNumber-1);
    			      }
		    		  
		    		  	
		    			var newTextBoxDiv = $(document.createElement('div')).attr("id", 'mypage_' + key);
		    			var y=parseFloat(sum)+parseFloat( response[key].yPosition);
		    			if(response[key].fieldValue != 'null' ){
		    				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="clearable" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="display: block;width: 100%;height: '+ response[key].fieldHeight+'px;border-radius: 2px;border: 0px solid transparent;border-radius: 4px;margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;text-align: left;border-color: #b5b3b3;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;transition: none !important;-webkit-transition: none !important;font-size: 15px;font-family: NimbusSansL, Helvetica, Arial, sans-serif !important;z-index: 1020;-moz-box-shadow: inset 0px 1px 1px #AAA;-webkit-box-shadow: inset 0px 1px 1px #AAA; box-shadow: none;outline: none;white-space: pre;" name="document_field" id="field_'+key+'" readonly value="'+ response[key].fieldValue+'" >');	
		    			}else{
		    				newTextBoxDiv.after().html('<input type="hidden" id="field_id'+key+'" value="'+response[key].id+'"><input type="hidden" value="'+ response[key].pageNumber+'" id="pageNumber_'+key+'" name="pageNumber"><input type="hidden" value="'+ response[key].yPosition+'" id="yposition_'+key+'" ><input class="clearable" type="text" placeholder="'+ response[key].fieldName+'"  type="text" style="display: block;width: 100%;height: '+ response[key].fieldHeight+'px;border-radius: 2px;border: 1px solid transparent;border-radius: 4px;margin-left:'+ response[key].xPosition+'px;width:'+ response[key].fieldWidth+'px;background-color:#ffa;text-align: left;border-color: #b5b3b3;top:'+y+'px;height:'+ response[key].fieldHeight+'px;position: absolute;transition: none !important;-webkit-transition: none !important;font-size: 15px;font-family: NimbusSansL, Helvetica, Arial, sans-serif !important;z-index: 1020;-moz-box-shadow: inset 0px 1px 1px #AAA;-webkit-box-shadow: inset 0px 1px 1px #AAA; box-shadow: none;outline: none;white-space: pre;" name="document_field" id="field_'+key+'" onchange="progressdata(this.value);"  value="" >');
		    			}
		    			newTextBoxDiv.appendTo("#document-reader");
			    	}
	    		   
	    		  /*  if(response[key].fieldValue=='null' && response[key].fieldName !='date'){
	    			   	$("#requiredCount").html(count);
	    			   	$("#progresscount").val(count);
	    			   	count++;
	    		   } */
	    		}
	    		
	    	   }	
	     },  
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	    });  
}

function checkUserIsExistOrNot(){
	var contextPath=$("#contextPath").val();
	var email='${email}';
	$.ajax({  
	     type : "GET",   
	     url : $("#contextPath").val()+"ajax/checkUserIsExist?emailId="+email,   
	     dataType: 'json',
	     success : function(response) {  
	    	//alert(response);
	    	if(response ==true){
	    		//$("#notExistUserPopUp").hide();
	    		$('#existUserPopUp').modal('show');
	    	}else if(response ==false){
	    		//$("#existUserPopUp").hide();
	    		$('#notExistUserPopUp').modal('show');	
	    	}
	    	
	     },  
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	 });  
}

</script>
</c:if>
<script>

//save document details
function saveDocumentSign() 
{
	var contextPath=$("#contextPath").val();
	var fieldLength=$("#fieldLength").val();
	var fieldValue=$("#imageField").val();
	var jsonArray = [];
	var signeremail = $("#email").val();
	var fname = $("#fname").val();
	var fileid = $("#fileid").val();
	var token = $("#token").val();
	var redirecturl = $("#redirecturl").val();
	
	var envelopeid = $("#envelopeid").val();
	var info = "?token="+token+"&envelopeid="+envelopeid+"&token="+token+"&signeremail="+signeremail+"&islogin=true&redirecturl="+redirecturl;
	
	for(var i=0; i<fieldLength; i++) {
		var item = {};
		var field = "field_"+i;
		var imgFieldVal = "field_"+$("#imageField"+i).val();
		if(field == imgFieldVal){
			var sign = document.getElementById('field_'+i);
			var signature = sign.getAttribute('src');
			var pageNumber=$("#pageNumber_"+i).val();
			item ["id"] =$("#field_id"+i).val();
			item ["documentName"] = $("#fname").val();
			item ["top"] = $("#yposition_"+i).val()
			item ["left"] = $("#field_"+i).css("margin-left");
			item ["fieldType"] = "image";
			item ["fieldValue"] = signature;
			item ["pageNumber"] = pageNumber;
		}else{
			var pageNumber=$("#pageNumber_"+i).val();
			item ["id"] =$("#field_id"+i).val();
			item ["documentName"] = $("#fname").val();
			item ["top"] = $("#yposition_"+i).val()
			item ["left"] = $("#field_"+i).css("margin-left");
			item ["fieldType"] = "text";
			item ["fieldValue"] = $("#field_"+i).val();
			item ["pageNumber"] = pageNumber;
		}
		jsonArray.push(item);
	}

  	$.ajax({
		type : "POST",
		url : "ajax/appSaveDocument"+info,
		dataType: 'json', 
	    data: JSON.stringify(jsonArray),
	    contentType: "application/json;",
        success : function(response) { 
            if(response == "success"){
                if(redirecturl != "" || redirecturl.trim() !="")
            	{	
                	$(".page").hide();
	            	$("#sprogressbar").hide();
	                $('#successMessage').modal('show');
	                
	                $("#header").hide();
	                $("#footer-wrapper").hide();
	                $(".form-control").hide();
	                $("#done").hide();
	                $("#nav_down").hide();
            		
            	}else{ 	
            	
                //$("#document-reader").html('Document save successfully');
	            	$(".page").hide();
	            	$("#sprogressbar").hide();
	                $('#successMessage').modal('show');
	                
	                $("#header").hide();
	                $("#footer-wrapper").hide();
	                $(".form-control").hide();
	                $("#done").hide();
	                $("#nav_down").hide();
            	}
                
          }else{
                alert("Error while saving details.");
          }

		}
	});  
	
}

var x;
var y ;
$(document).ready(function(){
    $('.nav-tabs a').on('shown.bs.tab', function(event){
         x = $(event.target).text();         // active tab
         y = $(event.relatedTarget).text();  
    });
});

//load signature image file and convert it into base 64
var dataURLFile;
function loadImageFileAsURL()
{
    var filesSelected = document.getElementById("myFile").files;
    if (filesSelected.length > 0)
    {
        var fileToLoad = filesSelected[0];
        var fileReader = new FileReader();
        fileReader.onload = function(fileLoadedEvent) 
        	{
      	  dataURLFile = fileLoadedEvent.target.result;
        	};
         fileReader.readAsDataURL(fileToLoad);
     }
}
//add signature 
function addSignature() {
	var text;
	document.getElementById("signature-type-error").innerHTML="";
	document.getElementById("signature-draw-error").innerHTML="";
	var fieldValue=$("#imageField").val();
	var val="";
	if(x=="Draw"){
	 	var defaultValue=$("#drawBase64").val();
		text = $('#colors_sketch')[0].toDataURL();
		dataURL = text;
		var check;
		if(defaultValue == dataURL){
			check=validationSignature("","draw");
		}else{
			$('#myModal').modal('hide');
			val= $("#field_"+fieldValue).attr('src', dataURL);	
			$("#field_"+fieldValue).css("padding", 1);
			$("#field_"+fieldValue).css({ width: '150px', height: '50px' });
			$("#field_"+fieldValue).val(val);
		}
		
	}else if(x=="My Signature") {  //my signature 
		var sign = $("#mysignatutreVal").val();
		var check=validationSignature(sign,"mysignature");
		if(check ==true){
			$('#myModal').modal('hide');
			val=$("#field_"+fieldValue).attr('src', sign);	
			$("#field_"+fieldValue).val(val);
		}
	}else if(x=="Upload") {  //my signature 
		var sign = document.getElementById('show_update_sign');
		dataURL = sign.getAttribute('src');
		sign.setAttribute('src', dataURL);
		$('#myModal').modal('hide');
		val=$("#field_"+fieldValue).attr('src', dataURL);	
		$("#field_"+fieldValue).val(val);
	}else {
		var sign = $("#myType").val();
		var check=validationSignature(sign,"type");
		if(check ==true){
			$('#myModal').modal('hide');
			val=$("#field_"+fieldValue).attr('src', sign);	
			$("#field_"+fieldValue).val(val);
		}
	}	
	
	
	if(val!=null){
		progressdata(val);
	}
}

function validationSignature(signValue,type){
	if(signValue ==""){
		if(type =="type"){
		$("#signature-type-error").html("Please type your signature here");
		}
		if(type =="draw"){
		$("#signature-draw-error").html("Please draw your signature here");
		}
		if(type =="mysignature"){
		$("#signature-mysigntaure-error").html("Please select your signature here");	
		}
		return false;
	}
	if(signValue =="Type Your Signature"){
		$("#signature-error").html("Please draw your signature here");
		return false;
	}
	return true;
}

//show signature types
$("#typeSign").keyup(function(){
	document.getElementById("signature-type-error").innerHTML="";
	var typeValue=$("#typeSign").val();
	//dataURL = typeValue.toDataURL();
	$.ajax({  
	     type : "GET",   
	     url : $("#contextPath").val()+"ajax/createTypeFonts?imgType="+typeValue,   
	     dataType: 'json',
	     success : function(response) {  
	    	 var imgData=response;
	    	 	$("#selectType").empty();
    		 	$.each( imgData, function( key, value ) {
    		 		  $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a onclick="getTypeData('+key+')" class="thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
	    		});
	     },  
	     global: false,
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	    });  
});			

 
function getSigntype(){
	var typeValue=$("#typeSign").val();
	$.ajax({  
	     type : "GET",   
	     url : $("#contextPath").val()+"ajax/createTypeFonts",   
	     data : "imgType="+typeValue,  
	     dataType: 'json',
	     success : function(response) {  
	    	 var imgData=response;
	    	 	$("#selectType").empty();
    		 	$.each( imgData, function( key, value ) {
	    		  $("#selectType").append('<div class="col-lg-4 col-md-4 col-xs-6 thumb"><a  onclick="getTypeData('+key+')" class="imgselect'+key+' thumbnail" style="height: 57px;"> <img id="img'+key+'"  class="img-responsive" src='+value+' alt=""></a></div>');
	    		});
	     },  
	     global: false,
	     error : function(e) {  
	      alert('Error: ' + e);   
	     }  
	 });  
}

function getTypeData(key){
	$('.selected').removeClass('selected');
    $('.imgselect'+key).addClass('selected');
	var imgSrc=$('#img'+key).attr('src');
	$("#myType").val(imgSrc);
}

function getMySignatureData(key){
	$('.selected').removeClass('selected');
	$('.imgselect'+key).addClass('selected');
	var imgSrc=$('#myimg'+key).attr('src');
	$("#mysignatutreVal").val(imgSrc);
}

function readImage() {
    if ( this.files && this.files[0] ) {
        var FR = new FileReader();
        FR.onload = function(e) {
             $('#img').attr( "src", e.target.result );
             $('#base').text( e.target.result );
        };       
        FR.readAsDataURL( this.files[0] );
    }
}

function modalPopBox(value){
	$("#imageField").val(value);
	$('#myModal').modal('show');
}
$("#asd").change(readImage);

</script>
<Script>
function showTabLogin(){
	$("#showTabLogin").css('display', '');
	$("#showLoginYesOrNo").hide();
	
}

function showTabRegister(){
	$("#showTabRegister").css('display', '');
	$("#showRegisterYesOrNo").hide();
}
function countdown(callback) {
    var bar = document.getElementById('progress'),
    time = 0, max = 5,
    int = setInterval(function() {
        bar.style.width = Math.floor(100 * time++ / max) + '%';
        if (time - 1 == max) {
            clearInterval(int);
            // 600ms - width animation time
            callback && setTimeout(callback, 100);
        }
    }, 1000);
}

countdown(function() {
    $("#show_progress").hide();
	$("#show_landing").show();
	var theme=$("#theme").val();
	$(".navbar-default").css('background-color', '#'+theme+' !important');
	$(".progress3 .bar").css('background-color', ''+theme+' !important');
	$(".progress3 .bar").css('background-image' ,'linear-gradient(to bottom, #b01919, #b01919) !important');
	
	var fileMsg=$("#fileMsg").val();
	if(fileMsg=="" || fileMsg==null){
		 var drysignlink=$("#linktodrysign").val();
		 if(drysignlink == "YES"){
		 		checkUserIsExistOrNot();
		 		$('#showmysignature').hide();
		 		
		 }
		 else if(drysignlink == "NO"){
			 $('#modalMessage').modal('show');
			 $('#showmysignature').hide();
			 
			 
		 }
		
	}else{
		$('#existUserPopUp').modal('hide');
		$('#notExistUserPopUp').modal('hide');	
		$('#modalMessage').modal('hide');
		//$('#checkExistUserMessage').modal('hide');
	}	
	
});

function isEmpty(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop))
            return false;
    }

    return true;
}
</Script>

<script src="<%=serverUrl %>/js/json2.min.js"></script>
<script src="<%=serverUrl %>/js/bootstrap.min.js"></script>
<%-- <script src="<%=serverUrl %>/js/jquery-1.3.2.js" type="text/javascript"></script>  --%>
<%-- <script src="<%=serverUrl %>/js/scroll-startstop.events.jquery.js" type="text/javascript"></script> --%>
<script>
	$(function() {
		var $elem = $('#content');
	
		$('#nav_up').fadeIn('slow');
		$('#nav_down').fadeIn('slow');  
		
		/* $(window).bind('scrollstart', function(){
			//$('#nav_up,#nav_down').stop().animate({'opacity':'0.2'});
			alert('SS start');
			$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_right_002.png)');
			$("#nav_down").css('width','87px');
			$("#nav_down").css('left','97px');
			
		});
		$(window).bind('scrollstop', function(){
			alert('SS stop');
			$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_right_002.png)');
			$("#nav_down").css('width','87px');
			$("#nav_down").css('left','97px');
			
		}); */
		var $output = $( "#output" ),
		scrolling = "<span id='scrolling'>Scrolling</span>",
		stopped = "<span id='stopped'>Stopped</span>";

		$( window ).scroll(function() {
	    	$output.html( scrolling );
	    	//alert($elem.height());
	    	var pixel=1192;
	    	if(pixel == 1192){
	    		$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_right_002.png)');
				$("#nav_down").css('width','87px');
				$("#nav_down").css('left','-88px');
	    	}else{
	    		$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_down_004.png)');
		    	$("#nav_down").css('position','fixed');
		    	$("#nav_down").css('left','147px');	
	    	}
	    	//$('html, body').animate({scrollTop: $elem.height()}, 800);
	    	
	    	//position: absolute;
			clearTimeout( $.data( this, "scrollCheck" ) );
			$.data( this, "scrollCheck", setTimeout(function() {
				$output.html( stopped );
			}, 250) );

		});
		
		$('#guide').click(
				function (e) {
					//alert($elem.height())
					var setIndex=parseInt($("#setIndexPixel").val());
					var checkFlag=$("#checkFlag").val();
					var fieldLength=parseInt($("#fieldLength").val());
					var contextPath=$("#contextPath").val();
					var setIndexPixel;
					var setPixel=guideMe(setIndex)
					var showSetPixel=parseInt(setPixel)-parseInt(38);
					$('html, body').animate({scrollTop: +showSetPixel+'px'}, 800);
					if(checkFlag == 'true'){
						
						if(setIndex >= fieldLength-1){
							$("#checkFlag").val('false');
							setIndexPixel = parseInt(setIndex)-1;
							$("#setIndexPixel").val(setIndexPixel);
						}else{
							$("#checkFlag").val('true');
							setIndexPixel = parseInt(setIndex)+1;
							$("#setIndexPixel").val(setIndexPixel);
						}
						
					}else if(checkFlag == 'false'){
						if(setIndex == 0){
							$("#checkFlag").val('true');
							setIndexPixel = parseInt(setIndex)+1;
							$("#setIndexPixel").val(setIndexPixel);
						}else{
							setIndexPixel = parseInt(setIndex)-1;
							$("#setIndexPixel").val(setIndexPixel);
						}
					}
					$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_right_002.png)');
					$("#nav_down").css('width','87px');
					$("#nav_down").css('left','-88px');
					$("#nav_down").css('top',showSetPixel);	
					
				}
			);
		
		$('#nav_down').click(
			function (e) {
				var contextPath=$("#contextPath").val();
				var setIndex=parseInt($("#setIndexPixel").val());
				var checkFlag=$("#checkFlag").val();
				var fieldLength=parseInt($("#fieldLength").val());
				var contextPath=$("#contextPath").val();
				var setIndexPixel;
				var setPixel=guideMe(setIndex)
				var showSetPixel=parseInt(setPixel)-parseInt(38);
				$('html, body').animate({scrollTop: +showSetPixel+'px'}, 800);
				if(checkFlag == 'true'){
					if(setIndex >= fieldLength-1){
						$("#checkFlag").val('false');
						setIndexPixel = parseInt(setIndex)-1;
						$("#setIndexPixel").val(setIndexPixel);
					}else{
						$("#checkFlag").val('true');
						setIndexPixel = parseInt(setIndex)+1;
						$("#setIndexPixel").val(setIndexPixel);
					}
				}else if(checkFlag == 'false'){
					if(setIndex == 0){
						$("#checkFlag").val('true');
						setIndexPixel = parseInt(setIndex)+1;
						$("#setIndexPixel").val(setIndexPixel);
					}else{
						setIndexPixel = parseInt(setIndex)-1;
						$("#setIndexPixel").val(setIndexPixel);
					}
				}
					$("#nav_down").css('background-image','url('+contextPath+'/images/arrow_right_002.png)');
					$("#nav_down").css('width','87px');
					$("#nav_down").css('left','-88px');
					$("#nav_down").css('top',showSetPixel);	
			}
		);
		$('#nav_up').click(
			function (e) {
				$('html, body').animate({scrollTop: '0px'}, 800);
			}
		);
          });
	
	function guideMe(index){
		//scroll pixels
		var jsonArray = [];

		var fieldLength=$("#fieldLength").val();
		//Create JSON array
		for(var i=0; i<fieldLength; i++) {
			var item = {};
			
			//alert($("#field_"+i).val()+" test "+$("#field_"+i).css('top').slice(0, -2));
			if($("#field_"+i).val() == ""){
			item ["pixels"] =$("#field_"+i).css('top').slice(0, -2);
			jsonArray.push(item);
			}
		
			
		}
		
		var setPixel;
		var setIndexPixel=$("#setIndexPixel").val();
		//Iterate JSON array
		$.each(jsonArray, function(i, item) {
			//alert(jsonArray[i].pixels);
			setPixel=jsonArray[setIndexPixel].pixels;
		});
		
		return setPixel;
	}
	
	function closeBar(){
		var redirecturl = $("#redirecturl").val();
		if(redirecturl == "" || redirecturl == undefined){
			var contextPath=$("#contextPath").val();
			window.location.href=contextPath+'login';
		}else{
			window.location.href=redirecturl;
		}
	}
		
	function sortByKey(array, key) {
	    return array.sort(function(a, b) {
	        var x = a[key]; var y = b[key];
	        return ((x < y) ? -1 : ((x > y) ? 1 : 0));
	    });
	}
		
        </script>
        
		<script type="text/javascript" src="<%=serverUrl %>/js/index.js"></script>
		<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/additional-methods.js"></script>
<script src="<%=serverUrl %>/js/uploadfile.js"></script>

<!-- NEW POP UP JS -->

  


</body>
</html>