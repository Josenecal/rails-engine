class Api::V1::ItemSearchController < ApplicationController
  def find
    if (params[:name] == nil || params[:name] == "") && (params[:min_price] == nil && params[:max_price] == nil)
      # No / Empty parameters case should error out
      render json: { "error": "this endpoint requires at least one of the following query parameters: name, min_price, or max_price"}, status: 400
    elsif params[:name] != nil && (params[:min_price] != nil || params[:max_price] != nil)
      # Sending name with either min_price or max_price should error out
      render json: { "error": "this endpoint does not support searching by both name and price at once. Please try again using only name or price query parameters (you may search by min_price and max_price simultaniously)"}, status: 400
    elsif params[:name] != nil
      # If searching by name...
      item = Item.find_by_name(params[:name])
      if item # Success response
        render json: Api::V1::ItemSerializer.new(item).serializable_hash, status: 200
      else # Failure response
        render json: {"data": {}}, status: 200
      end
    elsif params[:min_price] != nil || params[:max_price] != nil
      # If searching by unit_price...

      if params[:min_price]
        if params[:min_price].to_f < 0
          render json: { "error": "bad request" }, status: 400
        end
      end
      if params[:max_price]
        render json: { "error": "bad request" }, status: 400 if params[:max_price].to_f < 0
      end
      # Render 400 if parameters are less than 0, or...

      item = Item.find_by_price(params[:min_price].to_f, params[:max_price].to_f) if (params[:min_price] && params[:max_price])
      item = Item.find_by_price(params[:min_price].to_f, Float::INFINITY) if params[:min_price] && !params[:max_price]
      item = Item.find_by_price(-Float::INFINITY, params[:max_price].to_f) if params[:max_price] && !params[:min_price]
      # Find item based on parameter presence / absence confirmation
      if item # Find Success response
        render json: Api::V1::ItemSerializer.new(item).serializable_hash, status: 200
      else # Find Failed response
        render json: {"data": {}}, status: 200
      end
    end
  end


end
