require 'rails_helper'

RSpec.describe ExchangesController, type: :request do
  describe 'GET exchanges#index' do
    it 'returns HTTP success' do
      get root_path #=> '/'

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET exchanges#convert' do
    before do
      @amount = rand(1..9999)
    end

    it 'returns HTTP success' do
      get convert_path, #=> '/convert'
        params: {
          source_currency: 'USD',
          target_currency: 'BRL',
          amount: @amount
        }

      expect(response).to have_http_status(200)
    end
  end
end
