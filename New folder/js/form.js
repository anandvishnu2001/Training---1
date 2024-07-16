/*
	function openCity(evt) {
	  var i, tabcontent, tablinks;
		let cityName = $(this).attr("name");
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablinks");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].className = tablinks[i].className.replace(" active", "");
	  }
	  document.getElementById(cityName).style.display = "block";
	  evt.currentTarget.className += " active";
	}*/
$(document).ready(function(){

	$(".tabcontent").hide();

	$("button").click(function(){
		$("button").not(this).removeClass("active");
		$(this).addClass("active");
		$("#"+$(this).attr("name")).show();
	});

});