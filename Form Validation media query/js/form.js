$(document).ready(function(){

	let nameChecked = [ "Gender" , "Marital-Status" , "Terms-and-Conditions" ];

	let checkedCount = [ 0 , 0 , 0 ];

	let idCheck = [ "email" , "password" , "phone" ];

	let checker = [ /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/ ,
			/^([A-Za-z0-9!@#$%^&*()_+-]){8,}$/ ,
			/^([0-9]){10}$/ ];

	let pop = [ "*Email form should be example@mail.dns" ,
			"*Password should have atleast 8 characters<br>alphabets, numbers and !@#$%^&*()_+-" ,
			"*Phone should have only 10 numbers" ];

	let check = [ true , true , true ];

	$(".check").on("input",function(){
		let id = $(this).attr("id");
		for(let i in idCheck){
			if(id === idCheck[i]){
				if(!$(`#${id}`).val().match(checker[i])){
					check[i] = false;
					$(`#${id}pop`).html(pop[i]).css("color","red");
				}
				else{
					check[i] = true;
					$(`#${id}pop`).html("*Valid form verified").css("color","green");
				}
			}
		}
	});

	$("form").submit(function(e){
		let valid = true;

		$(".valid").each(function(){
			if($(this).val() == '' || $(this).val() == null){
				valid = false;
				$(`#${$(this).attr("id")}pop`).html(`*${$(this).attr("name")} field is required`).css("color","red");
			}
			else if($(this).hasClass("check")){
				let i = idCheck.indexOf($(this).attr("id"));
				if(!check[i]){
					valid = false;
					$(`#${$(this).attr("id")}pop`).html(`*${$(this).attr("name")} field form is invalid`).css("color","red");
				}
			}
			else
				$(`#${$(this).attr("id")}pop`).html("*Valid form is verified").css("color","green");

		});

		$(":radio,:checkbox").each(function(){
			for(let i in nameChecked)
				if($(this).attr("name") === nameChecked[i])
					if($(this).prop('checked') == true)
						checkedCount[i] += 1 ;
		});
		for(let i in checkedCount){
			if(checkedCount[i] === 0){
				valid = false;
				$(`#${nameChecked[i]}pop`).html(`*${nameChecked[i]} field is required`).css("color","red");
			}
			else
				$(`#${nameChecked[i]}pop`).html("*Valid form is verified").css("color","green");
		}

		if(!valid){
			alert("All fields are mandatory");
			e.preventDefault();
			for(let i in checkedCount)
				checkedCount[i] = 0 ;
		}
		else
			alert("Form is valid");
	});
});