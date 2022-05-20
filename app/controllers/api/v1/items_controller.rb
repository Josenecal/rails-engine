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

  def find
    if (params[:name] == nil || params[:name] == "") && (params[:min_price] == nil && params[:max_price] == nil)
      render json: { "error": "this endpoint requires at least one of the following query parameters: name, min_price, or max_price"}, status: 400
    elsif params[:name] != nil && (params[:min_price] != nil || params[:max_price] != nil)
      render json: { "error": "this endpoint does not support searching by both name and price at once. Please try again using only name or price query parameters (you may search by min_price and max_price simultaniously)"}, status: 400
    elsif params[:name] != nil
      item = Item.find_by_name(params[:name])
      if item
        render json: Api::V1::ItemSerializer.new(item).serializable_hash, status: 200
      else
        render json: {"data": {}}, status: 200
      end
    elsif params[:min_price] || params[:max_price]
      if params[:min_price]
        render json: { "error": "bad request" }, status: 400 if params[:min_price].to_f < 0
      end
      if params[:max_price]
        render json: { "error": "bad request" }, status: 400 if params[:max_price].to_f < 0
      end
      item = Item.find_by_price(params[:min_price].to_f, params[:max_price].to_f) if params[:min_price] && params[:max_price]
      item = Item.find_by_price(params[:min_price].to_f, Float::INFINITY) if params[:min_price]
      item = Item.find_by_price(-Float::INFINITY, params[:max_price].to_f) if params[:max_price]
      if item
        # binding.pry
        render json: Api::V1::ItemSerializer.new(item).serializable_hash, status: 200
      else
        render json: {"data": {}}, status: 200
      end
    end
  end

private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
