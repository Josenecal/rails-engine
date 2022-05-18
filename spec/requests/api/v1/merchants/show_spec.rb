require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants/:id" do
  it 'responds with JSON' do
    merchant_1 = create(:merchant)
    get "/api/v1/merchants/#{merchant_1.id}"
    expect(response).to be_successful
    JSON.parse response.body
  end
end
