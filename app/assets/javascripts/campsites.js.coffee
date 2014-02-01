# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# searchTest takes data from a html element with the tag '#searchJson'
# #seachJson should have a data-center in this format: [LAT, LON]
# #searchJson should also contain a data-geoJson attribute equal to a geoJson object to set the marker layer
# then it makes and sets up a wicked cool MapBox map!
@searchTest = ->
  # pull data from the search view
  geoJson = $('#searchJson').data("geoJson")
  center = $("#searchJson").data("center")
  # initializes smap
  
  map = L.mapbox.map("resultsMap", "campawesome.h5d0p7ea").setView(center, 10)
  # moves map zoom control
  map.zoomControl.setPosition('bottomright')
  alert center
  #alert $("#searchJson").val()
  alert geoJson
  geoJson = $.parseJSON(geoJson)
  map.markerLayer.setGeoJSON(geoJson)
  