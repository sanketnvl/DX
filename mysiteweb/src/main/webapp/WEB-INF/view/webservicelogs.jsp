
<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="adminheader.jsp" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
   <!-- Content Header (Page header) -->
        <section class="content-header">
<h3 style="color:#557FBD;">WebService Logs</h3>

</section>
<!-- Main content -->
<section class="content">
   <!-- Your Page Content Here -->
          <div class="container-fluid">
			  <div class="row">
			      <div class="col-xs-12 col-sm-12 col-md-12">
			      	<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
	                    <thead>
	                       <tr>
			           		<th></th>
			           		<th>Email</th>
			           		<th>ip_address</th>
			           		<th>Method Name</th>
			                <th>status</th>
			                <th>Created Date</th>
			            </tr>
	                    </thead>
	                </table>
			      </div>
			  </div>
		  </div>
           <!-- Your Page Content Here -->
</section>
<!-- /.content -->
</div>
<jsp:include page="adminfooter.jsp" /> 

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
			
				
				var content = "<table class='table table-bordered'><tr><th>Priority</th><th>Name</th><th>Email ID</th><th>Status</th></tr>";
				
				for(i=0; i<sn.length; i++){
					if(ss[i] == "0" || ss[i] == "false"){
				   		content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-warning">PENDING</button></td></tr>';
					}else{
						content += '<tr><td>'+pp[i]+'</td><td>'+sn[i]+'</td><td>'+eID[i]+'</td><td><button type="button" class="btn-sm btn-success">SIGNED</button></td></tr>';
					}
				}
				content += "</table>"
					signers=content;
		 }
		 
		 return signers;
	 }
	
	function format ( d ) {
	    // `d` is the original data object for the row
	    //var y=displaySignType(d.signType);
	    
	   // var z=displaySigners(d.signType,d.signerEmail,d.signerName,d.signerStatus,d.priority,d.emailCount,d.signerEmailId);
	    
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
            '<td><strong>Web Request</strong></td>'+
            '<td class="bg-warning">'+d.webRequest+'</td>'+
        	'</tr>'+  
        	'<tr>'+
            '<td><strong>Web Response:</strong></td>'+
            '<td class="bg-warning">'+d.webResponse+'</td>'+
        	'</tr>'
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
					{ "data": "email" }, 
					{"data": "ipAddress"},
					{"data":"methodName"},
					{"data": "responseStatus"},
					{"data": "created_date"}
    	      ],
    	      dom: 'Bfrtip',
	  	        buttons: [
	  	            'copy', 'csv', 'excel', 'pdf', 'print'
	  	       ],
    	   columnDefs : [
    	                    { targets : [3],
    	                      render : function (data, type, row) {
    	                    	 if(data == 'Created Document'){
    	                    		 data = '<span class="label label-danger">Created Documen</span>';
    	                    	 } else if(data == 'Updated Document'){
    	                    		 data = '<span class="label label-info">Updated Document</span>';
    	                    	 } else if(data == 'Download Document'){
    	                    		 data = '<span class="label label-warning">Download Document</span>';
    	                    	 } else if(data == 'Document History'){
    	                    		 data = '<span class="label label-primary">Document History</span>';
    	                    	 } 
    	                    	 return data ;
    	                      }
    	                    } ,
    	                    { targets : [4],
      	                      render : function (data, type, row) {
      	                    	 if(data == 'success' || data =='Success'){
      	                    		 data = '<span class="label label-success">Ok.</span>';
      	                    	 }else{
      	                    		 data = '<span class="label label-danger">Reson: '+data+'</span>';
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
	
      
      <style>
  	td.details-control {
	    background: url('../images/details_open.png') no-repeat center center;
	    cursor: pointer;
	}
	tr.shown td.details-control {
	    background: url('../images/details_close.png') no-repeat center center;
	}
  	</style>
  	
	 <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
      <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
      <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
 