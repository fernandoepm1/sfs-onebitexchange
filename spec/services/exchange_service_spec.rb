require 'spec_helper'
require 'json'
require './app/services/exchange_service'

describe ExchangeService do
  it 'exchange currency values' do
    amount = rand(0..9999)
    result = ExchangeService.new('USD', 'BRL', amount).perform

    expect(result.is_a?(Numeric)).to eql(true)
    expect(result != 0 || amount == 0).to eql(true)
  end
end
