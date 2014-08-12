$('form').submit(function () {
  $('select').attr('disabled', false);
});

// Hide repick buttons if winner has not yet been decided
$( document ).ready(function(){
  $('.hide-form').hide();
});
$( document ).ready(function(){
$('.add-prize').click(function(e){
  e.preventDefault();
  $('#prizes > ul').append('<li><p><label for="campaign_prizes_attributes_name">Name</label><input id="campaign_prizes_attributes_name" name="campaign[prizes_attributes][][name]" type="text" /></p><p><label for="campaign_prizes_attributes_how_many">How many</label><input id="campaign_prizes_attributes_number" name="campaign[prizes_attributes][][number]" type="number" /></p><button class="delete-prize">Delete</button></li>');
});

$('.delete-prize').click(function(e){
  e.preventDefault();
  console.log('delete prize');
  alert('delete prize');
});
});