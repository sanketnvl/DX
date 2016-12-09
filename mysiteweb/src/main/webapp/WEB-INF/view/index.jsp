 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <style>
 .container-fluid.bg {
    background: rgba(255, 255, 255, 0.43);
}
 </style>
 <jsp:include page="outer_header.jsp" />
 
      <header>
         <div class="header-content">
            <div class="header-content-inner padTop">
               <h1 style="background:rgb(23, 23, 23);opacity: .7;">GET THINGS DONE <span style="color:#F9B552;">QUICKLY!<span></h1>
               <form class="form-inline" style="margin-top:40px;">
                  <div class="form-group">
                     <input type="text" class="formstyle1" id="inputEmail" placeholder="Your Name">
                  </div>
                  <div class="form-group">
                     <input type="email" class="formstyle2" id="inputEmail" placeholder="Email Address">
                  </div>
                  <div class="form-group">
                     <button type="submit" class="buttonstyle">Get Started</button>
                  </div>
               </form>
               <p style="font-weight:500;background:rgb(23, 23, 23);opacity: .7;color:#F9B552;margin-top:30px;">"Leave your wet signatures behind"<br>"Sign anywhere,anytime or any device"</p>
               <a class="btn btn-circle" href="#">
               <i class="fa fa-angle-down animated"></i>
               </a>
            </div>
         </div>
      </header>
      <section id="about" class="sectionAbout" style="padding:30px 0px;">
         <div class="container adjust">
            <div class="row dry_banner_rw">
               <div class="col-lg-12 text-center">
                  <h2 class="headerStyle">Next-generation Digital Signature Platform</h2>
                  <br>
               </div>
            </div>
         </div>
         <div class="container container50">
            <div class="row dry_rw">
               <div class="col-xs-12 col-sm-6 col-md-7 no-padding">
                  <div class="bg-image1">
                     <img src="<c:url value="images/ui/index/img/Layer 1 copy 3.png" />" alt="" class="img-responsive">
                  </div>
                  <!-- /.presentation -->                
               </div>
               <!-- /.col -->
               <div class="col-xs-12 col-sm-6 col-md-5 bg-image2 no-padding">
                  <div class="row padBB">
                     <div class="what-grids">
                        <div class="what-left">
                           <span class="fa fa-globe" style="font-size:40px;"></span>
                        </div>
                        <div class="what-right">
                           <h4 style="text-align:left;">Universal</h4>
                           <p style="text-align:left;">Execute documents on any device and any operating system</p>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
                  <div class="row">
                     <div class="what-grids">
                        <div class="what-left">
                           <span class="fa fa-gear" style="font-size:40px;"></span>
                        </div>
                        <div class="what-right">
                           <h4 style="text-align:left;">Configurable</h4>
                           <p style="text-align:left;">Set time, date & signature workflow</p>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
                  <div class="row">
                     <div class="what-grids">
                        <div class="what-left">
                           <span class="fa fa-gears" style="font-size:40px;" ></span>
                        </div>
                        <div class="what-right">
                           <h4 style="text-align:left;">Automated</h4>
                           <p style="text-align:left;">Authentication & reminders with fall audit trail</p>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
                  <div class="row">
                     <div class="what-grids">
                        <div class="what-left">
                           <span class="fa fa-lock" style="font-size:40px;"></span>
                        </div>
                        <div class="what-right">
                           <h4 style="text-align:left;">Secure</h4>
                           <p style="text-align:left;">All documents & certificates are stored for monitoring</p>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
               </div>
               <!-- /.col -->
            </div>
         </div>
         <div class="container container60">
            <div class="row dry_rw">
               <div class="col-lg-6 col-md-6 bg-image3 wrap1">
                  <h3>Remove Paper</h3>
                  <br>
                  <p>Eliminate the need for pens, fax, scanners, email or mail. Use DrySign to send and receive digital signatures with your colleagues, and business partners.
                  </p>
              
               </div>
               <div class="col-lg-6 col-md-6 bg-image4 wrap2">
                  <h3><span style="color:#E5A84F;">For Developers</span></h3>
                  <p>Intergrate DrySign with your applications to enable your users with fast and easy digital signatures.
                  </p>               
               </div>
            </div>
         </div>
      </section>
      <section id="services" class="sectionServices">
         <div class="container container70 dry_bottom">
            <div class="row dry_adj">
               <div class="col-lg-6 col-md-6 text-center">
                  <div class="service-box">
                     <i class="fa fa-mobile" style="font-size:50px;"></i>
                     <h3 class="textY">HAVE A QUESTION?</h3>
                     <p class="textX">+12345678910</p>
                  </div>
               </div>
            
               <div class="col-lg-6 col-md-6 text-center">
                  <div class="service-box">
                     <i class="	fa fa-envelope-o" style="font-size:42px;"></i>
                     <h3 class="textY">DROP US AN EMAIL</h3>
                     <p class="textX">contact@drysign.me</p>
                  </div>
               </div>
            </div>
         </div>
      </section>
      
      
 <jsp:include page="outer_footer.jsp" />      