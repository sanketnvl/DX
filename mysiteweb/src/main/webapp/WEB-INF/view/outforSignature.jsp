
<jsp:include page="header.jsp" />
               <!-- Page Header -->
               <div class="row" style="background:#ccc;">
                  <div class="col-lg-12">
                     <h3 class="page-header">Out For Signature
                     </h3>
                     
                   
                  </div>
               </div>
               <!-- /.row -->		
               <!-- Projects Row -->
               <div class="row rowpad" style="padding-top:70px;margin-right:12px;">
                  <div class="col-xs-12 col-sm-12 col-md-12">
                     <div id="OrderPackages">

                        <table id="example" style="border: 1px solid #ccc; color: #463030;" class="display" cellspacing="0" width="100%">
					        <thead style="background:#5890CD;color:#fff;">
					            <tr>
					           		<th></th>
					                 <th>Title</th>
					                <!-- <th>SignedUser</th> -->
					                <!-- <th>Document Name</th> -->
					                <th>Sign Type</th>
					                <th>Date</th>
					            </tr>
					        </thead>
					       
					    </table>
                     </div>
                  </div>
               </div>
               <!-- /.row -->
               <div class="row">
                  <div class="col-xs-12 col-sm-10 col-md-10 text-right">
                    
                  </div>
                  </div>
               <jsp:include page="footer.jsp"></jsp:include>




