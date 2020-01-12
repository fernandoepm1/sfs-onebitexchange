# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#amount').focus()

  $('#amount').on 'input', ->
    validateDecimals(this)

  $('input[type="checkbox"]').on 'change', ->
    if $(this).is(':checked')
      $('#exchange_form').prop('action', '/convert_cryptocurrency')
      populateSelect(true)
    else
      $('#exchange_form').prop('action', '/convert_currency')
      populateSelect(false)

  $('#source_currency, #target_currency, #amount').on 'change', ->
    if $('#amount').val() != ''
      getExchange()

  $('#swap').on 'click', ->
    swapValues()

populateSelect = (checkboxState) ->
  sourceSelect = $('#source_currency')
  targetSelect = $('#target_currency')
  amount = $('#amount')

  if checkboxState
    currencyList =
      [
        'ETH', 'XRP', 'BTC', 'DOGE', 'XMR', 'LTC', 'USDT', 'XLM',
        'USD', 'BRL', 'EUR'
      ]
    sourceSelected = 'BTC'
    targetSelected = 'BRL'
  else
    currencyList =
      [
        'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR',
        'GBP', 'HKD', 'HRK', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW',
        'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK',
        'SGD', 'THB', 'TRY', 'USD', 'ZAR'
      ]
    sourceSelected = 'USD'
    targetSelected = 'BRL'

  sourceSelect.empty()
  targetSelect.empty()
  $('#amount').val('')
  $('#result').val('')

  newList = ''
  for currency in currencyList
    newList += "<option value='" + currency + "'>" + currency + "</option>"

  sourceSelect.html(newList)
  sourceSelect.val(sourceSelected)
  targetSelect.html(newList)
  targetSelect.val(targetSelected)
  $('#amount').focus()

validateDecimals = (e) ->
  t = e.value
  e.value = if (t.indexOf(".") >= 0) then (t.substr(0, t.indexOf(".")) + t.substr(t.indexOf("."), 3)) else t

swapValues = ->
  source_currency = $('#source_currency').val()
  target_currency = $('#target_currency').val()
  $('#source_currency').val(target_currency)
  $('#target_currency').val(source_currency)
  if $('#amount').val() != ''
    getExchange()
  else
    $('#amount').focus()

getExchange = ->
  if $('input[type="checkbox"]').is(':checked')
    getCryptocurrencyExchanges()
  else
    getCurrencyExchanges()

getCurrencyExchanges = ->
  if $('#exchange_form').attr('action') == '/convert_currency'
    $.ajax '/convert_currency',
      type: 'GET'
      dataType: 'json'
      data: {
        source_currency: $('#source_currency').val(),
        target_currency: $('#target_currency').val(),
        amount: $('#amount').val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').val(data.value)
    return false;

getCryptocurrencyExchanges = ->
  if $('#exchange_form').attr('action') == '/convert_cryptocurrency'
    $.ajax '/convert_cryptocurrency',
      type: 'GET'
      dataType: 'json'
      data: {
        source_crypto: $('#source_currency').val(),
        target_crypto: $('#target_currency').val(),
        amount: $('#amount').val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').val(data.value)
    return false