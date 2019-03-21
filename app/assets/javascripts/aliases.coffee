deleteAddress = ->
  $(this).closest(".input-group").remove()

$(document).on "turbolinks:load", ->
  addButton = $("#add-forward-address-button")
  addButton.click  ->
    input = $(".forward-address").last()
    newInput = $(input).clone()
    newInput.children("input").val("")
    newInput.find(".delete-forward-address-button").click deleteAddress
    newInput.insertBefore addButton

  $(".delete-forward-address-button").click deleteAddress
