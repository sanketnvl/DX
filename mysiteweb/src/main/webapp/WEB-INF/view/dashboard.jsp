
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <jsp:include page="header.jsp" />
               <!-- Page Header -->
               <div class="row" style="background:#CCCCCC;">
                  <div class="col-lg-12">
                     <h3 class="page-header">Dashboard
                     </h3>
                  </div>
               </div>
               <!-- /.row -->
               <!-- Projects Row -->
               <div class="row rowpad PAD" style="margin-right:10px;">
                  <div class="col-xs-12 col-sm-12 col-md-6 portfolio-item">
				  <div class="col-ms-12 com-sm-12">
				  	<div class="panel panel-default">
					  <div class="panel-heading">Overview</div>
					  <div class="panel-body" style="height: 292px;">
					  
					  				<br>
					               <div class="list-group ">
                    	<a class="list-group-item " >
                            <!-- <i class="fa fa-chevron-right pull-right"></i> -->
                            <span class="badge badge-success" style="margin-right:14px;">
                            <%-- <c:if test="${docCount}"></c:if> --%>
							<c:choose>
							    <c:when test="${not empty docCount}">${docCount[0]}</c:when>
							    <c:otherwise>0</c:otherwise>
							</c:choose>
                            </span>
                            <i class="fa fa-envelope-o"></i>&nbsp;
                            Total
                        </a>
                         <a class="list-group-item" href="completedDocuments">
                            <i class="fa fa-chevron-right pull-right"></i>
                            <span class="badge badge-danger" style="background: #307BBB;">
                            <c:choose>
							    <c:when test="${not empty docCount}">${docCount[1]}</c:when>
							    <c:otherwise>0</c:otherwise>
							</c:choose>
                            </span>
                            <i class="fa fa-envelope-o"></i>&nbsp;
                            Completed
                        </a>
                        <a class="list-group-item" href="outforSignature">
                            <i class="fa fa-chevron-right pull-right"></i>
                            <span class="badge badge-success">
                            <c:choose>
							    <c:when test="${not empty docCount}">${docCount[2]}</c:when>
							    <c:otherwise>0</c:otherwise>
							</c:choose>
                            </span>
                            <i class="fa fa-envelope-o"></i>&nbsp;
                            Out for Signature
                        </a>
                       
                        
                                 
                    </div>
					  </div>
					</div>
				  	
        
					</div>
                  </div>
                  <div class="col-xs-12 col-sm-12 col-md-6 portfolio-item">	
					<div class="panel panel-default">
					  <div class="panel-heading">Progress</div>
					  <div class="panel-body"  >
					  	<div class="row">
						  <div class="col-md-7">  	
						  <div class="c100 p<c:choose><c:when test="${not empty docCount}"><fmt:formatNumber type="number" minFractionDigits="0" maxFractionDigits="0" value="${ docCount[1]*100/docCount[0] }" /></c:when><c:otherwise>0</c:otherwise></c:choose> big">
						<span><c:choose><c:when test="${docCount[1] ne 0 }"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${ docCount[1]*100/docCount[0] }" /></c:when><c:otherwise>0</c:otherwise></c:choose>%</span>
						<div class="slice">
							<div class="bar"></div>
							<div class="fill"></div>
						</div>
					    </div></div>
						  <div class="col-md-5">
						   <p class="pull-right"><div style="float:left;height:20px;width:20px;background:#61A9DC;border:1px solid #000;"></div>&nbsp;&nbsp;<span class="gg">Completed</span></p>
						<p class="pull-right"><div style="float:left;height:20px;width:20px;background:#EEEEEE;border:1px solid #000;"></div>&nbsp;&nbsp;<span class="gg">Out for Signature</span></p>
						
						  </div>
						</div>
					
					   
					   		  
					  </div>
					</div>
					                  			
				
                  </div>
               </div>
               <!-- /.row -->
               <!-- Projects Row -->
               <div class="row rowpad">
                  
					
				<%-- <c:choose>
				    <c:when test="${not empty signatures}">
				       <h3>Signatures</h3>
				       <c:forEach items="${signatures }" var="sign">
			                 <div class="col-xs-12 col-sm-6 col-md-6 text-center signaturewrapper">
		                           		<img src="${sign.sign}" style="padding:15px;" alt="Cinque Terre" width="100%" height="100px">
		                      </div>
				        </c:forEach>           
				    </c:when>
				    <c:otherwise>
				       There is no signatures available.
				    </c:otherwise>
				</c:choose> --%>                       
               </div>
            <jsp:include page="footer.jsp" />