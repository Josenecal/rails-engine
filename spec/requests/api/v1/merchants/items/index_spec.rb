require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants/:id/items" do

  it 'responds with JSON' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create_list(:item, 2, merchant_id: merchant_1.id)
    create_list(:item, 3, merchant_id: merchant_2.id)
    get "/api/v1/merchants/#{merchant_1.id}/items"
    expect(response).to be_successful
    JSON.parse response.body
  end

end
