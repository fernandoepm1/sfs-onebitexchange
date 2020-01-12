module ExchangesHelper
  def currency_list
    [
      'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR',
      'GBP', 'HKD', 'HRK', 'HUF', 'IDR', 'ILS', 'INR', 'JPY', 'KRW',
      'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK',
      'SGD', 'THB', 'TRY', 'USD', 'ZAR'
    ]
  end

  def cryptocurrency_list
    ['ETH', 'XRP', 'BTC', 'DOGE', 'XMR', 'LTC', 'USDT', 'XLM']
  end
end

# [
#   'ETH - Ethereum', 'XRP - Ripple', 'BTC - Bitcoin', 'DOGE - Dogecoin', 'XMR - Monero',
#   'LTC - Litecoin', 'USDT - Tether', 'XLM - Stellar'
# ]
