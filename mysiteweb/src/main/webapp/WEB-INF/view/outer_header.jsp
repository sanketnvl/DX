
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="">
      <meta name="author" content="">
      <title>DrySign</title>
      <!-- Bootstrap Core CSS -->
      <link rel="stylesheet" href="<c:url value="css/ui/index/css/bootstrap.min.css" />" type="text/css">
      <!-- Custom Fonts -->
      <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
      <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">     

      <link rel="stylesheet" href="<c:url value="css/ui/index/font-awesome/css/font-awesome.min.css" />" type="text/css">
      <link rel="stylesheet" href="<c:url value="css/ui/index/css/styles.css" />" type="text/css">
      <!-- Plugin CSS -->
      <link rel="stylesheet" href="<c:url value="css/ui/index/css/animate.min.css" />" type="text/css">
      <!-- Custom CSS -->
      <link rel="stylesheet" href="<c:url value="css/ui/index/css/creative.css" />" type="text/css">
      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
   </head>
   <style>
      ::-webkit-input-placeholder {
      font-size: 16px;
      color: #555;
      text-align: left;
      font-weight: normal;
      }
      :-moz-placeholder { /* older Firefox*/
      font-size:16px;
      color: #555;
      text-align: left;
      font-weight: normal;
      }
      ::-moz-placeholder { /* Firefox 19+ */ 
      font-size: 16px;
      color: #555; 
      text-align: left;
      font-weight: normal;
      } 
      :-ms-input-placeholder { 
      font-size: 16px; 
      color: #555;
      text-align: left;
      font-weight: normal;
      }
      
/*       @charset "UTF-8";

@font-face {
  font-family: "untitled-font-3";
  src:url("<c:url value="css/ui/fonts/untitled-font-3.eot" />");
  src:url("<c:url value="css/ui/fonts/untitled-font-3.eot?#iefix" />") format("embedded-opentype"),
    url("<c:url value="css/ui/fonts/untitled-font-3.woff" />") format("woff"),
    url("<c:url value="css/ui/fonts/untitled-font-3.ttf" />") format("truetype"),
    url("<c:url value="css/ui/fonts/untitled-font-3.svg#untitled-font-3" />") format("svg");
  font-weight: normal;
  font-style: normal;

} */
/* .pageheading{
    text-align: center;
    padding-bottom: 1em;
    font-size:25px !important;
}
.row {
    width: 100%;
    margin-left: auto;
    margin-right: auto;
    margin-top: 0;
    margin-bottom: 0;
    max-width: 99.5rem;
}
.row.large, section.large {
    padding: 5em 0;
}
p {
    font-weight: 300;
    line-height: 1.75em;
    margin: 0 0 15px 0;
    font-size: 1em;
    color: #222;
}


.footer_1 {
        position: fixed;
    z-index: 100;
    width: 100%;
    bottom: 0;
    left: 0;
}
.navbar-brand{    height: 60px;
    width: 200px;}
    #contact p{color: white;} */
    
    .Foter{
    
        background-color: #333333;
    color: #fff;
    padding: 15px 0px;
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    
    }
    .forMat{
	
	padding: 30px 69px;
    text-align: justify;
    line-height: 2;
	
}

   </style>
   <body id="page-top">
   		
      <nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
         <div class="container-fluid bg">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
               <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
               <span class="sr-only">Toggle navigation</span>
               <span class="icon-bar"></span>
               <span class="icon-bar"></span>
               <span class="icon-bar"></span>
               </button>
               <a class="navbar-brand page-scroll"  href="index"><img src="<c:url value="images/ui/images/E-Sign_Square.png" />" alt="" class="logo_top"></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               <ul class="nav navbar-nav navbar-right">
                  <li>
                     <a href="key" class="page-scroll" href="#about">API</a>
                  </li>
                  <li>
                     <a href="pricing" class="page-scroll">PRICING</a>
                  </li>
                  <li>
                     <a href="#" class="page-scroll" href="#portfolio">FEATURES</a>
                  </li>
                  <li>
                     <a href="#" class="page-scroll" href="#contact">SOLUTIONS</a>
                  </li>
                  <li>
                     <a href="login" class="page-scroll" href="#contact1">SIGN IN</a>
                  </li>
               </ul>
            </div>
            <!-- /.navbar-collapse -->
         </div>
         <!-- /.container-fluid -->
      </nav>