class ExchangesController < ApplicationController
  # GET '/'
  def index
  end

  # GET '/convert_currency'
  def convert_currency
    # Chamada do Service para realizar a conversão
    converted_value =
      MoneyManager::CurrencyExchanger.call(
        params[:source_currency],
        params[:target_currency],
        params[:amount]
      )

    render json: { 'value': converted_value }
  end

  # GET '/convert_cryptocurrency'
  def convert_cryptocurrency
    # Chamada do Service para realizar a conversão
    converted_crypto =
      MoneyManager::CryptocurrencyExchanger.call(
        params[:source_crypto],
        params[:target_crypto],
        params[:amount]
      )

    render json: { 'value': converted_crypto }
  end
end
