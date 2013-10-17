jQuery(function() {
	$(".alert .close").click( function() {
		$(".alert-success").hide();
	});

	enableQuizzBtn();
	$("#expand").css("opacity", "0.5");

	//Temporary
	$(".questions").show();
	$(".answers").show();

	$("#quizz_title").focusout( function() {
		enableQuizzBtn();
		//TODO inplement saving to db
		//$.post("/quizzs", $('form').serialize());
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
			$(".question-section").show();
			$(".answers").show();
		} else {
			errors.html("Quizz Title can't be blank!");
			errors.show();
		}
	};

	$("#collapse").click( function() {
		$(".answers").hide();
		$(".question-section").addClass("collapsed");
		$("#expand").attr("display", "inline-block");
		$("#collapse").css("opacity", "0.5");
		$("#expand").css("opacity", "1");
	});

	$("#expand").click( function() {
		$(".answers").show();
		$(".question-section").addClass("expanded");
		$("#collapse").attr("display", "inline-block");
		$("#expand").css("opacity", "0.5");
		$("#collapse").css("opacity", "1");
	});

	$(document).on('click', ".add_answer", function(){
		$answer = $('<div class="line"><input type="text" value="answ77" style="margin-left: 73px;" name="questions[][answers][]"/><img src="/assets/cancel.png" alt="Delete Answer" class="remove_answer"></div>');
		$(this).parent().append($answer);
	});

	$('.line').on('click', ".remove_answer", function(){
		$(this).parent().empty();
	});

	$("#add_qst").click( function(){
		//TODO: implement this
		var $question = $('<div class ="question" style="margin-left: 20px;"> <span class="caption">Question</span> <input type="text" value="quest1" style="width:300px;" name="questions[][description]"></div>'),
			$answer = $('<div class="answers" style="margin-left: 44px;"><span class="caption">Answers</span><img class="add_answer" src="/assets/add.png" alt="Add Answer" style="position: relative; top: 30px; left: -57px;"></div>');
	
		$('.question-section').append($question);
		$('.question').last().append($answer);
	});

});