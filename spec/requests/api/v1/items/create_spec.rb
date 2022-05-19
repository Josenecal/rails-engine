require 'rails_helper'

RSpec.describe "item create endpoint: POST '/items'" do

  it "returns a JSON resource object and status 200" do
    attributes = attributes_for(:item)
    merchant = create(:merchant)
    post '/api/v1/items', params: {
      name: attributes[:name],
      description: attributes[:description],
      unit_price: attributes[:unit_price],
      merchant_id: merchant.id
    }

    expect(response.status).to eq 201
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:data].class).to eq Hash
    expect(response_body[:data][:type]).to eq "item"
    expect(response_body[:data][:id]).to match /\d+/
    expect(response_body[:data][:attributes].class).to eq Hash
    expect(response_body[:data][:attributes][:name]).to eq attributes[:name]
    expect(response_body[:data][:attributes][:description]).to eq attributes[:description]
    expect(response_body[:data][:attributes][:unit_price]).to eq attributes[:unit_price]
  end
end
