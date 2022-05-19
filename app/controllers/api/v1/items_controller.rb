class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.all_items(Item.all)
  end

  def show
    render json: ItemSerializer.find_item(Item.find(params[:id]))
  end

end
