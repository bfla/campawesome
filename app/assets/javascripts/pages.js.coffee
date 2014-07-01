# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# STUFF USED ON MOST PAGES =========================================================================
$ -> # Let users close panels showing alerts and notices
  $("#panelClose").click ->
    $('.panel').hide()

$ -> # Add bootstrap tooltips
  $('.add-tooltip').tooltip()

# SIGN IN PAGES AND MODALS =========================================================================

$ -> # Show nonsocial signin/signup on signin/signup pages
  $('.reveal-nonsocial-on-static-page').click ->
    $('.reveal-nonsocial-on-static-page').hide()
    $('.nonsocial-content-on-static-page').show()

$ -> # Show nonsocial signin in signin modal
  $('.reveal-nonsocial-in-signin-modal').click ->
    $('.reveal-nonsocial-in-signin-modal').hide()
    $('.nonsocial-signin-modal-content').css("visibility", "visible")

$ -> # Show nonsocial signup in signup modal
  $('.reveal-nonsocial-in-signup-modal').click ->
    $('.reveal-nonsocial-in-signup-modal').hide()
    $('.nonsocial-signup-modal-content').css("visibility", "visible")

$ -> # Store "next action" to determine which onboarding step to start at
  $('.nextAction').click ->
    nextAction = $(this).data('next')
    $('#next-action-input').val(nextAction)

$ -> # Store the "next url" value in the signup/signin form
  $('.nextAction').click ->
    nextAction = $(this).data('next-url')
    $('.next-url').val(nextAction)

# Toggle between signup and signin modals...
$ ->
  $('#open-signup-modal').click ->
    $('#signinModal').modal('hide')
    $('#signupModal').modal('show')
$ ->
  $('#open-signin-modal').click ->
    $("#signupModal").modal('hide')
    $("#signinModal").modal('show')