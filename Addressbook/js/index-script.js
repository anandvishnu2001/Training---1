//-- In index.cfm

$(document).ready(function(){
	$("#username").change(function(){
		let id = $(this).attr('id');
		let value = $(this).val();
		if(value.includes("@"))
			id = "email";
		if(!$("#feedback").hasClass("invisible"))
			$("#feedback").addClass("invisible");
		if(value != ""){
			$.ajax({
				url: './components/manager.cfc?method=exist',
				type: 'POST',
				data: { check: id,
					item: value },
				success: function(response){
					let check = JSON.parse(response);
					if(check[1] == false)
						$("#feedback").html(`*${id} not found`).removeClass("invisible");
				}
			});
		}
	});
});