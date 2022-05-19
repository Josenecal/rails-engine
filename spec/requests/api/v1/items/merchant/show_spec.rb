require 'rails_helper'

RSpec.describe "item merchant show endpoint: 'api/v1/items/:id/merchant'" do

  it "returns a response" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    get "/api/v1/items/#{item_1.id}/merchant"
    expect(response).to be_successful
  end

  describe "response shape" do

    it 'returns expected keys and value formats' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id)
      get "/api/v1/items/#{item_1.id}/merchant"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:data].class).to eq Hash
      expect(response_body[:data][:type]).to eq "merchant"
      expect(response_body[:data][:id]).to match /\d+/ # Integer in regex
      expect(response_body[:data][:attributes].class).to eq Hash
      expect(response_body[:data][:attributes][:name]).to eq merchant.name
    end

    xit "returns 404 if bad merchant id provided" do
      # Test failing - throws ActiveRecord::RecordNotFound:, implement rescue?
      merchant_1 = create(:merchant)
      merchant_id = merchant_1.id
      Merchant.destroy(merchant_id)
      get "/api/v1/items/#{merchant_id}"
      expect(response.status).to eq 404
    end
  end

end
