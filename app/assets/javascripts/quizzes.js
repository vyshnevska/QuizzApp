jQuery(function() {
	$(".alert .close").click(function(){
		$(".alert-success").hide();
	});

	$("#add_quizz").click(function(){
		var title = $("#quizz_title").val(),
			errors = $(".errors");
		if (title != ""){
			errors.hide();
			$("#questions").show();
			$("#answers").show();
			//$("#add_quizz").attr("disable", true);//Do not work properly
			//$("#submit").attr("disable", false);
		}else{
			errors.html("Quizz Title can't be blank!");
			errors.show();
		}
	});

	// $("#submit").click(function(){
	// 	// var vid_id = document.getElementById("vid_vid").innerHTML;
 //   		$.post("/quizzs/create");
	// });
});