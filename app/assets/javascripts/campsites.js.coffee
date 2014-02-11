# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# searchTest takes data from a html element with the tag '#searchJson'
# #seachJson should have a data-center in this format: [LAT, LON]
# #searchJson should also contain a data-geoJson attribute equal to a geoJson object to set the marker layer
# then it makes and sets up a wicked cool MapBox map!
@makeSearchMap = ->
  # grab data from Gon
  initCenter = gon.center
  campsites = gon.campsites
  geoJson = gon.geoJson
  zoom = gon.zoom
  
  # map code
  map = L.mapbox.map("resultsMap", "campawesome.h5d0p7ea").setView(initCenter, zoom) # initialize the map
  map.zoomControl.setPosition('bottomright') # move the map zoom control
  
  map.markerLayer.setGeoJSON(geoJson) # set the markers
  
  map.markerLayer.on "click", (e) -> # set markerLayer click behaviors
    e.layer.openPopup()
  
  map.markerLayer.on "mouseover", (e) -> # set marker layer mouseover behavior
    e.layer.closePopup() # close open popups
    e.layer.openPopup() # activate tooltip

  @resetSearchMap = ->
    alert 'hi'
    mapCenter = map.getCenter() # Gets the current center of the map as an Leaflet LatLng
    mapBounds = map.getBounds() # Gets the SW and NE corners of the map as a Leaflet LatLngBound
    southWest = map.getBounds().getSouthWest() # Returns the SW corner
    distanceInMeters = mapCenter.distanceTo(southWest) # Returns the distance in meters
    distanceInMiles = distanceInMeters * .000621371 # Calculates the distance in miles
    alert "Center:" + mapCenter + "SW:" + southWest + "Distance:" + distanceInMiles
    window.location.replace("http://localhost:3000/campsites/search/?utf8=✓&keywords="+mapCenter.lng+"%2C+"+mapCenter.lat)

$(document).ready ->
    # highlights filter thumbnail border on hover
    $(".searchFilterThumbnail").hover ->
      unless $(this).attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
        if $(this).attr("style") is "border: 1px solid #b7b7b7;"
          $(this).removeAttr "style"
        else
          $(this).attr "style", "border: 1px solid #b7b7b7;"
      return

    # determines click behavior for browse filter thumbnails
    $(".searchFilterThumbnail").click ->
      # highlights selected thumb
      myThumbnail = $(this)
      if $(this).attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
        $(this).removeAttr "style"
      else
        $(".searchFilterThumbnail").removeAttr "style"
        $(this).attr "style", "border: 2px solid #65b045; background:#d5eacb;"

      # gets filter data
      filterId = $(this).data('tribe-id')
      alert filterId
      # applies filter using jQuery to show or hide results
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

    return
    