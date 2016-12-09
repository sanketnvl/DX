<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% 
String port = request.getServerPort()+"";
if(port !=null || port != "")
{
	port = ":" + port;
}
String appUrl = request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
%>

<script src="<%=appUrl %>/js/groupsign.js"></script>
<link rel="stylesheet" href="<%=appUrl %>/css/signaturepad.css">
<link rel="stylesheet" href="<%=appUrl %>/css/signaturepopup.css">
<link href='https://fonts.googleapis.com/css?family=Indie+Flower' rel='stylesheet' type='text/css'>



<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>

<div>
	<div class="wrapper">
		${fileMsg} <input type="hidden" id="fileName" value="${filename}" />
		<div class="page">
			<div class='document-reader' id="document-reader">
				<c:forEach var="page" begin="1" end="${numpages}">
					<div class="pageimg" id="${page}" data-doc-id="${page}">
						<img width="890" src="<%=appUrl %>/img?fileid=${fileid}&filename=${filename}&page=${page}" />

					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="fname" value="<%= request.getParameter("fname").toString()%>" />
<input type="hidden" id="imageField" value=""/>
<input type="hidden" id="fieldLength" value=""/>
<input type="hidden" id="myType" value="asd"/>
<input type="hidden" id="initial" value="0.0"/>

<script src="<%=appUrl %>/js/numeric.js"></script> 
<script src="<%=appUrl %>/js/bezier.js"></script> 
<script src="<%=appUrl %>/js/signaturepad.js"></script> 

<script src="<%=appUrl %>/js/signaturepopup.js"></script> 

