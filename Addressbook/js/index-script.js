//-- Confirm Password in index.cfm

$(document).ready(function(){
	$("#user").change(function(){
		let user = $(this).val();
		alert(user);
	});
});