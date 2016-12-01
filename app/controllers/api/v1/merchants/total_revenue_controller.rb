class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def show
    render json: Merchant.total_revenue(params[:date])
  end
end
