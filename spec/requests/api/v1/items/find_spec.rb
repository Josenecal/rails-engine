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
  end

end
