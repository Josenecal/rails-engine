require 'rails_helper'

RSpec.describe "item create endpoint: DELETE '/items/:id'" do

  it "returns a JSON resource object and status 202" do
    item = create(:item)
    merchant = create(:merchant)
    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq 202
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:data].class).to eq Hash
    expect(response_body[:data][:type]).to eq "item"
    expect(response_body[:data][:id]).to match /\d+/
    expect(response_body[:data][:attributes].class).to eq Hash
    expect(response_body[:data][:attributes][:name]).to eq item.name
    expect(response_body[:data][:attributes][:description]).to eq item.description
    expect(response_body[:data][:attributes][:unit_price]).to eq item.unit_price
  end
end
