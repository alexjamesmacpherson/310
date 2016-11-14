# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $(".del-btn").click ->
    if confirm("Are you sure you want to delete all unactivated users? They will be unable to join ePerlego unless you add them again.")
      $("#school_users_changed").val(true)
      $(".edit_school").submit()