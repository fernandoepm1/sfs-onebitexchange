# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#amount').autoNumeric('init', {
    'vMin': 0.00,
    'vMax': 999999999.99,
    'aSign': '$ '
  })
  $('#amount').focus()

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

populateSelect = (useCrypto) ->
  sourceSelect = $('#source_currency')
  targetSelect = $('#target_currency')
  amount = $('#amount')

  if useCrypto
    currencyList =
      [
        'ETH', 'XRP', 'BTC', 'DOGE', 'XMR', 'LTC', 'USDT', 'XLM',
        'USD', 'BRL', 'EUR'
      ].sort()
    sourceSelected = 'BTC'
    targetSelected = 'BRL'
  else
    currencyList =
      [
        'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR',
        'GBP', 'HKD', 'HRK', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW',
        'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK',
        'SGD', 'THB', 'TRY', 'USD', 'ZAR'
      ].sort()
    sourceSelected = 'USD'
    targetSelected = 'BRL'

  sourceSelect.empty()
  targetSelect.empty()
  $('#amount').val('')
  $('#result').autoNumeric('destroy')

  newList = ''
  for currency in currencyList
    newList += "<option value='" + currency + "'>" + currency + "</option>"

  sourceSelect.html(newList)
  sourceSelect.val(sourceSelected)
  targetSelect.html(newList)
  targetSelect.val(targetSelected)
  $('#amount').focus()

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
        amount: $('#amount').autoNumeric('get')
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').autoNumeric('init', {
          'aSign': '$ '
        })
        $('#result').autoNumeric('set', data.result)
    return false;

getCryptocurrencyExchanges = ->
  if $('#exchange_form').attr('action') == '/convert_cryptocurrency'
    $.ajax '/convert_cryptocurrency',
      type: 'GET'
      dataType: 'json'
      data: {
        source_crypto: $('#source_currency').val(),
        target_crypto: $('#target_currency').val(),
        amount: $('#amount').autoNumeric('get')
      }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').autoNumeric('init', {
          'aSign': '$ '
        })
        $('#result').autoNumeric('set', data.result)
    return false