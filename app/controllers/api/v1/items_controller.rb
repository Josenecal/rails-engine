class Api::V1::ItemsController < ApplicationController

  def index
    render json: Api::V1::ItemSerializer.new(Item.all).serializable_hash
  end

  def show
    render json: Api::V1::ItemSerializer.new(Item.find(params[:id])).serializable_hash
  end

  def create
    item = Item.create!(
      name: item_params[:name],
      description: item_params[:description],
      unit_price: item_params[:unit_price],
      merchant_id: item_params[:merchant_id]
    )
    render json: Api::V1::ItemSerializer.new(Item.find(item.id)).serializable_hash, status: 201
  end

  def destroy
    item = Item.find(params[:id])
    Item.destroy(params[:id])
    render status: 202
  end

  def update
    if (Item.exists?(params[:id]) && item_params[:merchant_id] && Merchant.exists?(item_params[:merchant_id])) || (Item.exists?(params[:id]) && !item_params[:merchant_id])
      item = Item.find(params[:id])
      item.name = item_params[:name] if item_params[:name]
      item.description = item_params[:description] if item_params[:description]
      item.unit_price = item_params[:unit_price] if item_params[:unit_price]
      item.merchant_id = item_params[:merchant_id] if item_params[:merchant_id]
      item.save

      render json: Api::V1::ItemSerializer.new(Item.find(params[:id])).serializable_hash
    elsif Item.exists?(params[:id]) && item_params[:merchant_id] && !Merchant.exists?(item_params[:merchant_id])
      render json: {"error": "the merchant id you are trying to update does not exist in our database as entered."}, status: 404
    elsif !Item.exists?(params[:id])
      render json: {"error": "the item resource you are searching for does not exist in our database as entered."}, status: 404
    end
  end

private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
