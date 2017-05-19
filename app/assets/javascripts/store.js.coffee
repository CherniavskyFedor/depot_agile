// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on "ready page:change", ->
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()
