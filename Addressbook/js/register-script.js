//-- Confirm Password in register.cfm

$(document).ready(function(){
	$("#email,#user").change(function(){
		let user = $(this).val();
		alert(user);
	});
	$("#confirm,#password").on("input",function(){
		let pattern = new RegExp($("#password").attr("pattern"));
		let button = $("#register").find("#btn");
		let pass = $("#register").find("#password");
		if(!button.hasClass("disabled"))
			button.addClass("disabled");
		if(pattern.test(pass.val()))
			if(pass.val() == $("#confirm").val() && button.hasClass("disabled"))
				button.removeClass("disabled");
	});
});