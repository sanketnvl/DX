
<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
<jsp:include page="header.jsp"></jsp:include>
  <div class="content-wrapper bg_wrap">
  <ol class="breadcrumb" style="background-color:#F1F0F0">
		  <li class="breadcrumb-item"><a href="#">DrySign</a></li>
		  <li class="breadcrumb-item active" style="color:#2c3d4f;">Out For Signature</li>
		</ol>
      <!-- Main content -->
      <section class="content contentdoc">
		
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12"  style="margin-top:30px;">
 		<table id="outFotSignatureData" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
		 <thead>
            <tr>
            	<th></th>
           		<th>Title</th> 
           		<th>Sign Type</th>
				<th>Date</th>
            </tr>
		</thead>
		</table>
	</div>
</div>
</section>
<!-- /.content -->
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
   return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
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
var table= $('#outFotSignatureData').DataTable( {
  		 data: dataSet,
  	        columns: [
			 {
			    "className":      'details-control',
			    "orderable":      false,
			    "data":           null,
			    "defaultContent": ''
			},
			{ "data": "subject" },
			{ "data": "signType" },
			{ "data": "uploadDate" }
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
 
 $('#outFotSignatureData tbody').on('click', 'td.details-control', function () {
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