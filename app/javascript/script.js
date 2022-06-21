
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
