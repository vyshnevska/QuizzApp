jQuery(function() {
    $('#progress').css('width', "900px");

    $("input").click(function(){
      parent_div = $(this).parent();
      parent_tag = parent_div.parent();
      value = $(parent_tag[0]).attr("data-checked")
      if (value == 0) {
      //pulling current width
        var w =$('#myprogress').css("width");
        x = w.indexOf('p');
        width = parseInt(w.substring(0, x));
      //get weight for each answer
        var we =$('#progress').css("width");
        y = we.indexOf('p');
        count = $("#qns-list li").size();
        weight = parseInt(we.substring(0, y))/count;
      //updated with new value
        $('#myprogress').css('width', width + parseInt(weight) +"px");
        $(parent_tag[0]).attr("data-checked", 1);
      }
    });
  });