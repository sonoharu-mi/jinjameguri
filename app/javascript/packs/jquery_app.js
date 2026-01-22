$(function() {
  const box = $('.box1');
  const text1 = $('.text1');
  const text2 = $('.text2');
  const text3 = $('.text3');


  text1.slideDown(2000, function() {
    text2.slideDown(2000, function() {
      text3.slideDown(2000);
    });
  });
    
  box.hover(
    function() {
      box.addClass('box1-ext');
    },
    function() {
      box.removeClass('box1-ext');
    }
  );
});