# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

mapStyleArray = [
  featureType: "administrative"
  stylers: [visibility: "off"]
,
  featureType: "poi"
  stylers: [visibility: "simplified"]
,
  featureType: "road"
  elementType: "labels"
  stylers: [visibility: "simplified"]
,
  featureType: "water"
  stylers: [visibility: "simplified"]
,
  featureType: "transit"
  stylers: [visibility: "simplified"]
,
  featureType: "landscape"
  stylers: [visibility: "simplified"]
,
  featureType: "road.highway"
  stylers: [visibility: "off"]
,
  featureType: "road.local"
  stylers: [visibility: "on"]
,
  featureType: "road.highway"
  elementType: "geometry"
  stylers: [visibility: "on"]
,
  featureType: "water"
  stylers: [
    color: "#84afa3"
  ,
    lightness: 52
  ]
,
  stylers: [
    saturation: -17
  ,
    gamma: 0.36
  ]
,
  featureType: "transit.line"
  elementType: "geometry"
  stylers: [color: "#3f518c"]
]

initialize = ->
  #alert gon.mapDistance
  #alert gon.mapCenterLat
  #alert gon.mapCenterLng
  mapOptions =
    zoom: gon.stateZoom
    #center: new google.maps.LatLng(-34.397, 150.644)
    center: new google.maps.LatLng(gon.stateLat, gon.stateLng)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true
    draggable: false
    zoomControl: false
    scrollwheel: false
    styles: mapStyleArray, #This is from the map_styles.js file

  map = new google.maps.Map(document.getElementById("stateMap"), mapOptions)

google.maps.event.addDomListener window, "load", initialize


  