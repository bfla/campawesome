# changes thumbnail style on hover for browse page filter thumbnails
$(document).ready ->

  # highlights filter thumbnail border on hover
  $(".filterThumbnail").hover ->
    unless $(this).attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
      if $(this).attr("style") is "border: 1px solid #b7b7b7;"
        $(this).removeAttr "style"
      else
        $(this).attr "style", "border: 1px solid #b7b7b7;"
    return

  # determines click behavior for browse filter thumbnails
  $(".filterThumbnail").click ->
    # highlights selected thumb
    myThumbnail = $(this)
    if $(this).attr("style") is "border: 2px solid #65b045; background:#d5eacb;"
      $(this).removeAttr "style"
    else
      $(".filterThumbnail").removeAttr "style"
      $(this).attr "style", "border: 2px solid #65b045; background:#d5eacb;"

    # gets filter data
    filterId = $(this).data('tribe-id')
    # applies filter using jQuery to show or hide results
    $(".browseResult").hide() # hide all the results
    if filterId is 0 # if the filter is all campsites
      $(".browseResult").show() # then show all
    else
      $(".browseResult").each -> # for each campsite result
        targetResult = $(this)
        tribeIds = targetResult.data("tribes") # gets tribe ids for the campsite
        for x of tribeIds
          targetResult.show() if tribeIds[x] is filterId
        return

    return

  return
  

