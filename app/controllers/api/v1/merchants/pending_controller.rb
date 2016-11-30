class Api::V1::Merchants::PendingController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    render json: merchant.pending_invoices
  end
end
