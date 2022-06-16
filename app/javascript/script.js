
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
$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 1100);
    event.preventDefault();
  });
});

window.addEventListener("DOMContentLoaded", () => {
  const switch_btn = document.getElementById("switch_btn");
  const search_field = document.getElementById("search_field");

  switch_btn.addEventListener("click", () => {
    if(getComputedStyle(search_field).display == "none"){
      search_field.style.display = "block";
    } else {
      search_field.style.display = "none";
    }
  })
})