<script>
	
	 function displaySigners(signerName,signerStatus,priority,emailCount,signerEmailId, envelopeId, documentName, requestedBy, subject, message,docId) {
		
		var sn=signerName.split(",");
		var ss=signerStatus.split(",");
		var pp=priority.split(",");
		var ec=emailCount.split(",");
		var eID=signerEmailId.split(",");
		var msg=''; 
		
		/* var envelopeId = envelopeId.split(",");
		var documentName = documentName.split(",");
		var requestedBy = requestedBy.split(",");
		var subject = subject.split(",");
		var message = message.split(","); */
		
		
		var content = "<table class='table table-bordered'><tr><th>Priority</th><th>Name</th><th>Email ID</th><th>Status</th><th>Mail Sent Count</th></tr>";
		
		for(i=0; i<sn.length; i++){
			if((ss[i] == "0" || ss[i] == "false") && ec[i]==0){
		   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-warning">PENDING</button></td><td>'+ec[i]+'</td></tr>';
			}else if((ss[i] == "0" || ss[i] == "false") && ec[i]>0){
		   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-warning">PENDING</button></td><td>'+ec[i]+'&nbsp;&nbsp;<button type="button" class="btn-sm btn-warning" onclick="sendReminder(\''+sn[i]+'\',\''+eID[i]+'\',\''+envelopeId+'\',\''+documentName+'\',\''+requestedBy+'\',\''+subject+'\',\''+message+'\',\''+docId.toString()+'\',\''+ec[i]+'\')" >REMIND</button></td></td></tr>';
			}else if(ss[i] == "1" || ss[i] == "true"){
				content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-success">SIGNED</button></td><td>'+ec[i]+'</td></tr>';
			}
		}
		content += "</table>"
 
		
		//alert(msg);
		return content;
	    
	}
	function sendReminder(signerName,signerEmailId,envelopeId,documentName,requestedBy,subject,message,docId,mailcount)
	{	
		
		if(confirm("Are you sure want to send reminder?"))
		{			
			  $.ajax({
					type : "POST",
					url : "sendreminder",
					data: {"signerName":signerName, "signerEmailId":signerEmailId, "envelopeId":envelopeId, "documentName":documentName, "requestedBy":requestedBy, "subject":subject, "message":message,"docId":docId,"mailcount":mailcount},
					success : function(response) 
					{						
						alert(response);
					}
			});  
		}
	}
	 
	
	function format ( d ) {
		
		var y=displaySigners(d.signerName,d.signerStatus,d.priority,d.emailCount,d.signerEmailId, d.envelopeId, d.documentName, d.requestedBy, d.subject, d.message,d.docId);
	    // `d` is the original data object for the row
	    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
	       /* '<tr>'+
	            '<td>Full name:</td>'+
	            '<td>'+d.requestedBy+'</td>'+
	        '</tr>'+  */
	       /*  '<tr>'+
            	'<td><strong>Title:</strong></td>'+
           	 	'<td>'+d.subject+'</td>'+
        	'</tr>'+  */
        	'<tr>'+
            '<td><strong>Envelope Id:</strong></td>'+
            '<td>'+d.envelopeId+'</td>'+
        	'</tr>'+  
        	'<tr>'+
            '<td><strong>Document Name:</strong></td>'+
            '<td>'+d.documentName+'</td>'+
        	'</tr>'+  
        	'<tr>'+
	            '<td><strong>Requested By:</strong></td>'+
	            '<td>'+d.requestedBy+'</td>'+
	        '</tr>'+  
	        '<tr>'+
            	'<td><strong>Signers:</strong></td>'+
           		'<td>'+y+'</td>'+
       		'</tr>'+ 
       	 	
       		/* '<tr>'+
        		'<td><strong>Status:</strong></td>'+
       			'<td>'+x+'</td>'+
   			'</tr>'+  
   			'<tr>'
    			'<td><strong>Status:</strong></td>'+
   				'<td>'+y+'</td>'+
			'</tr>'+  
	       /*  '<tr>'+
	            '<td><strong>Signers:</strong></td>'+
	            '<td>'+d.requestedBy+'&nbsp <button type="button"  class="btn-sm btn-success">SIGNED</button></td></td>'+
       		 '</tr>'+ */ 
       		
        	'<tr>'+
        		'<td><strong>Subject:</strong></td>'+
       	 		'<td>'+d.subject+'</td>'+
    		'</tr>'+ 
    		'<tr>'+
    			'<td><strong>Message:</strong></td>'+
   	 			'<td>'+d.message+'</td>'+
			'</tr>'+ 
	    '</table>';
	}
	
	 
	 
	$(document).ready(function() {
		
		 var dataSet=${list};
		 
		 
		var table= $('#example').DataTable( {
    		 data: dataSet,
    	        columns: [
					 {
					    "className":      'details-control',
					    "orderable":      false,
					    "data":           null,
					    "defaultContent": ''
					},
					{ "data": "subject" },
				/* 	{ "data": "signedUser" }, */
	/* 				{ "data": "documentName" }, */
					{ "data": "signType" },
					{ "data": "uploadDate" }
				/* 	{ "data": "message" } */
    	      ],
    	      columnDefs : [
    	                    { targets : [2],
    	                      render : function (data, type, row) {
    	                    	 if(data == 'S'){
    	                    		 data = '<i class="icon-self fontIcon"></i>&nbsp; Self Sign';
    	                    	 }else if(data == 'G'){
    	                    		 data = '<i class="icon-group fontIcon"></i>&nbsp; Group Sign';
    	                    	 } else if(data == 'R'){
    	                    		 data = '<i class="fa fa-globe"></i>&nbsp; WebService Sign';
    	                    	 } 
    	                    	 return data ;
    	                      }
    	                    }
    	               ]
 	       } );
		 
		 $('#example tbody').on('click', 'td.details-control', function () {
		        var tr = $(this).closest('tr');
		        var row = table.row( tr );
		 
		        if ( row.child.isShown() ) {
		            // This row is already open - close it
		            row.child.hide();
		            tr.removeClass('shown');
		        }
		        else {
		            // Open this row
		            row.child( format(row.data()) ).show();
		            tr.addClass('shown');
		        }
		  }); 
	 
	} );
	</script>
	 <script>
         $('#accordion1').on('shown.bs.collapse', function () {
         $("#package1").toggleClass("pp");
            $("#package1 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion1').on('hidden.bs.collapse', function () {
         $("#package1").toggleClass("pp");
            $("#package1 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         $('#accordion2').on('shown.bs.collapse', function () {
         	$("#package2").toggleClass("pp");
         
            $("#package2 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion2').on('hidden.bs.collapse', function () {
         $("#package2").toggleClass("pp");
         
            $("#package2 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         $('#accordion3').on('shown.bs.collapse', function () {
         	$("#package3").toggleClass("pp");
         
            $("#package3 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion3').on('hidden.bs.collapse', function () {
         $("#package3").toggleClass("pp");
         
            $("#package3 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         $('#accordion4').on('shown.bs.collapse', function () {
         	$("#package4").toggleClass("pp");
         
            $("#package4 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion4').on('hidden.bs.collapse', function () {
         $("#package4").toggleClass("pp");
         
            $("#package4 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         $('#accordion5').on('shown.bs.collapse', function () {
         	$("#package5").toggleClass("pp");
         
            $("#package5 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion5').on('hidden.bs.collapse', function () {
         $("#package5").toggleClass("pp");
         
            $("#package5 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         
         $('#accordion6').on('shown.bs.collapse', function () {
         	$("#package6").toggleClass("pp");
         
            $("#package6 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion6').on('hidden.bs.collapse', function () {
         $("#package6").toggleClass("pp");
         
            $("#package6 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
         
         
         $('#accordion7').on('shown.bs.collapse', function () {
         	$("#package7").toggleClass("pp");
         
            $("#package7 i.indicator").removeClass("glyphicon glyphicon-triangle-left").addClass("glyphicon glyphicon-triangle-bottom");
         });
         $('#accordion7').on('hidden.bs.collapse', function () {
         $("#package7").toggleClass("pp");
         
            $("#package7 i.indicator").removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-left");
         });
          
      </script>
		
  	<style>
  	td.details-control {
	    background: url('images/details_open.png') no-repeat center center;
	    cursor: pointer;
	}
	tr.shown td.details-control {
	    background: url('images/details_close.png') no-repeat center center;
	}
  	</style>
  	
  	<script>
  	function view(docId){

  		
  		 $.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/downloadFiles/internal",
			data : "docId="+docId,
			success : function(response) {
				
				if(response){
					
					//alert("Your file is verified"+response);
					window.open('download/internal?fileName='+response);
					
				}else{
					alert("Error in File Verification.");
				}
				

			}
		}); 
  	}
  	
	function view1(docId){

  		
 		 $.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/downloadFiles/external",
			data : "docId="+docId,
			success : function(response) {
				
				if(response){
					
					//alert("Your file is verified"+response);
					window.open('download/external?fileName='+response);
					
				}else{
					alert("Error in File Verification.");
				}
				

			}
		}); 
 	}
  	</script>