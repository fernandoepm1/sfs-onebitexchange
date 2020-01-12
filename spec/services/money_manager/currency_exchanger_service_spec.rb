require 'spec_helper'
require 'json'
require './app/services/money_manager/currency_exchanger'

describe MoneyManager::CurrencyExchanger do
  it 'exchange currency values' do
    amount = rand(0..999)
    result = MoneyManager::CurrencyExchanger.call('USD', 'BRL', amount)

    expect(result.is_a?(Numeric)).to eql(true)
    expect(result != 0 || amount == 0).to eql(true)
  end
end
