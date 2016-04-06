$(".save-btn").click(function(){
  var title = $(this).parent().parents().data("title");
  var link = $(this).parent().parents().data("link");
  console.log(title, link);
  $.ajax({
    type: "POST",
    url: "/api/fav",
    data: {
      title: title,
      link: link
    },
    success: function(data){
      console.log(data);
    }
  });
});
