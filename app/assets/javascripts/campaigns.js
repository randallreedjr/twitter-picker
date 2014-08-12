$('form').submit(function () {
  $('select').attr('disabled', false);
});

// Hide repick buttons if winner has not yet been decided
$( document ).ready(function(){
  $('.hide-form').hide();
});