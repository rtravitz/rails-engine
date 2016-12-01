class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.most_revenue(params[:quantity])
  end

  def show
    if params[:date]
        date = params[:date]
        render json: Merchant.find(params[:id]).total_revenue_by_date(date), serializer: SingleRevenueDateSerializer
    else
      render json: Merchant.find(params[:id]).total_revenue, serializer: SingleTotalRevenueSerializer
    end
  end
end
