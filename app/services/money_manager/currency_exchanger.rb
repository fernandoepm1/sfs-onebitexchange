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
        currency_api_url = credentials[:currency_api_url]
        currency_api_key = credentials[:currency_api_key]

        # Documentation
        # https://www.currencyconverterapi.com/docs

        request_url  = "#{currency_api_url}/v7/convert"
        request_url << "?q=#{@source_currency}_#{@target_currency}&compact=ultra&apiKey=#{currency_api_key}"
        response = RestClient.get(request_url)
        rate = JSON.parse(response.body)["#{@source_currency}_#{@target_currency}"]
        result = rate * @amount
      rescue RestClient::ExceptionWithResponse => exception
        exception.response
      end
    end
  end
end
