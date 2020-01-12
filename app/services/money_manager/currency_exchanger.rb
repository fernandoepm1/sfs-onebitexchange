module MoneyManager
  class CurrencyExchanger < ApplicationService
    def initialize(source_currency, target_currency, amount)
      @source_currency = source_currency
      @target_currency = target_currency
      @amount          = amount.to_f
    end

    def call
      begin
        credentials = Rails.application.credentials[Rails.env.to_sym]
        currency_api_url = credentials[:currency_api_url] #=> https://currencydatafeed.com/api/data.php
        currency_api_key = credentials[:currency_api_key] #=> token de acesso à API

        # Exemplo de acesso à API
        # https://currencydatafeed.com/api/data.php?token=YOUR_ACCESS_TOKEN&currency=EUR/USD

        request_url = "#{currency_api_url}?token=#{currency_api_key}&currency=#{@source_currency}/#{@target_currency}"
        response = RestClient.get(request_url)
        value = JSON.parse(response.body)['currency'][0]['value'].to_f

        # Valor da moeda origem (@amount) * valor da cotação (value) = valor da moeda destino (result)
        result = @amount * value
        ('%.2f' % result).to_f
      rescue RestClient::ExceptionWithResponse => exception
        exception.response
      end
    end
  end
end
