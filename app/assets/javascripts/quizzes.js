jQuery(function() {
	$(".alert .close").click(function() {
		$(".alert-success").hide();
	});

	enableQuizzBtn();
	$("#expand").css("opacity", "0.5");

	//Temporary
	$(".questions").show();
	$(".answers").show();

	$("#quizz_title").focusout(function() {
		enableQuizzBtn();	
	});
	function enableQuizzBtn() {
		if($("#quizz_title").val() != "") {
			// $("#add_quizz").removeAttr("disabled");
			$("#submit").removeAttr("disabled");
		} else {
			$("#submit").attr("disabled", "disabled");
		}
		validateQuizz();
	};

	function validateQuizz() {
		var title = $("#quizz_title").val(),
			errors = $(".errors");
		if(title != "") {
			errors.hide();
			$(".questions").show();
			$(".answers").show();
			// $("#add_quizz").attr("disabled", "disabled");//Do not work properly
		} else {
			errors.html("Quizz Title can't be blank!");
			errors.show();
		}
	};

	$("#collapse").click(function() {
		$(".answers").hide();
		$(".questions").addClass("collapsed");
		$("#expand").attr("display", "inline-block");
		$("#collapse").css("opacity", "0.5");
		$("#expand").css("opacity", "1");
	});

	$("#expand").click(function() {
		$(".answers").show();
		$(".questions").addClass("expanded");
		$("#collapse").attr("display", "inline-block");
		$("#expand").css("opacity", "0.5");
		$("#collapse").css("opacity", "1");
	});

	$("#add_answer").click(function(){
		var id = $(".answers input").length +1;
		$answer = $('<div class="line" id =' + id +'><input id="answers_content" type="text" value="answ77" style="margin-left: 73px;" name="answers[content]"/><img src="/assets/cancel.png" alt="Delete Answer" class="remove_answer"></div>');
		$('.answers').append($answer);
	});

	$('.line').on('click', ".remove_answer", function(){
		$(this).parent().empty();
	});

	$("#add_qst").click(function(){
		//TODO: implement this
	});

});