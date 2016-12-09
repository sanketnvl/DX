<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet">
<jsp:include page="header.jsp" />
	
	
	<div class="thumbnail" id="setimage">
						<c:if test="${not empty lists}">

							<div class="row">
							
								
								<c:forEach var="listValue" items="${lists}" varStatus="theCount">

									<div class="col-sm-6 col-md-3">
										<div id="loader" style="display:none">Verifying file...</div>
										<div class="thumbnail">
											<!-- <img src = "" alt = "Generic placeholder thumbnail"> -->
											<li class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></li>
										</div>

										<div class="caption">
											<h6 id="img_${theCount.index}">${listValue}</h6>
											<p>
												<a onclick="viewdownloadPDF('internal','${listValue}')" <%-- href="<c:url value='/download/internal?fileName=${listValue}'/>" --%> class="btn btn-warning btn-xs" role="button">View</a> 
													<%-- <a href="<c:url value='/download/external?fileName=${listValue}'/>"
													class="btn btn-danger btn-xs" role="button">Download</a> --%>
											</p>

										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</div>
					
					

	<script>
		function viewdownloadPDF(type, index) { 
			   $.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/download/" + type,
				data : "fileName=agreement.pdf",
				
				beforeSend: function() {
				     $('#loader').show();
				  },
				  complete: function(){
				     $('#loader').hide();
				  },
				
				success : function(response) {
					
					if(response){
						alert("Your file is verified");
						window.open('download/'+type+'?fileName='+index);
					}else{
						alert("Error in File Verification.");
					}
					

				}
			});
		}
	</script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<jsp:include page="footer.jsp"></jsp:include>