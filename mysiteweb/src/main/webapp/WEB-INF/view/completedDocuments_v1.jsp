
<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
<jsp:include page="header.jsp"></jsp:include>
  <div class="content-wrapper bg_wrap">
  <ol class="breadcrumb" style="background-color:#F1F0F0">
	  <li class="breadcrumb-item"><a href="#" >DrySign</a></li>
	  <li class="breadcrumb-item active" style="color:#2c3d4f;">Completed Documents</li>
	 
	</ol>
      <!-- Main content -->
      <section class="content contentdoc">
	
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12"  style="margin-top:30px;">
 		<table id="completedDocumentsData" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
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
 function displaySignType(signType){
	 var sType;
	 if(signType=='S'){
		 sType='<i class="icon-self fontIcon"></i>&nbsp; SELF';
	 }
	 if(signType=='G'){
		 sType='<i class="icon-group fontIcon"></i>&nbsp; GROUP';
	 }
	 if(signType=='R'){
		 sType='<i class="fa fa-globe"></i>&nbsp; Web Service Sign';
	 }
	 return sType;
 }

 function displaySigners(signType,signerEmail,signerName,signerStatus,priority,emailCount,signerEmailId){
	 var signers;
	 if(signType=='S'){
		 signers=signerEmail+'&nbsp<button type="button"  class="btn-sm btn-success">SIGNED</button>';
	 }
	 if(signType=='G' || signType=='R'){
		
			var sn=signerName.split(",");
			var ss=signerStatus.split(",");
			var pp=priority.split(",");
			var ec=emailCount.split(",");
			var eID=signerEmailId.split(",");
			var msg=''; 
		
			
			var content = "<table class='table table-bordered'><tr><th>Priority</th><th>Name</th><th>Email ID</th><th>Status</th><th>Mail Sent Count</th></tr>";
			
			for(i=0; i<sn.length; i++){
				if(ss[i] == "0" || ss[i] == "false"){
			   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-warning">PENDING</button></td><td>'+ec[i]+'</td></tr>';
				}else{
					content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-success">SIGNED</button></td><td>'+ec[i]+'</td></tr>';
				}
			}
			content += "</table>"
				signers=content;
	 }
	 
	 return signers;
 }

function format ( d ) {
    // `d` is the original data object for the row
    var y=displaySignType(d.signType);
    
    var z=displaySigners(d.signType,d.signerEmail,d.signerName,d.signerStatus,d.priority,d.emailCount,d.signerEmailId);
    
    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
       /*  '<tr>'+
            '<td>Full name:</td>'+
            '<td>'+d.requestedBy+'</td>'+
        '</tr>'+ */
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
       /*  '<tr>'+
            '<td><strong>Type:</strong></td>'+
            '<td>'+y+'</td>'+
        '</tr>'+  */
        '<tr>'+
            '<td><strong>Signers:</strong></td>'+
            '<td>'+z+'</td></td>'+
      		 '</tr>'+ 
        '<tr>'+
            '<td><strong>View File:</strong></td>'+
            '<td><button type="button" onclick="view('+d.docId+');" class="btn-sm btn-warning">VIEW</button></td>'+
            
        '</tr>'+
        	'<td><strong>Download File:</strong></td>'+
       		'<td><button type="button" onclick="view1('+d.docId+');" class="btn-sm btn-danger">DOWNLOAD</button></td>'+
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
	var table= $('#completedDocumentsData').DataTable( {
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
				{ "data": "completedDate" }
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
	 
	 $('#completedDocumentsData tbody').on('click', 'td.details-control', function () {
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
			url : "<%=serverUrl%>/app/downloadFiles/internal",
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
			url : "<%=serverUrl%>/app/downloadFiles/external",
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

