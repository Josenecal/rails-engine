require 'rails_helper'

RSpec.describe "item update endpoint: PATCH '/items/:id'" do

  it "returns a JSON resource object and status 200" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)
    # vvv This would be far preferable to sending the body as params, but HTTParty
    #      is confusing VCR and I'm not debugging that right now.
    #     The Postman Harness is offering some verification of handling requests with a body
    #
    # HTTParty.patch "/api/v1/items/#{item.id}", body: {
    #   "name": "unique_axolotte",
    #   "description": "a uniquely new and updated description",
    #   "unit_price": 9.99,
    #   "merchant_id": merchant2.id
    # }
    patch "/api/v1/items/#{item.id}", params: {
      "name": "unique_axolotte",
      "description": "a uniquely new and updated description",
      "unit_price": 9.99,
      "merchant_id": merchant2.id
    }

    expect(response.status).to eq 200
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:data].class).to eq Hash
    expect(response_body[:data][:type]).to eq "item"
    expect(response_body[:data][:id]).to eq item.id.to_s
    expect(response_body[:data][:attributes].class).to eq Hash
    expect(response_body[:data][:attributes][:name]).to eq "unique_axolotte"
    expect(response_body[:data][:attributes][:description]).to eq "a uniquely new and updated description"
    expect(response_body[:data][:attributes][:unit_price]).to eq 9.99
    expect(response_body[:data][:attributes][:merchant_id]).to eq merchant2.id
  end

  it "ignores extra params included in the body or as query params" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    patch "/api/v1/items/#{item.id}", params: {
      "name": "unique_axolotte",
      "description": "a uniquely new and updated description",
      "unit_price": 9.99,
      "merchant_id": merchant2.id,
      "id": item2.id,
      "excessive_param": "insert malicious code here!"
    }
    expect(response.status).to eq 200
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:data].class).to eq Hash
    expect(response_body[:data][:type]).to eq "item"
    expect(response_body[:data][:attributes].class).to eq Hash
    expect(response_body[:data][:attributes][:name]).to eq "unique_axolotte"
    expect(response_body[:data][:attributes][:description]).to eq "a uniquely new and updated description"
    expect(response_body[:data][:attributes][:unit_price]).to eq 9.99
    expect(response_body[:data][:attributes][:merchant_id]).to eq merchant2.id
  end

  it "responds 404 if the merchant id or item id are bad" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)
    item_id = item.id
    item2 = create(:item, merchant_id: merchant1.id)
    Item.destroy(item.id)
    patch "/api/v1/items/#{item_id}", params: {
      "name": "unique_axolotte",
      "description": "a uniquely new and updated description",
      "unit_price": 9.99,
      "merchant_id": merchant2.id,
      "id": item2.id,
      "excessive_param": "insert malicious code here!"
    }
    expect(response.status).to eq 404
  end
end
