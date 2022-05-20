require 'rails_helper'

RSpec.describe "find item by name endpoint: '/api/v1/items/find?name=query'" do

  it "exists" do
    get '/api/v1/items/find?name=a'
    expect(response).to be_successful
  end

  it "provides the correct content and shape" do
    item1 = create(:item, name: "Dog And Cat Depot")
    item2 = create(:item, name: "Catastrophie Pet Supply")
    item3 = create(:item, name: "Vacation Alley")
    item4 = create(:item, name: "All For The Dogs")
    get '/api/v1/items/find?name=cat'
    expected = JSON.parse(response.body, symbolize_names: true)

    expect(expected.keys.length).to eq 1
    expect(expected[:data].class).to eq Hash
    expect(expected[:data][:type]).to eq "item"
    expect(expected[:data][:id]).to eq item2.id.to_s
    expect(expected[:data][:attributes][:name]).to eq item2.name
    expect(expected[:data][:attributes][:description]).to eq item2.description
    expect(expected[:data][:attributes][:unit_price]).to eq item2.unit_price
    expect(expected[:data][:attributes][:merchant_id]).to eq item2.merchant_id
  end

  it "accepts price parameters instead of name parameters" do
    item1 = create(:item, unit_price: 4.99, name: "aa")
    item2 = create(:item, unit_price: 5.0, name: "c")
    item3 = create(:item, unit_price: 10.0, name: "B")
    get "/api/v1/items/find?min_price=5&max_price=10"
binding.pry
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:data][:id].to_i).to eq(item3.id)
    expect(response_body[:data][:type]).to eq("item")
  end

  it "accepts just a minimum or just a maximum price" do
    item1 = create(:item, unit_price: 4.99, name: "aa")
    item2 = create(:item, unit_price: 5, name: "c")
    item3 = create(:item, unit_price: 10.0, name: "B")
    get "/api/v1/items/find?min_price=5"

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:data][:id].to_i).to eq(item3.id)
    expect(response_body[:data][:type]).to eq("item")

    get "/api/v1/items/find?max_price=10"

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:data][:id].to_i).to eq(item1.id)
    expect(response_body[:data][:type]).to eq("item")
  end

  it "returns 404 if no matching results found" do
    get "/api/v1/items/find?max_price=10"
  end

end
