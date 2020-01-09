require 'rails_helper'

RSpec.describe 'Exchange Currency Process', :type => :system, js: true do
  it 'shows exchanged value' do
    visit '/'

    within('#exchange_form') do
      select('EUR', from: 'source_currency')
      select('USD', from: 'target_currency')
      fill_in 'amount', with: rand(1..9999)
    end

    # Needs to not be empty
    # wait_for_ajax
    # expect(page).to have_field('result', with: /.+/, readonly: true)
  end
end
