# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  colours = ["#428bca", "#5cb85c", "#5bc0de", "#f0ad4e", "#d9534f"]
  $(".usr_colour").click ->
    colour_id = parseInt($("#user_color").val()) % 5 + 1
    $("#user_color").val(colour_id)
    $(".gravatar").css("background-color", colours[colour_id - 1])

  $(".usr_avatar").click ->
    $("#user_gravatar").val($("#user_gravatar").val() == "false" ? true : false)
    $("#user_gravatar_changed").val(true)
    $("#user_password").val("")
    $("#user_password_confirmation").val("")
    $(".edit_user").submit()