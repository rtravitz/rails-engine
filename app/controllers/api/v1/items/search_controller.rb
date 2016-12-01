class Api::V1::Items::SearchController < ApplicationController
  def index
    if params.has_key?("unit_price")
      unit_price = (params["unit_price"].to_f * 100.00).round
      render json: Item.where(unit_price: unit_price)
    else
      render json: Item.where(item_params)
    end
  end

  def show
    if params.has_key?("unit_price")
      unit_price = (params["unit_price"].to_f * 100.00).round
      render json: Item.find_by(unit_price: unit_price)
    else
      render json: Item.where(item_params).sort.first
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
  end

end
