<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>
  <!-- /.content-wrapper --> 
  <!-- Main Footer -->
  <footer class="main-footer text-center"> 
    <!-- To the right -->
    <div class="social footer_div pull-right hidden-xs">
      <ul class="footer_ul">
       
      </ul>
    </div>
    <!-- Default to the left --> 
    Copyright &copy; 2016,DrySign </footer>
  
</div>
<!-- ./wrapper --> 
<!-- REQUIRED JS SCRIPTS --> 
<script src="<%=appUrl %>/js/1.0/jquery-ui.js"></script> 
<script src="<%=appUrl %>/js/1.0/bootstrap.min.js"></script> 
<script src="<%=appUrl %>/js/1.0/app.min.js"></script> 

<script>
$(document).ready(function() {
   	
	 $(window).load(function() {
		 $(".loader").fadeOut("slow");
	  });
	// store url for current page as global variable
	current_page = document.location.href
	// apply selected states depending on current page
 	if (current_page.match(/web/)) {
 	$("ul#headernavigation li:eq(0)").addClass('active');
 	} else if (current_page.match(/document/)) {
 	$("ul#headernavigation li:eq(1)").addClass('active');
 	}else if (current_page.match(/outforSignature/)) {
 	$("ul#headernavigation li:eq(2)").addClass('active');
 	}else if (current_page.match(/completedDocuments/)) {
 	$("ul#headernavigation li:eq(3)").addClass('active');
 	}else if (current_page.match(/draft/)) {
 	$("ul#headernavigation li:eq(4)").addClass('active');
 	}else { // don't mark any nav links as selected
 	$("ul#headernavigation li").removeClass('active');
 	};
});


   	</script>

 
</body>
</html>
