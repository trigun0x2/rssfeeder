$(document).on("click", ".save-btn", function(){
  var btn   = $(this);
  var title = btn.parent().parents().data("title");
  var link  = btn.parent().parents().data("link");
  $.ajax({
    method: "POST",
    url: "/api/fav",
    data: {
      title: title,
      link: link
    },
    success: function(data){
      console.log(data);
      appendSaved(title, link);
      btn.removeClass("save-btn btn-success")
        .addClass("unsave-btn btn-info").text("Saved");
      toastr.success(data.message);
    },
    fail: function(data){
      console.log(data);
      toastr.error(data.message);
    }
  });
});

$(document).on("click", ".unsave-btn", function(){
  var btn   = $(this);
  var title = $(this).parent().parents().data("title");
  var link = $(this).parent().parents().data("link");
  $.ajax({
    method: "DELETE",
    url: "/api/fav",
    data: {
      title: title,
      link: link
    },
    success: function(data){
      console.log(data);
      removeSaved(title, link);
      btn.removeClass("unsave-btn btn-info")
        .addClass("save-btn btn-success").text("Save");
      toastr.info(data.message);
    },
    fail: function(data){
      console.log(data);
      toastr.error(data.message);
    }
  });
});

function appendSaved(title, link){
  $("#saved_items").append("<li data-title='"
                           + title + "' data-link='"
                           + link + "'> <a class='saved_item' href='"
                           + link + "'>"
                           + title + "</a></li>");
}

function removeSaved(title){
  $("#saved_items > li[data-title='"+title+"']").remove();
}
