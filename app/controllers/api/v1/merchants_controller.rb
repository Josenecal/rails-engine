class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.all_merchants(Merchant.all)
  end
  def show
    render json: MerchantSerializer.find_merchant(Merchant.find(params[:id]))
  end
end
