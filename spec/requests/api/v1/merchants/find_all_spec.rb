require 'rails_helper'

RSpec.describe "find all merchants endpoing: '/api/v1/merchants/find_all?name=query'" do

  it 'exists' do
    get '/api/v1/merchants/find_all?name=a'
    expect(response).to be_successful
  end

  it 'responds with the correct shape' do
    merchant_1 = create(:merchant, name: "Ring Around The Rosey Toy Store")
    merchant_2 = create(:merchant, name: "Turing School of Software and Design")
    merchant_3 = create(:merchant, name: "Wringer Sports Collectables")
    merchant_4 = create(:merchant, name: "The perfect ring")
    merchant_5 = create(:merchant, name: "Contrarian Hoops")

    get '/api/v1/merchants/find_all?name=ring'
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body.keys.length).to eq 1
    expect(response_body[:data].class).to eq Array
    expect(response_body[:data].length).to eq 4
    expect(response_body[:data].first[:attributes][:name]).to eq(merchant_1.name)
    expect(response_body[:data].last[:attributes][:name]).to eq(merchant_3.name)

  end

  it 'requires a name param that cannot be empty' do
    get '/api/v1/merchants/find_all'
    expect(response.status).not_to match /2\d+/
  end

end
