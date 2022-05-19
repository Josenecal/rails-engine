require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants/:id/items" do

  it 'responds with JSON' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create_list(:item, 2, merchant_id: merchant_1.id)
    create_list(:item, 3, merchant_id: merchant_2.id)
    get "/api/v1/merchants/#{merchant_1.id}/items"
    expect(response).to be_successful
    JSON.parse response.body, symbolize_names: true
  end

  describe "response shape" do

    it "happy path - body shape" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      create_list(:item, 2, merchant_id: merchant_1.id)
      create_list(:item, 3, merchant_id: merchant_2.id)
      get "/api/v1/merchants/#{merchant_1.id}/items"
      response_body = JSON.parse response.body, symbolize_names: true

      expect(response_body[:errors]).to eq nil
      expect(response_body[:data].class).to eq Array
      expect(response_body[:data].length).to eq 2
      response_body[:data].each do |resource|
        expect(resource[:type]).to eq "item"
        expect(resource[:id]).to match /\d+/ # Int regex
        expect(resource[:attributes].class).to eq Hash
        expect(resource[:attributes][:name].class).to eq String
        expect(resource[:attributes][:description].class).to eq String
        expect(resource[:attributes][:unit_price]).to match /\d+\.\d+/ # Float regex
      end
    end

  end

end
