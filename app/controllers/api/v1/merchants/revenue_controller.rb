class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params[:date]
        date = params[:date]
        render json: Merchant.find(params[:id]).total_revenue_by_date(date)
    else
      render json: Merchant.find(params[:id]).total_revenue
    end
  end
end
