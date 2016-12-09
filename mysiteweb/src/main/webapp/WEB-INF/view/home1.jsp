<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="<c:url value='css/bootstrap.min.css' />">
<script src="<c:url value='js/jquery.min.js' />"></script>
<script src="<c:url value='js/jquery-ui.js' />"></script>
<script src="<c:url value='js/draggable.js' />"></script>
<link rel="stylesheet" href="<c:url value='css/signature-pad.css' />">
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<style>

</style>
<link href="css/signaturepad.css" rel="stylesheet" />
  
  <script type="text/javascript">
   function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
   }
</script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>

 <jsp:include page="header.jsp" /> 


 <div class="col-sm-12 shape" id="draggable1">

	<div id="signer-1" class="col-sm-6 col-sm-6 dragMe dragSigners" data-signer-id="1" data-document-id="1">
       <span>Name</span>
       <span class="closeIt hideIt">x</span>
     </div>
     
     <div id="signer-2" class="col-sm-6 col-sm-6 dragMe dragSigners" data-signer-id="2" data-document-id="1">
       <span>Date</span>
       <span class="closeIt hideIt">x</span>
     </div>
     
     <div id="signer-3" class="col-sm-6 col-sm-6 dragMe dragSigners" data-signer-id="3" data-document-id="1">
       <span>Signature</span>
       <span class="closeIt hideIt">x</span>
     </div>
     
     
     <button type="button" onclick="saveDocumentSign()" id="done" class="btn btn-default dropdown-toggle">Done</button>

</div> 




<div >
	<div class="wrapper">
		${fileMsg}
		<input type="hidden" id="fileName" value="${filename}"/>
		<div class="page">
			<div class='document-reader' id="document-reader">
				<c:forEach var="page" begin="1" end="${numpages}">
					<div class="pageimg">
						<img id="form_bill_of_sale" src="img?filename=${filename}&page=${page}" />
						
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

 <!-- Modal -->
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	 
			  <ul class="nav nav-tabs" role="tablist">
<!-- 			    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Type</a></li> -->
			    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Draw</a></li>
			    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Upload</a></li>
			    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab" >My Signature</a></li>
			  </ul>
	      </div>
	      <div class="modal-body">
	       <div class="tab-content">
   			 <div role="tabpanel" class="tab-pane active" id="home">
   			   
   	
   			 </div> 
	    	 <div role="tabpanel" class="tab-pane" id="profile"> 
	    	  
<div class="sigPad" id="linear" style="width:404px; margin-top:10px;">
<!-- <h2>Linear Interpolation (Original)</h2> -->
<ul class="sigNav">
<!-- <li class="drawIt"><a href="#draw-it" >Draw It</a></li> -->
<li class="clearButton"><a href="#clear">Clear</a></li>
</ul>
<div class="sig sigWrapper" style="height:auto;">
<div class="typed"></div>
<canvas class="pad" width="400" height="250" id="can"></canvas>
<input type="hidden" name="output" class="output">
</div>
</div>
  </div>
	    	<%--  <div id="signature-pad" class="m-signature-pad" style=" display: none;">
    <div class="m-signature-pad--body">
      <canvas></canvas>
    </div>
    <div class="m-signature-pad--footer">
      <div class="description">Sign above</div>
      <button type="button" class="button clear" data-action="clear">Clear</button>
      <button type="button" class="button save" data-action="save">Save</button>
    </div>
  </div> --%>

 
	         <div role="tabpanel" class="tab-pane" id="messages">
	         	<input type="file" name="filename" id="myFile" onchange="loadImageFileAsURL();"/>
	         </div>
	         <div role="tabpanel" class="tab-pane" id="settings">
                <div class="row">
         			<div class="col-lg-3 col-md-4 col-xs-6 thumb" id="signimg">
		                <a class="thumbnail" href="#">
		                    <img id="img1" class="img-responsive" src="data:image/png;base64,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" alt="">
		                </a>
		            </div>
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
<script> src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="js/numeric.js"></script> 
<script src="js/bezier.js"></script> 
<script src="js/signaturepad.js"></script> 
<script>
    $(document).ready(function() {
      $('#linear').signaturePad({drawOnly:true, lineTop:200});
      $('#smoothed').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:200});
      $('#smoothed-variableStrokeWidth').signaturePad({drawOnly:true, drawBezierCurves:true, variableStrokeWidth:true, lineTop:200});
    });
  </script> 
<script src="js/jsonmin.js"></script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!--

//-->

 <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<jsp:include page="footer.jsp"></jsp:include>