require 'spec_helper'
require 'json'
require './app/services/money_manager/cryptocurrency_exchanger'

describe MoneyManager::CryptocurrencyExchanger do
  it 'exchange cryptocurrency values' do
    amount = rand(0..99)
    result = MoneyManager::CryptocurrencyExchanger.call('BTC', 'BRL', amount)

    expect(result.is_a?(Numeric)).to eql(true)
    expect(result != 0 || amount == 0).to eql(true)
  end
end
