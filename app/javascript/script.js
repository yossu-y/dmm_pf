
// 複数のタブで表示
$(document).on('turbolinks:load', function() {
  $(function() {
    $('.tab').click(function(){
      $('.tab-active').removeClass('tab-active');
      $(this).addClass('tab-active');
      $('.box-show').removeClass('box-show');
      const index = $(this).index();
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});

// トップの戻るボタン
document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('#back a').on('click',function(event){
      $('body, html').animate({
        scrollTop:0
      }, 1000);
      event.preventDefault();
    });
  });
})

//aboutページ（クリックして開くメニュー）
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $('.menu h3').on('click', function() {
      $(this).next().toggleClass('hidden');
    });
  });
})

// 投稿フォームの文字数
$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）
  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = 2000 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 2000) {
    $(".js-text-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-count").text( "残り" + now_count + "文字");
  $(".js-text").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 2000 - count;
    if (count > 2000) {
      $(".js-text-count").css("color","red");
    } else {
      $(".js-text-count").css("color","black");
    }
    $(".js-text-count").text( "残り" + now_count + "文字");
  });
});

// user-intorductionの文字数
$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）
  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-introduction").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = 350 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 350) {
    $(".js-introduction-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".js-introduction-count").text( "残り" + now_count + "文字");
  $(".js-introduction").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 350 - count;
    if (count > 350) {
      $(".js-introduction-count").css("color","red");
    } else {
      $(".js-introduction-count").css("color","black");
    }
    $(".js-introduction-count").text( "残り" + now_count + "文字");
  });
});

