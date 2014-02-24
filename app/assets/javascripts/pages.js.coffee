# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
friendsCount = gon.friends.length if gon.friends
$(document).ready ->
  $('#friendsCount').click ->
    alert 'hi'
    #alert(friendsCount) if friendsCount > 0
