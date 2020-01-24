class ExchangesController < ApplicationController
  # GET '/'
  def index
  end

  # GET '/convert_currency'
  def convert_currency
    converted_value =
      MoneyManager::CurrencyExchanger.call(
        params[:source_currency],
        params[:target_currency],
        params[:amount]
      )

    render json: { 'result': converted_value }
  end

  # GET '/convert_cryptocurrency'
  def convert_cryptocurrency
    converted_crypto =
      MoneyManager::CryptocurrencyExchanger.call(
        params[:source_crypto],
        params[:target_crypto],
        params[:amount]
      )

    render json: { 'result': converted_crypto }
  end
end
