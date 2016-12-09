
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="adminheader.jsp" />
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
   <!-- Content Header (Page header) -->
        <section class="content-header">
<h3 style="color:#557FBD;">Dashboard</h3>

</section>
<!-- Main content -->
<section class="content">
   <!-- Your Page Content Here -->
          <div class="container-fluid">
			  <div class="row">
			      <div class="col-xs-12 col-sm-12 col-md-12">
			      	<!-- <table id="myTable1" class="table table-striped table-bordered" cellspacing="0" width="100%">
	                    <thead>
	                        <tr>
	                            <th>FirstName</th>
	                            <th>LastName</th>
	                            <th>Email</th>
	                            <th>Role</th>
	                            <th>Status</th>
	                        </tr>
	                    </thead>
	                </table> -->
			      </div>
			  </div>
		  </div>
		  
           <!-- Your Page Content Here -->
           <div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                <a href="http://www.jquery2dotnet.com" class="list-group-item facebook-like">
                    <h3 class="pull-right">
                        <i class="fa fa-envelope"></i>
                    </h3>
                    <h4 class="list-group-item-heading count">
                        1000</h4>
                    <p class="list-group-item-text">
                        Document Views</p>
                </a><a href="http://www.jquery2dotnet.com" class="list-group-item google-plus">
                    <h3 class="pull-right">
                        <i class="fa fa-credit-card"></i>
                    </h3>
                    <h4 class="list-group-item-heading count">
                        1000</h4>
                    <p class="list-group-item-text">
                        Subscription Views</p>
                </a>
                <a href="http://www.jquery2dotnet.com" class="list-group-item visitor">
                    <h3 class="pull-right">
                        <i class="fa fa-user"></i>
                    </h3>
                    <h4 class="list-group-item-heading count">
                        1000</h4>
                    <p class="list-group-item-text">
                        Users Views</p>
                </a>
                <a href="http://www.jquery2dotnet.com" class="list-group-item twitter">
                    <h3 class="pull-right">
                        <i class="fa fa-child"></i>
                    </h3>
                    <h4 id="activeUser" class="list-group-item-heading count">
                        1000</h4>
                    <p class="list-group-item-text">
                        Online Users</p>
                </a>
            </div>
        </div>
        
    </div>
</div>
           
</section>
<!-- /.content -->
</div>
<jsp:include page="adminfooter.jsp" /> 
<script>
$(document).ready(function() {
	var dashbaordList=${dashbaordList};
	
	//alert('dashbaordList'+dashbaordList);
	

//Animate the element's value from x to y:
$({ someValue: 0 }).animate({ someValue: Math.floor(Math.random() * 3000) }, {
    duration: 3000,
    easing: 'swing', // can be anything
    step: function () { // called on every step
        // Update the element's text with rounded-up value:
		var activeUser;
		$.each(dashbaordList, function(i, item) {
	    	activeUser=dashbaordList[i].totalActiveUser;
	    }); 	
        $('#activeUser').text(commaSeparateNumber(activeUser));
    }
});

function commaSeparateNumber(val) {
   /*  while (/(\d+)(\d{3})/.test(val.toString())) {
        val = val.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
    } */
    return val;
}

});
</script>
