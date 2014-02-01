# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@searchTest = ->
  map = L.mapbox.map("resultsMap", "campawesome.h5d0p7ea").setView(center, 10)
  alert $("#geoJson").val()
  center = $("#geoJson").data("center")
  alert center

#var geoJson = $('#geoJson').data('geoJson');
#| alert(geoJson);