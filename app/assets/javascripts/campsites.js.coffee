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

  # Set the markers
  map.markerLayer.setGeoJSON(geoJson)

  # set markerLayer click behaviors
  map.markerLayer.on "click", (e) -> 
    e.layer.openPopup()

  # set marker layer mouseover behavior
  map.markerLayer.on "mouseover", (e) -> 
    e.layer.closePopup() # close open popups
    e.layer.openPopup() # activate tooltip

  return map

@toggleReservableFilter = ->
  if $("#activeReservableFilter").val() is "false"
    #alert $("#activeReservableFilter").val()+'...changing value to true...'
    $("#activeReservableFilter").val("true") # store new value
    $("#searchReservableFilter").addClass('btn-success') #
    $("#searchReservableFilter").removeClass('btn-default')
  else
    #alert $("#activeReservableFilter").val()+'...changing value to false...'
    $("#activeReservableFilter").val("false") # store new value
    $("#searchReservableFilter").addClass('btn-default')
    $("#searchReservableFilter").removeClass('btn-success')


@toggleWalkinsFilter = ->
  if $("#activeWalkinsFilter").val() is "false"
    $("#activeWalkinsFilter").val("true")
    $("#searchWalkinsFilter").addClass('btn-success')
    $("#searchWalkinsFilter").removeClass('btn-default')
  else 
    $("#activeWalkinsFilter").val("false")
    $("#searchWalkinsFilter").addClass('btn-default')
    $("#searchWalkinsFilter").removeClass('btn-success')

@changeTribeFilter = (filterId) ->
  $("#activeTribeId").val(filterId)

# CAMPSITE "ADD TO LIST" MODAL ======================================================================================
$ -> # Hide loading icons
  $('.listed-post-loading').hide() 


$ -> #When "Save button" is clicked, save the campsite id to the list Modal
  $('.listBtnTracker').click ->
    campsiteToSave = $(this).data("campsite")
    #alert("This button has campsite data:" + campsiteToSave)
    $('.campsite-to-save').val(campsiteToSave)

# Handle adding and removing campsites to a list using ajax.
$ ->
  $(".listCheckbox").click ->
    checkBox = $(this)
    checkBox.parents('.add-to-list-par').find('.listed-post-loading').show()
    checkBox.hide()
    if checkBox.prop("checked") is true
      # Ensure this campsite is added to the list
      $.ajax({
        type: "POST",
        url: "/listeds",
        data: { list_id: $(this).data("list-id"), campsite_id: $(".campsite-to-save").val() },
        success:(data) ->
          #alert(data.id)
          checkBox.parents('.add-to-list-par').find('.listed-post-loading').hide() # Hide load icon
          checkBox.prop("checked", true) # Check the box
          checkBox.parents('.add-to-list-par').find('.list-add-feedback').text(' (added)')
          checkBox.show()
          return false
        error:(data) ->
          #alert('Oh snap!  Something went wrong.')
          alert "Dastardly glitches!  Your request could not be processed. Please forgive me. I'm new to this superhero thing. This should be fixed soon."
          checkBox.parents('.add-to-list-par').find('.listed-post-loading').hide() # Hide load icon
          checkBox.prop("checked", false) # Uncheck the box
          checkBox.show()
          return false
      })
    else
      # Remove this campsite from the list
      $.ajax({
        type: "DELETE",
        url: "/listeds/ajax_destroy",
        data: { list_id: $(this).data("list-id"), campsite_id: $(".campsite-to-save").val() },
        success:(data) ->
          #alert(data.id)
          checkBox.parents('.add-to-list-par').find('.listed-post-loading').hide() # Hide load icon
          checkBox.prop("checked", false) # Uncheck the box
          checkBox.parents('.add-to-list-par').find('.list-add-feedback').text(' (removed)')
          checkBox.show()
          return false
        error:(data) ->
          #alert('Oh snap!  Something went wrong.')
          checkBox.parents('.add-to-list-par').find('.listed-post-loading').hide() # Hide load icon
          checkBox.prop("checked", true) # Recheck the box
          checkBox.show()
          alert "Dastardly glitches!  Your request could not be processed. Please forgive me. I'm new to this superhero thing.  If you reload this page, it will usually fix the problem."
          return false
      })

$ -> #When the save modal is closed, reset modal to blank state
  $('#saveToListModal').on 'hidden.bs.modal', (e) ->
    $('.listCheckbox').val("0")
    $(".listCheckbox").prop("checked", false)
    $(".list-add-feedback").text('')

