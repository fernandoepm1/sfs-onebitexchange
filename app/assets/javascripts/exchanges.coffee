# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#amount').on 'input', ->
    validateDecimals(this)

  $('#source_currency, #target_currency, #amount').on 'change', ->
    apiQuery()

  $('#swap').on 'click', ->
    swapValues()

validateDecimals = (e) ->
  t = e.value
  e.value = if (t.indexOf(".") >= 0) then (t.substr(0, t.indexOf(".")) + t.substr(t.indexOf("."), 3)) else t

swapValues = ->
  source_currency = $('#source_currency').val()
  target_currency = $('#target_currency').val()
  $('#source_currency').val(target_currency)
  $('#target_currency').val(source_currency)
  apiQuery()

apiQuery = ->
  if $('form').attr('action') == '/convert'
    $.ajax '/convert',
      type: 'GET'
      dataType: 'json'
      data: {
        source_currency: $("#source_currency").val(),
        target_currency: $("#target_currency").val(),
        amount: $("#amount").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').val(data.value)
    return false;