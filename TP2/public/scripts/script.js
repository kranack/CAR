$(document).ready(function(){

	/* Delete a file */
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
		})
	});

});
