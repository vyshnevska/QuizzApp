jQuery(function() {
	$(".alert .close").click( function() {
		$(".alert-success").hide();
	});

	$("#expand").css("opacity", "0.5");

	//Temporary
	$(".question-section").show();

	if (typeof action !== 'undefined' && action == "edit"){
		enableQuizzBtn();
	}


	$("#quizz_description").focusout( function() {
		validateQuizz();
	});

	$(document).on('focusout', ".qst_title", function() {
		validateQuizz();
	});

	$(document).on('focusout', ".ans_content", function() {
		validateQuizz();
	});

	function validateQuizz() {
		var valid = validateQuizzFields();

		if (!valid) {
			disableQuizzBtn();
		} else {
			enableQuizzBtn();
		}
	};

	function validateQuizzFields() {
		var descr = $("#quizz_description").val(),
			title = $(".qst_title"),
			content = $(".ans_content"),
			errors = 0;

		title.each( function() {
			if ($(this).val() == "") {
				errors += 1;
			}
		});
		content.each( function() {
			if ($(this).val() == "") {
				errors += 1;
			}
		});
		if (descr == "") {
			errors += 1;
		}

		return errors >0 ? false : true;
	};

	function enableQuizzBtn() {
		$("#submit").removeAttr("disabled");
	};
	
	function disableQuizzBtn(){
	 	$("#submit").attr("disabled", "disabled");
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
		$answer = $('<div class="line"><input class="ans_content" type="text" value="" " name="questions[][answers][]"/><img src="/assets/cancel.png" alt="Delete Answer" class="remove_answer"></div>');
		$(this).parent().append($answer);
	});

	$(document).on('click', ".remove_answer", function(){
		$(this).parent().empty();
	});

	$("#add_qst").click( function(){
		var $question = $('<div class ="question"> <span class="caption">Question</span> <input class="qst_title" type="text" value="" name="questions[][title]"></div>'),
			$answer = $('<div class="answers"><span class="caption">Answers</span><img class="add_answer" src="/assets/add.png" alt="Add Answer"></div>');
	
		$('.question-section').append($question);
		$('.question').last().append($answer);
	});

});