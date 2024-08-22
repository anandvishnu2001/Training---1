 $(document).ready(function() {
	$('#check').click(function() {
		var email = $('#email').val();
		$.ajax({
			url: './record.cfc?method=check',
			type: 'POST',
			data: { email: email },
			success: function(response) {
				if (response.trim() == '\"yes\"') {
					alert('Mail ID is already there');
					$('#submit').prop('disabled', true);
				} else {
					alert('Data can be inserted');
					$('#submit').prop('disabled', false);
				}
			}
		});
	});
});