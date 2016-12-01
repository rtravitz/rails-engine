class Api::V1::Items::AllItemsController < ApplicationController
  def index
    render json: Item.most_items_sold(params[:quantity])
  end
end
