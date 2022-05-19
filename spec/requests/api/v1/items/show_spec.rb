require 'rails_helper'

RSpec.describe "items show endpoint: 'api/v1/items/:id'" do

  it "returns a response" do
    item_1 = create(:item)
    get "/api/v1/items/#{item_1.id}"
    expect(response).to be_successful
  end

  describe "response shape" do

    xit 'returns expected keys and value formats' do
      item_1 = create(:item)
      get "/api/v1/items/#{item_1.id}"
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data].class).to eq Hash
        expect(resource[:type]).to eq "item"
        expect(resource[:id]).to match /\d+/ # Integer in regex
        expect(resource[:attributes].class).to eq Hash
        expect(resource[:attributes][:name].class).to eq String
        expect(resource[:attributes][:description].class).to eq String
        expect(resource[:attributes][:unit_price].class).to eq Float
      end
    end

    xit "returns 404 if bad merchant id provided" do
      merchant_1 = create(merchant)
      merchant_id = merchant_1.id
      Merchant.destroy(merchant_id)
      get "/api/v1/items/#{merchant_id}"
      expect(response.status).to eq 404
    end
  end

end
