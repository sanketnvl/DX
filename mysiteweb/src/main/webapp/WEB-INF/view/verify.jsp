<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


 <jsp:include page="outer_header.jsp" />
<style>
header{background: white;}
.navbar {min-height: 100px;background: #d4d4d4 !important;color: #333;}
.navbar-default .nav > li>a, .navbar-default .nav>li>a:focus {color: #292626 !important;}
</style>
<section>
      
     
      
<div class="row large SNTerms">
	<div class="SNSection SNTermsPage">
		<div class="SNCenter820">
			<div class="SNCenter960">
				 <h2 style="font-size: 22px !important;color: #5890CD;text-align: center;padding: 30px 0px;"> Account Verification</h2>
				
				 <p style="text-align: center;">
				 
				 <c:choose>
				    <c:when test="${ message == '1'}">
				         <span style="color:green;">Your account has been activated successfully.</span><br/>
                         <a style="color:black;font-weight:bold;" href="login" >Login</a>
                         </p>
				    </c:when>
				    <c:otherwise>
				       <span style="color:red;">${message}</span>
				    </c:otherwise>
				</c:choose>
				
                        
			</div>
		</div>
	</div>
</div>      
      
      </section>
      
      
<jsp:include page="outer_footer.jsp" />