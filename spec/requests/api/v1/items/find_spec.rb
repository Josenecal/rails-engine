require 'rails_helper'

RSpec.describe "find item by name endpoint: '/api/v1/items/find?name=query'" do

  it "exists" do
    get '/api/v1/items/find?name=a'
    expect(response).to be_successful
  end

end
