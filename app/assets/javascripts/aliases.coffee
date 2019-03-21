# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  addButton = $("#add-forward-address-button")
  addButton.click  ->
    input = $(".forward-address").last()
    $(input).clone().insertBefore addButton
    return false