class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.all_merchants(Merchant.all)
  end

  def show
    render json: MerchantSerializer.find_merchant(Merchant.find(params[:id]))
  end

  def find_all
    if params[:name] == nil || params[:name] == ""
      render json: { "error": "the query parameter 'name' and a corresponding search value are required at this endpoint"}, status: 412
    else
      merchants = Merchant.find_all_by_name(params[:name])
      render json: MerchantSerializer.all_merchants(merchants)
    end
  end

end
