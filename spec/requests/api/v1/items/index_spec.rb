require 'rails_helper'

RSpec.describe "items index endpoint: 'api/v1/items'" do

  it "returns a response" do
    get '/api/v1/items'
    expect(response).to be_successful
  end

  describe "response shape" do

    xit 'returns expected keys and value formats' do
      create_list(:items, 5)
      get 'api/v1/items'
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data].length).to eq 5
      expect(response_body[:data].class).to eq Array
      response_body[:data].each do |resource|
        expect(resource[:type]).to eq "item"
        expect(resource[:id]).to match /\d+/ # Int regex
        expect(resource[:attributes].class).to eq Hash
        expect(resource[:attributes][:name].class).to eq String
        expect(resource[:attributes][:description].class).to eq String
        expect(resource[:attributes][:unit_price].class).to eq Float
      end
    end

  end

end
