class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.all_merchants(Merchant.all)
  end
end
