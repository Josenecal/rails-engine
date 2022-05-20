require 'rails_helper'

RSpec.describe "find all merchants endpoing: '/api/v1/merchants/find_all?name=query'" do

  it 'exists' do
    get '/api/v1/merchants/find_all?name=a'
    expect(response).to be_successful
  end

  xit 'requires a name param that cannot be empty' do
    get '/api/v1/merchants/find_all'
    expect(response.status).not_to match /2\d+/
  end

end
