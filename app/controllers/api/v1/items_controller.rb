class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.all_items(Item.all)
  end

  def show
    render json: ItemSerializer.find_item(Item.find(params[:id]))
  end

  def create
    item = Item.create!(
      name: item_params[:name],
      description: item_params[:description],
      unit_price: item_params[:unit_price],
      merchant_id: item_params[:merchant_id]
    )
    render json: ItemSerializer.find_item(item), status: 201
  end

  def destroy
    item = Item.find(params[:id])
    Item.destroy(params[:id])
    render json: ItemSerializer.find_item(item), status: 202
  end

private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
