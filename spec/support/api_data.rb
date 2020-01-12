RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /currencydatafeed.com/)
      .with(headers: {
        'Accept' => '*/*'
      }).to_return(
        status: 200,
        body: '
        {
          "status": true,
          "currency":
          [
            {
              "currency": "USD/BRL",
              "value": "3.41325",
              "date": "2018-04-20 17:22:59",
              "type": "original"
            }
          ]
        }',
        headers: {})

    stub_request(:get, /rest.coinapi.io/)
      .with(headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'=>'rest.coinapi.io'
      }).to_return(
        status: 200,
        body: '
        {
          "time": "2020-01-12T01:47:07.9574812Z",
          "asset_id_base": "BTC",
          "asset_id_quote": "BRL",
          "rate": 33049.276301273544612737571396
        }',
        headers: {})
  end
end
