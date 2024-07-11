$(document).ready(function(){
	let valid = true;

	let check = true;

	let idcheck = [ "email" , "password" , "phone" ]

	let checker = [ /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/ ,
			/^([A-Za-z0-9!@#$%^&*()_+-]){8,}$/ ,
			/^([0-9]){10}$/ ];

	let pop = [ "*Email form should be example@mail.dns" ,
			"*Password should have atleast 8 characters<br>alphabets, numbers and !@#$%^&*()_+-" ,
			"*Phone should have only 10 numbers" ];


	$(".check").on("input",function(){
		let id = $(this).attr("id");
		for( i in idcheck ){
			if(id === idcheck[i]){
				if(!$("#"+id).val().match(checker[i]))
					$("#"+id+"pop").html(pop[i]).css("color","red").show();
				else
					$("#"+id+"pop").html("*Valid form verified").css("color","green").show();
			}
		}
	});

	$("form").submit(function(e){
		if($(".valid").val() == '' || $(".valid").val() == null){
			valid = false;
			$("#"+$(this).attr("id")+"pop").html("*"+$(this).attr("name")+" field is required").css("color","red");
		}
		else
			$("#"+$(this).attr("id")+"pop").html("*Valid form is verified").css("color","green");

		if(!valid){
			$(".pop").show();
			e.preventDefault();
		}
	});
});