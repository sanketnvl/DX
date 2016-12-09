$(function(){
	$('#update_sign').validate({
        rules: {
            FirstName: {
                required: true,
                maxlength: 20
            },
            fileimage: {
                required: true,
                extension: "gif,jpg,jpeg",
                filesize: 10000000,
            }
        },
    });
});

$.validator.addMethod('filesize', function (value, element, param) {
    return this.optional(element) || (element.files[0].size <= param)
}, 'File size must be less than 10 MB');

$("#upload_sign").change(readUplaodImage);

function readUplaodImage() {
	var valid = $("#update_sign").valid();
	if(valid == true){
	    if ( this.files && this.files[0] ) {
	        var FR = new FileReader();
	        FR.onload = function(e) {
	             $('#show_update_sign').attr( "src", e.target.result );
	             $('#base').text( e.target.result );
	        };       
	        FR.readAsDataURL( this.files[0] );
	    }
	}
}