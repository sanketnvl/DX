
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="adminheader.jsp" />
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
   <!-- Content Header (Page header) -->
        <section class="content-header">
<h3 style="color:#557FBD;">UserList</h3>

</section>
<!-- Main content -->
<section class="content">
   <!-- Your Page Content Here -->
          <div class="container-fluid">
			  <div class="row">
			      <div class="col-xs-12 col-sm-12 col-md-12">
			      	<table id="myTable1" class="table table-striped table-bordered nowrap" cellspacing="0" width="100%">
	                    <thead>
	                        <tr>
	                           <!--  <th></th> -->
	                            <th>FirstName</th>
	                          	<th>LastName</th>
	                            <th class="contact_name">Email</th>
	                            <th>Role</th>
	                            <th>Status</th>
	                            <th>Created Date</th>
	                            <th></th>
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

 $(document).ready(function() {
	var dataSet=${userlist};
	var table= $('#myTable1').DataTable( {
		   data: dataSet,
	        columns: [
              	{ "data": "firstName" } ,
				{ "data": "lastname" },
				{ "data": "email" },
				{ "data": "role" },
				{ "data": "status" },
				{ "data": "createdOn"}
	      ],
	      dom: 'Bfrtip',
	        buttons: [
	            'copy', 'csv', 'excel', 'pdf', 'print'
	       ],
       
 	      columnDefs : [
                  { targets : [4],
                      render : function (data, type, row) {
                    	 if(data == '1'){
                    		 data = '<span class="label label-success">Active</span>';
                    	 }else if(data == '0'){
                    		data = '<span class="label label-danger">In Active</span>';
                    	 } 
                    	 return data ;
                      }
                   },
                  { targets : [3],
   	                      render : function (data, type, row) {
   	                    	 if(data == 'ROLE_USER'){
   	                    		 data = 'User';
   	                    	 }else if(data == 'ROLE_APP'){
   	                    		data = 'APP';
   	                    	 } else if(data == 'ROLE_ADMIN'){
   	                    		data = 'Admin';
   	                    	 } 
   	                    	 return data ;
   	                      }
   	              },
   	              { targets : [6],
   	            	  	  data: "email",
 	                      render : function (data, type, row) {
 	                    	data="<input type='hidden' value="+data+"><a href='userdetail?email="+data+"'>Action</a>";
 	                    	 return data ;
 	                      }
 	              },
 	        ] 
       } ); 
	 
	   /*  $('#myTable1 tbody').on( 'click', 'a', function () {
	    	alert($(this).closest("tr").find('input').val());
	    	
	    } ); */
} );
</script>

