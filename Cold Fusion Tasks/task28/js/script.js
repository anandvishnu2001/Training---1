function addPage(){
	window.open('add.cfm?','_blank');
}
function editPage(id){
	window.open(`edit.cfm?value=${id}`,'_blank');
}
function deletePage(pageid){
	$.ajax({
		url: './manager.cfc?method=deletePage',
		type: 'POST',
		data: { id: pageid },
		success: function(response){
			window.location.href = "welcome.cfm";
		}
	});
}