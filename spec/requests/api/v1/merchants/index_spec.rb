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
        expect(merchant[:id].class).to eq Integer
        expect(merchant[:attributes][:name].class).to eq String
        # Inherently tests that created/update_at exists as a properly parsable datetime string
        expect(Time.parse(merchant[:attributes][:created_at]).class).to eq Time
        expect(Time.parse(merchant[:attributes][:updated_at]).class).to eq Time
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
