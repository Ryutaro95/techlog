$(document).on('turbolinks:load', function() {
  
  const postHeading = $("#toc-range h1, #toc-range h2, #toc-range h3");
    
    // 目次
    var countId = 1
    postHeading.each(function(){
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


  // コメント文字数カウント
  $("#input-text").on("keyup", function() {
    let countNum = String($(this).val().length);
    $("#counter").text(countNum + "文字");
  });


  // フォロー一覧切り替えタブ
  var followingTab = $("#following-tab");
  var followerTab = $("#follower-tab");
  var followingsContainer = $("#followings-container");
  var followersContainer = $("#followers-container");

  followingTab.click(function(){
    followingTab.addClass("active");
    followerTab.removeClass("active");

    followingsContainer.addClass("active");
    followersContainer.removeClass("active");
  });
  followerTab.click(function(){
    followerTab.addClass("active");
    followingTab.removeClass("active");
  
    followersContainer.addClass("active");
    followingsContainer.removeClass("active");
  });


});