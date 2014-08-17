$('form').submit(function () {
  $('select').attr('disabled', false);
});

function showCampaigns(type){
  switch (type) {
    case 'Ongoing':
    case 'Campaigns':
      $('h1').text("Ongoing Campaigns");
      $('.campaign-ongoing').slideDown("fast");
      $('.campaign-completed').slideUp("fast");
      break;
    case 'Completed': 
      $('h1').text("Completed Campaigns");
      $('.campaign-ongoing').slideUp("fast");
      $('.campaign-completed').slideDown("fast");
      break;
    case 'All':
      $('h1').text("All Campaigns");
      $('.campaign-ongoing').slideDown("fast");
      $('.campaign-completed').slideDown("fast");
      break;
  }
}

// Hide repick buttons if winner has not yet been decided
$( document ).ready(function(){
  $('.hide-form').hide();
});

$( document ).ready(function(){
  var currentPage = $('.campaign-container li.active').text();
  showCampaigns(currentPage);
});

// Switch between multiple campaign views
$( document ).ready(function(){
  $('.campaign-container li a').click(function(e){
    var startPage = $('.campaign-container li.active').text();
    var destPage = $(this).text();
    if (startPage !== 'Admin' && startPage !== 'Analytics' && destPage !== 'Admin' && destPage !== 'Analytics') {
      e.preventDefault();
      $('.campaign-container li.active').removeClass("active");
      if($(this).parent().text() === 'Campaigns'){
        $('.campaign-container li:contains("Ongoing")').addClass("active");
      } else {
        $(this).parent().addClass("active");
      }
      showCampaigns(destPage);
    }
  });
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