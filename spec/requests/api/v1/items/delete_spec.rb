require 'rails_helper'

RSpec.describe "item create endpoint: DELETE '/items/:id'" do

  it "returns a JSON resource object and status 202" do
    item = create(:item)
    merchant = create(:merchant)
    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq 202
    
  end
end
