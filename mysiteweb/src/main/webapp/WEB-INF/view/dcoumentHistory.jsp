
<% String serverUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="adminheader.jsp" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
   <!-- Content Header (Page header) -->
        <section class="content-header">
<h3 style="color:#557FBD;">Document History</h3>

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
			           		<th>User</th>
			           		<th>Email</th>
			                <th>Title</th>
			                <!-- <th>SignedUser</th> -->
			                <!-- <th>Document Name</th> -->
			                <th>Sign Type</th>
			                <th>Status</th>
			                <th>Date</th>
			                
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
	       /*  '<tr>'+
	            '<td><strong>View File:</strong></td>'+
	            '<td><button type="button" onclick="view('+d.docId+');" class="btn-sm btn-warning">VIEW</button></td>'+
	            
	        '</tr>'+
	        	'<td><strong>Download File:</strong></td>'+
        		'<td><button type="button" onclick="view1('+d.docId+');" class="btn-sm btn-danger">DOWNLOAD</button></td>'+
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
					{ "data": "requestedBy" }, 
					{"data":"signerEmail"},
					{ "data": "subject" },
				/* 	{ "data": "signedUser" }, */
	/* 				{ "data": "documentName" }, */
					{ "data": "signType" },
					{ "data":"status"},
					{ "data": "completedDate" },
					
				/* 	{ "data": "message" } */
    	      ],
    	      dom: 'Bfrtip',
	  	        buttons: [
	  	            'copy', 'csv', 'excel', 'pdf', 'print'
	  	       ],
    	      columnDefs : [
    	                    { targets : [4],
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
    	                    },
    	                    { targets : [5],
      	                      render : function (data, type, row) {
      	                    	 if(data == 'Completed Documents'){
      	                    		 data = '<span class="label label-success">Completed Documents</span>';
      	                    	 }else if(data == 'Out For Signature'){
      	                    		 data = '<span class="label label-warning">Out For Signature</span>';
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
	    background: url('../images/details_open.png') no-repeat center center;
	    cursor: pointer;
	}
	tr.shown td.details-control {
	    background: url('../images/details_close.png') no-repeat center center;
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
	 <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
      <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
      <script src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
 