<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"></jsp:include>
<h1>Self Sign</h1>

<div class="side divbeautify">

<ul>
  <li><a class="active" href="dashboard">Dashboard</a></li>
  <li><a href="pdf">Self</a></li>
  <li><a href="groupsign">Group</a></li>
  <li><a href="outforsignature">Out for Signature</a></li>
    <li><a href="completeddocuments">Completed Documents</a></li>
</ul>

</div>
<div class="rightside divbeautify">
		<div class="fileupload divbeautify">
	
			<div class="fileupload">
		 	<form class="form" action="upload?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
				<input type="file" name="file" required>
				<input type="submit" value="Upload">
			</form>
		
		
		
				<c:if test="${not empty fileMsg}">
				    <div class="error alert-box">${fileMsg}</div>
				</c:if>
				
				<c:if test="${not empty list }">
				<h3>List of Files</h3>
				
				<ol>
				<c:forEach items="${list }" var="l">
				<li><a href="appsigndoc?fname=${l}">${l}</a> <a class="delete" href="deletefile?fname=${l}">x</a></li>
				</c:forEach>
				</ol>
				
				</c:if>
			</div>
		</div>
</div>

<jsp:include page="footer.jsp"></jsp:include>