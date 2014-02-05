# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $(".tribeJoinSubmit").click ->

  $(".tribeThumb").click -> 
    clickedThumb = $(this) # set the target thumbnail
    # Highlight the clicked thumbnail
    $(".tribeThumb").each ->
      $(this).removeAttr "style"
    clickedThumb.attr "style", "border: 1px solid rgb(71, 164, 71);" 
    # Change the style of the thumbnail's button to show it is picked
    
    # Save the id of the clicked thumbnail
    tribeId = $(this).data('tribe-id') # get the tribe Id
    alert tribeId # test
    $("#tribal_membership_tribe_id").val(tribeId)
    alert $("#tribal_membership_tribe_id").val()




  $(".tribeThumb").hover ->

    if $(this).attr("style") is "border: 1px solid #b7b7b7;"
      $(this).removeAttr "style"
    else if $(this).attr("style") is "border: 1px solid rgb(71, 164, 71);"
      $(this).attr "style", "border: 1px solid rgb(71, 164, 71);"
    else
      $(this).attr "style", "border: 1px solid #b7b7b7;"

  @tribeJoin = ->
    alert "joined"