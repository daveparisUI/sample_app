//#10.5.7 char count
updateCountdown = ->
  remaining = 140 - jQuery("#micropost_content").val().length
  jQuery(".countdown").text remaining + " characters remaining"

jQuery ->
  updateCountdown()
  $("#micropost_content").change updateCountdown
  $("#micropost_content").keyup updateCountdown


  //this is a dup from app/assets