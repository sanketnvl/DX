
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <jsp:include page="outer_header.jsp" />
<style>
header{background: white;}
.navbar {min-height: 100px;background: #d4d4d4 !important;color: #333;}
.navbar-default .nav > li>a, .navbar-default .nav>li>a:focus {color: #292626 !important;}

.wrap{
	margin: 0 auto;
	width: 80%;
}
body a{
	transition:0.5s all ease;
	-webkit-transition:0.5s all ease;
	-moz-transition:0.5s all ease;
	-o-transition:0.5s all ease;
	-ms-transition:0.5s all ease;
}
.pop_up{
		border: 9px solid#485460;
		border-radius: 1em;
		-o-border-radius: 1em;
		-moz-border-radius: 1em;
		-webkit-border-radius: 1em;
}
/* Styles for dialog window */
#small-dialog,#small-dialog1,#small-dialog2,#small-dialog3,#small-dialog4,#small-dialog5{
	background: white;
	padding:20px;
	text-align: left;
	max-width: 650px;
	margin: 40px auto;
	position: relative;
	text-align:center;
	border: 9px solid#eee;
	border-radius: 1em;
		-o-border-radius: 1em;
		-moz-border-radius: 1em;
		-webkit-border-radius: 1em;
}
/*Pricing table and price blocks*/
.price-head h1 {
text-align: center;
margin-top: 2em;
font-size: 3em;
color: #fff;
}
.price-head h3 {
	color: #404042;
	font-size: 3em;
	text-decoration: none;
	font-weight: 700;
}
.pricing-grids {
margin: 12% 0;
}
/*----*/
.pricing-grid1,.pricing-grid2,.pricing-grid3 {
width: 31.5%;
float: left;
text-align: center;
margin-right: 2%;
transition: 0.5s all;
-webkit-transition: 0.5s all;
-moz-transition: 0.5s all;
-o-transition: 0.5s all;
padding: 0;
border: none;
border-radius: 0.7em;
-webkit-border-radius: 0.7em;
-o-border-radius: 0.7em;
-moz-border-radius: 0.7em;
}
 .pricing-grid3{
 	margin-right: 0;
 }
.pricing-grid1:hover,.pricing-grid2:hover,.pricing-grid3:hover {
	transform: scale(1.05);
-webkit-transform: scale(1.05);
-moz-transform: scale(1.05);
-o-transform: scale(1.05);
-ms-transform: scale(1.05);
	z-index: 1;
	border: none;
}
.pricing-grid1:nth-child(3){
	margin-right:0;
}
.price-value h2 a,.price-value.two h3 a,.price-value.three h4 a{
	font-size: 1.8em;
	color:#fff;
}
.price-value,.price-value.two,.price-value.three {
	background: #512884;
	padding: 2.8em 1.8em 2em;
	border-bottom:2px solid#ffd500;
	border-top-left-radius:0.7em;
	-webkit-border-top-left-radius:0.7em;
	-o-border-top-left-radius: 0.7em;
	-moz-border-top-left-radius:0.7em;
	border-top-right-radius:0.7em;
	-webkit-border-top-right-radius:0.7em;
	-o-border-top-right-radius:0.7em;
	-moz-border-top-left-radius: 0.7em;
	position: relative;
}
.price-value.two{
	background:#2b2b33;
	border-bottom:2px solid#fd6e70;
}
.price-value.three {
	background: #04dbdd;
	border-bottom:2px solid#028f87;
}
.price-value ul,.pricing-grid1 ul,.pricing-grid2 ul,.pricing-grid3 ul{
	padding: 0;
}
.price-value ul li,.pricing-grid1,.pricing-grid2 ul li,.pricing-grid3 ul li {
	list-style: none;
}
.price-value ul li{
	list-style: none;
}
.price-value  h5 span{
color: #fbd707;
font-size: 19px;
}
.price-value lable{
color: #817d94;	
font-size: 17px;
}
.price-value.two h5 span{
	color:#fe6d72;
}
.price-value.two h5 lable{
	color:#8c8c94;
}
.price-value.three h5 span{
	color: #018f90;
}
.price-value.three h5 lable{
	color:#9CF7F8;
}
.price-value h5 {
padding: 11px 0;
}
.sale-box,.sale-box.two,.sale-box.three{
	position: absolute;
	top: 0;
	overflow: hidden;
	height: 130px;
	width: 143px;
	text-align: center;
	z-index: 0;
	right:0;
	border-top-right-radius: 0.7em;
	-o-border-top-right-radius: 0.7em;
	-moz-border-top-right-radius: 0.7em;
	-webkit-border-top-right-radius: 0.7em;
}
.sale-box.two.sale-box span.on_sale{
	background: #fa6e6f;
}
.sale-box.three.sale-box span.on_sale{
	background:#05AEA7;
}
.pricing-grid1 ul li a,.pricing-grid2 ul li a,.pricing-grid3 ul li a{
	color: #000;
	font-size: 15px;
	text-align: center;
	display: block;
	padding: 16px 0;
	text-decoration: none;
	font-weight: 400;
}
.pricing-grid1 ul li.whyt a,.pricing-grid2 ul li.whyt a,.pricing-grid3 ul li.whyt a{
	background:#f4f4f4;
}
.pricing-grid1:hover div.price-bg ul li a,.pricing-grid1:hover div.price-value h3 a{
 color:#512884;
}
.pricing-grid2:hover div.price-bg ul li a,.pricing-grid2:hover div.price-value h3 a{
 color:#fa6e6f;
}
.pricing-grid3:hover div.price-bg ul li a,.pricing-grid3:hover div.price-value h3 a{
	color:#04dbdd;
}
.price-bg {
	background: #fff;
}
.price-bg ul {
	padding: 0;
}
.price-bg ul li{
	list-style: none;
}
.cart1,.cart2,.cart3{
	padding: 2.7em 0em 2.7em;
	display: block;
	border-bottom: 2px solid#ffd500;
}
.cart2{
border-bottom: 2px solid#f96d70;
}
.cart3{
border-bottom: 2px solid#04dbdd;
}
.cart1 a,.cart2 a,.cart3 a{
	color: #FFF;
	font-size: 0.9em;
	font-weight: 500;
	padding: 0.8em 2em;
	text-decoration: none;
	background: #f7d30b;
	text-transform:uppercase;
	-webkit-appearance:none;
	border-radius:1em;
	-webkit-border-radius:1em;
	-o-border-radius:1em;
	-moz-border-radius:1em;
	outline: none;
}


</style>
<section>
   
<div class="row large SNTerms">
	<div class="SNSection SNTermsPage forMat">
		<div class="SNCenter820">
			<div class="SNCenter960">
				 <h2 style="font-size:22px;color:#5890CD;">Subscription Plans	</h2><br>
				
				<div class="pricing-plans">
					 <div class="wrap">
					 	
					 	
						<div class="pricing-grids">
						
						
						
						<c:forEach items="${plans}" var="plan">
						    <div class="pricing-grid1">
							<div class="">
									<h2><a href="#">${plan.planName}</a></h2>
									<h5><span>${plan.currency} ${plan.amount}</span><lable> / ${plan.numberOfDays} days</lable></h5>
									<div class="sale-box">
							
							</div>

							</div>
							<div class="price-bg">
							${plan.content}
							<div class="cart1">
								<a class="popup-with-zoom-anim" href="cart?product=${plan.planId}">Purchase</a>
							</div>
							</div>
						</div>
						</c:forEach>
						
	
						</div>	
					</div>				
				</div>
			</div>
		</div>
	</div>
</div>
</section>    
<jsp:include page="outer_footer.jsp" />