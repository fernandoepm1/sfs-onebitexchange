class ExchangesController < ApplicationController
  # GET '/'
  def index
  end

  # GET '/convert'
  def convert
    # Chamada do Service para realizar a conversão
    # converted_value =
    #   ExchangeService.new(
    #     params[:source_currency],
    #     params[:target_currency],
    #     params[:amount]
    #   )

    converted_value = 1.0
    render json: { 'value': converted_value }
  end
end
