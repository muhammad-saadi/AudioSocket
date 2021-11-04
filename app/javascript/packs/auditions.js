$(document).on('turbolinks:load', function() {
  var max_fields = 4;
  var wrapper = $('.song-link');
  var add_button = $('.add-song-link');

  var x = 1;
  $(add_button).click(function(e){
    e.preventDefault();
    if(x < max_fields){
      x++;
      $('.dynamic-inputs').append($(wrapper).html());
    }
  });

  $( ".source" ).select2({ theme: "bootstrap" });

  $('.js-example-theme-multiple').select2();

  $('.js-example-theme-single').select2();

  $("#dropdown").change(function(event){
    if($( "#dropdown" ).val()=='other'){
      $('.other-source').css('display', 'block');
    }
  });

  $("#dropdown").change(function(event){
    if($( "#dropdown" ).val()!='other'){
      $('.other-source').css('display', 'none');
    }
  });
});
