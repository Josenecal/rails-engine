require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants/:id" do
  it 'responds with JSON' do
    get '/api/v1/merchants'
    expect(response).to be_successful
    JSON.parse response.body
  end
end
