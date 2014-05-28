// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

//= require nested_form
//= require underscore
//= require backbone
//= require quizz_app
//= require_tree .


function show_flash_message(type, text){
  $('.flash_msgs').html("");
  if (type == 'notice') {
    $('.flash_msgs').append("<div class='alert alert-info'><a class='close' data-dismiss='alert'>×</a>"+text+"</div>")
  } else if (type == 'success') {
    $('.flash_msgs').append("<div class='alert alert-success'><a class='close' data-dismiss='alert'>×</a>"+text+"</div>")
  } else if (type == 'error') {
    $('.flash_msgs').append("<div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a>"+text+"</div>")
  }
};

function update_notification_flag(status){
  var user = $('.mail_notifications').data('current_user');
  $.post(
    '/accounts/' + user + '/notification_flag', {"notification": status}, 
    function(response) {
      for (type in response) {
        show_flash_message(type, response[type]);
      }
    }
  );
};

$(function() {
  //Manage displaying of flash messages
  $(".alert-info, .alert-success, .alert-error").fadeIn(2000);

  setTimeout(function() {
    $(".alert-info, .alert-success, .alert-error").fadeOut(2000);
  }, 6000);

  $(".alert").on("click", ".close", function(event){
    $(this).parent().hide();
  });

  //FAYE
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe("/messages/new", function(data){
    eval(data);
  });

  $('.mail_notifications').on("click", 'input[name="user[notification]"]', function(){
    update_notification_flag($(this).val());
  });


});