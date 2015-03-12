$(document).ready(function(){
	
	/**
	 * Display modal
	 */	
	$('#addButton').click(function () {
		$('#addFile').modal();
	});

	/**
	 * Send Form data to REST Server
	 */
	$('#addFile .btn-primary').click(function() {
		var form = $('#addFileForm').serializeArray();
		var filename = form[0]['value'];
		var path = decodeURI(window.location.pathname.substr(1));
		console.log(path);
		$.ajax({
			type: "PUT",
			url: "http://localhost" + path + "/" + filename,
			data: {},
			success: function (data) {
				//console.log(data);
				window.location.href = "http://localhost" + path;
			}
		});
	});

	/**
	 * Delete a file
	 */
	$( ".delete" ).click(function(){

		var file = $(this).parents(".item").children(":first").children("a");
		var filename = file.text();
		var filepath = file.attr('href');
		var path = filepath.split("/");

		var fileLength = path[path.length-1].length+1;
		filepath = filepath.slice(0,-fileLength);
		$.ajax({
			type: "DELETE",
			url: "http://localhost" + filepath + "/" + filename,
			data: {},
			success: function(data) {
				window.location.href = filepath;
			}
		});
	});

});
