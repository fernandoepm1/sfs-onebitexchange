module MoneyManager
  class CryptocurrencyExchanger < ApplicationService
    def initialize(source_crypto, target_crypto, amount)
      @source_crypto = source_crypto
      @target_crypto = target_crypto
      @amount        = amount.to_f
    end

    def call
      begin
        credentials = Rails.application.credentials[Rails.env.to_sym]
        base_api_url = credentials[:cryptocurrency_api_url] #=> https://rest.coinapi.io
        api_key      = credentials[:cryptocurrency_api_key] #=> API Token

        # Example usage
        # GET https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=73034021-THIS-IS-SAMPLE-KEY
        # GET https://rest.coinapi.io/v1/assets?apikey=73034021-THIS-IS-SAMPLE-KEY

        request_url = "#{base_api_url}/v1/exchangerate/#{@source_crypto}/#{@target_crypto}?apikey=#{api_key}"
        response = RestClient.get(request_url)

        rate = JSON.parse(response)['rate']
        result = @amount * rate
        '%.5f' % result
      rescue RestClient::ExceptionWithResponse => exception
        exception.response
      end
    end
  end
end