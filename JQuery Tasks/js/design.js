$(document).ready(function(){

	$(".tab").click(function(){
		$(".tabcontent").hide();
		$(".tab").not(this).removeClass("active");
		$(this).addClass("active");
		$(`#${$(this).attr("name")}`).fadeIn("slow");
	});

	$(".accordion").click(function(){
		$(this).toggleClass("active");
		$(`#${$(this).attr("name")}`).toggle("slow");
	});

	$("#datepicker").datepicker();

	$("#datatable").DataTable();

});