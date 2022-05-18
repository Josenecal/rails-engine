require 'rails_helper'

RSpec.describe "merchants index endpoint: /api/v1/merchants" do

  it do

    get '/api/v1/merchants'
    expect(response).to be_successful

  end

end
