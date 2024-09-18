//-- Confirm Password in register.cfm

$(document).ready(function(){
	$("#email,#username").change(function(){
		let id = $(this).attr('id');
		let value = $(this).val();
		if(!$("#feedback").hasClass("invisible"))
			$("#feedback").addClass("invisible");
		$.ajax({
			url: './components/manager.cfc?method=exist',
			type: 'POST',
			data: { check: id,
				item: value },
			success: function(response){
				let check = JSON.parse(response);
				if(check[1] == true){
					$("#feedback").html(`*${value} is already used`).removeClass("invisible");
				}
			}
		});
	});
	$("#register #confirm,#register #password").on("input",function(){
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