<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
</div>
            <!-- /right_col -->
         </div>
         <!-- /page content -->
      </div>
      <!-- /container body -->
      <!-- footer content -->
      <footer class="main-footer">
         <div class="container-fluid">
            <div class="row">
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                 <%--  <img class="img-responsive footer_A" src="<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() %>/images/ui/images/E-Sign_Square.png" width="160" height="auto" alt="Logo" title="Logo"  /> --%> 
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 text-center">
                  <p class="footer_B">Copyright &copy; 2016, SourceHOV</p>
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4 social text-center">
                  <!-- <ul class="footer_ul footer_C">
                     <li><a href="#"><i class="fa fa-lg fa-facebook"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-twitter"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-google-plus"></i></a></li>
                     <li><a href="#"><i class="fa fa-lg fa-linkedin"></i></a></li>
                  </ul> -->
               </div>
            </div>
         </div>
      </footer>
      <!-- /footer content -->

<script src="<%=appUrl %>/js/ui/js/bootstrap.min.js"></script>
<script src="<%=appUrl %>/js/ui/js/nicescroll/jquery.nicescroll.min.js"></script>
<script src="<%=appUrl %>/js/ui/js/custom.js"></script>
<script src="<%=appUrl %>/js/sketch.min.js" type="text/javascript"></script>

   </body>
</html>