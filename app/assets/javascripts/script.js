$(document).on('turbolinks:load', function() {
  
  
  
  // 目次
  var countId = 1
  $("#toc-range h1, #toc-range h2, #toc-range h3").each(function(){
    if (this.nodeName == 'H1') {
      var className = 'h-1'; 
    } else if (this.nodeName == 'H2') {
      var className = 'h-2';
    } else {
      var className = 'h-3';
    }

    var heading = $(this).text();
    var tag = this.nodeName.toLowerCase();
    this.id = 'chapter-' + countId;

    $("#toc").append('<li class="tag' + tag + ' ' + className + '"><a href="#' + this.id + '">' + heading + '</a></li>');

    countId ++;
  });


  // 投稿フォーム高さ伸縮

  // var keyDownCode = 0;
  // const target = $("#post-area");
  // target.keydown(function(e) {
  //   keyDownCode = e.which;
  // });

  // target.keyup(function(e) {
  //   if (13 == e.which && e.which == keyDownCode) {
  //     func1();
  //     return false;
  //   }
  // });

  // // console.log(target.get(0));

  // function func1() {
  //   const rawTarget = target.get(0);
  //   let lineHeight = Number(target.attr("rows"));
  //   while (rawTarget.scrollHeight > rawTarget.offsetHeight){
  //       lineHeight ++;
  //       target.attr("rows", lineHeight);
  //   }
  // };

});