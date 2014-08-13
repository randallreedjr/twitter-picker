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
    var num = parseInt($('#prizes > ol > li > p > input').last().attr('name').slice(28,30).replace(']','')) + 1;
    $('#prizes > ol').append('<li class="prize"><p><label for="campaign_prizes_attributes_'+num+'_name" class="prize-label">Name</label><input id="campaign_prizes_attributes_'+num+'_name" name="campaign[prizes_attributes]['+num+'][name]" type="text" /></p><p><label for="campaign_prizes_attributes_'+num+'_how_many" class="prize-label">How many</label><input id="campaign_prizes_attributes_'+num+'_number" name="campaign[prizes_attributes]['+num+'][number]" type="number" value="1" readonly /></p><button class="btn btn-danger delete-prize">Delete</button></li>');
  });
});

$( document ).ready(function(){
  $('form').on('click','.delete-prize',function(e){
    e.preventDefault();
    $(this).parent().remove()
  });
});