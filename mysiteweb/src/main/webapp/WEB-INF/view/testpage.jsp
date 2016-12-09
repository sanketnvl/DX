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
      <title>DrySign - Prepare Document</title>
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
      <link rel="stylesheet" href="<%=appUrl %>/css/1.0/bootstrap.min.css">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
      <link href="<%=appUrl %>/css/1.0/fileinput.css" media="all" rel="stylesheet" type="text/css" />
      <!-- custom style -->
      <link rel="stylesheet" href="<%=appUrl %>/css/1.0/datepicker3.css">
      <link rel="stylesheet" href="<%=appUrl %>/css/1.0/icons.css">
      <link rel="stylesheet" href="<%=appUrl %>/css/1.0/drysign1.0.css">
      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->

   </head>
   <body class="hold-transition skin-blue sidebar-mini">
      <div class="wrapper">
         <!-- Main Header -->
         <header class="main-header">
            <!-- Logo -->
            <a href="#" class="logo">
               <!-- mini logo for sidebar mini 50x50 pixels -->
               <span class="logo-mini"><b>D</b>S</span>
               <!-- logo for regular state and mobile devices -->
               <span class="logo-lg"><img class="img-responsive" src="<%=appUrl %>/images/1.0/drysignlogo.png" alt="logo"> </span>
            </a>
            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
               <!-- Sidebar toggle button-->
              
               <!-- Navbar Right Menu -->
               <div class="navbar-custom-menu">
                  <ul class="nav navbar-nav">
                     <li class="dropdown notifications-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-notification" style="color:#fff;font-size:22px;"></i>
                        <span class="label label-warning">10</span>
                        </a>
                        <ul class="dropdown-menu">
                           <li class="header">You have 10 notifications</li>
                           <li>
                              <!-- Inner Menu: contains the notifications -->
                              <ul class="menu">
                                 <li>
                                    <!-- start notification -->
                                    <a href="#">
                                    <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                    </a>
                                 </li>
                                 <!-- end notification -->
                              </ul>
                           </li>
                           <li class="footer"><a href="#">View all</a></li>
                        </ul>
                     </li>
                     <li>
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle">
                        <i class="icon-log-out" style="color:#fff;font-size:22px;"></i><span style="color:#fff;font-size:14px;position:relative;top:-6px;left:10px;">Log out</span>
                        </a>
                     </li>
                  </ul>
               </div>
            </nav>
         </header>
         <!-- Left side column. contains the logo and sidebar -->
         
         <!-- Content Wrapper. Contains page content -->
         <div class="bg_wrap">
            <!-- Main content -->
           <section>
           <div class="row margTB20">
           <div class="col-xs-12 text-center">
           	<button type="button" class="btn btn-primary prev-step margR15" value="Back"> <i class="fa fa-times-circle-o" aria-hidden="true"></i>Close</button>
            <button type="button" class="btn btn_2 prev-step" value="close"> Finish <i class="fa fa-check-circle-o" aria-hidden="true"></i> </button>
           </div>
           
           </div>
           <hr/>
           <div class="row">
           <div class="col-md-2 col-sm-3 col-xs-12 button-hide">
           	<ul class="list-group">
           <li>
            <button type="button" value="Signature" class="btn btn-flat"><i class="fa fa-pencil" aria-hidden="true"></i> <span>Signature</span></button></li>
                  <li><button type="button" value="Check Mark" class="btn btn-flat"><i class="fa fa-check" aria-hidden="true"></i> <span>Check Mark</span></button></li>
                 <li> <button type="button" value="Date" class="btn btn-flat"><i class="fa fa-calendar" aria-hidden="true"></i><span> Date</span></button></li>
                 <li> <button type="button" value="Text" class="btn btn-flat"><i class="fa fa-list-ul" aria-hidden="true"></i><span> Text</span></button></li>
                  <li><button type="button" value="Title" class="btn btn-flat"> <i class="fa fa-text-width" aria-hidden="true"></i><span> Title</span></button></li>
            
            </ul>
           </div>
           <div class="col-md-9 col-sm-9 col-xs-12 margB20 pdfbg">
           
           <div class="signature">
           <div class="row ">
           <div class="col-xs-12 margTB20">
           	<h2 class="text-center">DrySign</h2>
            </div>
          
          <div class="col-xs-12">
            	<div class="grap-div-front">
                	
                    <form class="form-inline editableform" style="">
                      <div class="control-group form-group">
                        <div class="drag-div-front">
                          
                           
                          <div class="selectParent">
                  <select name="" id="" class="form-control" title="Name">
                    <option >Sanket Navale</option>
                    <option>Dhananjay</option>
                  </select>
                </div>
                           
                            
                          <div class="editable-buttons">
                           <!-- <button type="submit" class="btn btn-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></button> -->
                            <button type="button" class="btn btn-default btn-sm editable-cancel"><i class="glyphicon glyphicon-remove"></i></button>
                          </div>
                      
                        
                      </div>
                    
                   
                </div>
            	</form>
             </div>
          
           <div style="height: 50px; clear:both">&nbsp;</div>
            <div class="col-xs-12">
            	<div class="grap-div-front">
                	
                    <form class="form-inline editableform" style="">
                      <div class="control-group form-group">
                        <div class="drag-div-front">
                          <div class="editable-input" style="position: relative;">
                           
                            <input id="txt" type="text"  class="form-control input-sm" placeholder="Text , Title" onkeypress="this.style.width = ((this.value.length + 6) * 6) + 'px';">
                             <button type="submit" class="btn btn-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></button>
                            <span class="editable-clear-x" style="display: none;"></span></div>
                          <div class="editable-buttons">
                           
                            <button type="button" class="btn btn-default btn-sm editable-cancel"><i class="glyphicon glyphicon-remove"></i></button>
                          </div>
                        </div>
                        
                      </div>
                    </form>
                   
                </div>
            	
             </div>
              
            
           <div style="height: 50px; clear:both">&nbsp;</div>
            
            
            <div class="col-xs-12 xy">
              
             <input type="checkbox" id="test120" class="add-attr" tabindex="3" checked="">
                          <label for="test120"></label>
            </div> 
            
           <div style="height: 50px; clear:both">&nbsp;</div>
            
            
            <div class="col-xs-12">
            	<div class="grap-div-front">
                	
                    <form class="form-inline editableform" style="">
                      <div class="control-group form-group">
                        <div class="drag-div-front">
                          <div class="editable-input" style="position: relative;">
                           
                            <div class="form-group">
                <div class="input-group date" id="datepicker">
                    <input type="text" placeholder="Date"  class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
                            <span class="editable-clear-x" style="display: none;"></span></div>
                          <div class="editable-buttons">
                      
                            <button type="button" class="btn btn-default btn-sm editable-cancel"><i class="glyphicon glyphicon-remove"></i></button>
                          </div>
                        </div>
                        
                      </div>
                    </form>
                   
                </div>
            	
             </div>
            
            <div style="height: 50px; clear:both">&nbsp;</div>
            
            <div class="col-xs-12">
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            </div>
           
           </div>
           
           </div>
          
         </div>
         </div>
           </section>
            <!-- /.content -->
         </div>
         <!-- /.content-wrapper -->
         <!-- Main Footer -->
        
      </div>
      <!-- ./wrapper -->
      <!-- REQUIRED JS SCRIPTS -->
   	  <script src="<%=appUrl %>/js/1.0/jquery.min.js"></script>
      <script src="<%=appUrl %>/js/1.0/bootstrap.min.js"></script>
      <script src="<%=appUrl %>/js/1.0/bootstrap-datepicker.js"></script>
      <script src="<%=appUrl %>/js/1.0/app.min.js"></script>
      <!-- For Upload -->
      <script src="<%=appUrl %>/js/1.0/fileinput.js" type="text/javascript"></script>
      <script src="<%=appUrl %>/js/1.0/fileinput_locale_fr.js" type="text/javascript"></script>
      <script src="<%=appUrl %>/js/1.0/fileinput_locale_es.js" type="text/javascript"></script>
      <!--  Upload and Drag script  -->
      
      
      <script>
	  $("#datepicker").datepicker({autoclose: true});
         $('#file-fr').fileinput({
             language: 'fr',
             uploadUrl: '#',
             allowedFileExtensions : ['jpg', 'png','gif'],
         });
         $('#file-es').fileinput({
             language: 'es',
             uploadUrl: '#',
             allowedFileExtensions : ['jpg', 'png','gif'],
         });
         $("#file-0").fileinput({
             'allowedFileExtensions' : ['jpg', 'png','gif'],
         });
         $("#file-1").fileinput({
             uploadUrl: '#', // you must set a valid URL here else you will get an error
             allowedFileExtensions : ['jpg', 'png','gif'],
             overwriteInitial: false,
             maxFileSize: 1000,
             maxFilesNum: 10,
             //allowedFileTypes: ['image', 'video', 'flash'],
             slugCallback: function(filename) {
                 return filename.replace('(', '_').replace(']', '_');
             }
         });
         /*
         $(".file").on('fileselect', function(event, n, l) {
             alert('File Selected. Name: ' + l + ', Num: ' + n);
         });
         */
         $("#file-3").fileinput({
         showUpload: false,
         showCaption: false,
         browseClass: "btn btn-primary btn-lg",
         fileType: "any",
             previewFileIcon: "<i class='glyphicon glyphicon-king'></i>"
         });
         $("#file-4").fileinput({
         uploadExtraData: {kvId: '10'}
         });
         $(".btn-warning").on('click', function() {
             if ($('#file-4').attr('disabled')) {
                 $('#file-4').fileinput('enable');
             } else {
                 $('#file-4').fileinput('disable');
             }
         });    
         $(".btn-info").on('click', function() {
             $('#file-4').fileinput('refresh', {previewClass:'bg-info'});
         });
         /*
         $('#file-4').on('fileselectnone', function() {
             alert('Huh! You selected no files.');
         });
         $('#file-4').on('filebrowse', function() {
             alert('File browse clicked for #file-4');
         });
         */
         $(document).ready(function() {
             $("#test-upload").fileinput({
                 'showPreview' : false,
                 'allowedFileExtensions' : ['jpg', 'png','gif'],
                 'elErrorContainer': '#errorBlock'
             });
             /*
             $("#test-upload").on('fileloaded', function(event, file, previewId, index) {
                 alert('i = ' + index + ', id = ' + previewId + ', file = ' + file.name);
             });
             */
         
         
         $(window).on("load resize", function(e) {
         var viewportWidth = $(window).width();
         if (viewportWidth < 769) {
         (function($) {
         $("body").addClass('sidebar-collapse');
         })(jQuery);
         } else {
         $("body").removeClass('sidebar-collapse');
         }
         });
         
         
         $(document).ready(function() {
         $(".icon_1").css("color","#f0ad4d");
         $(".para2").css("color","#5890cd");
         $(".row_5").css("display","none");
         
         $("#test1").change(function() {
         if(this.checked) {
         $(".icon_1").css("color","#f0ad4d");
         $(".para2").css("color","#5890cd");
         
         }else{
         $(".icon_1").css("color","#cccccc");
         $(".para2").css("color","#cccccc");	}
         });
         
         $("#test12").change(function() {
         if(this.checked) {
         $(".icon_2").css("color","#f0ad4d");
         $(".para3").css("color","#5890cd");
         
         $(".row_4").css("display","none");
         $(".row_5").css("display","block");
         
         
         }else{
         $(".icon_2").css("color","#cccccc");
         $(".para3").css("color","#cccccc");	
         $(".row_4").css("display","block");
         $(".row_5").css("display","none");
         
         }
         
         });
         
         
         });
         
         });
      </script>
   </body>
</html>

