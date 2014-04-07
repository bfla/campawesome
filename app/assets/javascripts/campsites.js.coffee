# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# searchTest takes data from a html element with the tag '#searchJson'
# #seachJson should have a data-center in this format: [LAT, LON]
# #searchJson should also contain a data-geoJson attribute equal to a geoJson object to set the marker layer
# then it makes and sets up a wicked cool MapBox map!

#$(document).ready ->
  #makeCampsiteMap(gon.initCenter, 9, gon.geoJson)  #initialize map with gon data


# Campsite show.html scripts =================================
@makeCampsiteMap = (center, zoom, geoJson) ->
  map = L.mapbox.map("campsiteMap", "campawesome.h5d0p7ea").setView(center, zoom) # initialize the map
  map.markerLayer.setGeoJSON(geoJson) # set the markers


# highlight the selected thumbnail in green
@highlightSearchThumbnail = (target) ->
  unless target.attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
    #target.removeAttr "style"
    #else
    $("#allSearchFilter").removeClass('.activeSearchFilter')
    $(".searchFilterThumbnail").removeAttr "style"
    target.attr "style", "border: 2px solid #65b045; background:#d5eacb;"
    
    

# add effect to filter thumbnails on hover
@searchHoverEffect = (target) ->
  unless target.attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
    if target.attr("style") is "border: 1px solid #b7b7b7;"
      target.removeAttr "style"
    else
      target.attr "style", "border: 1px solid #b7b7b7;"
  return

# Creates search page map
@makeSearchMap = (center, zoom, geoJson) ->

  map = L.mapbox.map("resultsMap", "campawesome.h5d0p7ea").setView(center, zoom) # initialize the map
  map.zoomControl.setPosition('bottomright') # move the map zoom control
  
  map.markerLayer.setGeoJSON(geoJson) # set the markers
  
  map.markerLayer.on "click", (e) -> # set markerLayer click behaviors
    e.layer.openPopup()
  
  map.markerLayer.on "mouseover", (e) -> # set marker layer mouseover behavior
    e.layer.closePopup() # close open popups
    e.layer.openPopup() # activate tooltip

  return map
  

# Hides all results that don't match the tribal id
@filterSearchResults = (filterId) ->
  $(".searchResult").hide() # hide all the results
  if filterId is 0 # if the filter is all campsites
    $(".searchResult").show() # then show all
  else
    $(".searchResult").each -> # for each campsite result
      targetResult = $(this)
      tribeIds = targetResult.data("tribes") # gets tribe ids for the campsite
      for x of tribeIds
        targetResult.show() if tribeIds[x] is filterId
      return
  return
