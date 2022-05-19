require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants" do

  it 'responds with JSON' do
    get '/api/v1/merchants'
    expect(response).to be_successful
    JSON.parse response.body
  end

  describe "response shape" do
    it "responds with a 'data' key holding an array of all merchants" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      get '/api/v1/merchants'
      response_body = JSON.parse response.body, symbolize_names: true
      expect(response_body[:data].class).to eq Array
      expect(response_body[:data].length).to eq 3
      response_body[:data].each do |merchant|
        expect(merchant[:type]).to eq "merchant"
        expect(merchant[:id]).to match /\d+/ # Int regex
        expect(merchant[:attributes][:name].class).to eq String
      end
    end
    it "with an empty table, responds with data: []" do
      get '/api/v1/merchants'
      response_body = JSON.parse response.body, symbolize_names: true
      expect(response_body[:data].class).to eq Array
      expect(response_body[:data].length).to eq 0
    end
  end

end
