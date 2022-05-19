class Api::V1::ItemMerchantController < ApplicationController

  def show
    id = Item.find(params[:id]).merchant_id
    render json: MerchantSerializer.find_merchant(Merchant.find(id)), status: 200
  end

end
