class Api::V1::Items::BestDayController < ApplicationController
  def index
    render json: Item.find(params[:id]).best_day
  end
end
