<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<jsp:include page="header.jsp"></jsp:include>


<article>
			
<<h1 id="banner">Unauthorized Access !!</h1>
     
        <hr />
     
        <c:if test="${not empty error}">
            <div style="color:red">Caused : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
            </div>
        </c:if>
     
        <p class="message">Access denied!</p>
        <a href="${pageContext.request.contextPath}/web">Go back to login page</a>
	
	
</article>		


<jsp:include page="footer.jsp"></jsp:include>