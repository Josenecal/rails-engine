require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants/:id" do
  it 'responds with JSON' do
    merchant_1 = create(:merchant)
    get "/api/v1/merchants/#{merchant_1.id}"
    expect(response).to be_successful
    JSON.parse response.body, symbolize_names: true
  end

  describe "response body shape" do
    it "responds in JSON:API if found" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      get "/api/v1/merchants/#{merchant_1.id}"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:data].class).to eq Hash
      expect(response_body[:data][:type]).to eq "merchant"
      expect(response_body[:data][:id]).to match /\d+/ # Int regex
      expect(response_body[:data][:attributes].class).to eq Hash
      expect(response_body[:data][:attributes][:name].class).to eq String
      expect(response_body[:data][:attributes][:name]).not_to be(merchant_2.name)
    end

    xit "responds appropriately when merchant id does not exist" do
      # Test here for passed id does not exist
      # Maybe also for invalid ID structure?
    end
  end
end
