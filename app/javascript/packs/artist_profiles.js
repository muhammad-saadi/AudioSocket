$(document).on('turbolinks:load', function() {
  var wrapper = $('.social-link');
  var add_button = $('.add-social-link');

  $(add_button).click(function(e){
    e.preventDefault();
    if($('.social-input').length!=4){
      $('.social-input').length++;
      $('.dynamic-inputs').append($(wrapper).html());
    }
  });
});
