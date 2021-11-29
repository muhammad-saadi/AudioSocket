$(document).on('turbolinks:load', function() {
  var wrapper = $('.song-link');
  var add_button = $('.add-song-link');

  $(add_button).click(function(e){
    e.preventDefault();
    if($('.song-input').length!=4){
      $('.song-input').length++;
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

  $( document ).ready(function() {
      $(".assigned").on('change',function(){
      $.ajax({
        url: "/manager",
        data: {
          assigned: $(this).val(),
          id: $(this).attr("id")
        },
        type: 'POST',
        error: function() {alert('error');},
        success: function(response){
          alert('updated');
        }
      });

      });
  });

  // $( document ).ready(function() {
  //     $(".track-status").on('click',function(event){
  //       event.preventDefault();
  //     $.ajax({
  //       url: "/submit",
  //       data: {
  //         status: $(this).val(),
  //         id: $(this).attr("id"),
  //         album_id: $(this).attr("album_id")
  //       },
  //       type: 'POST',
  //       error: function() {alert('error');},
  //       success: function(response){
  //         alert('updated');
  //       }
  //     });

  //     });
  // });
});
