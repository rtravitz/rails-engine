class Api::V1::Invoices::TransactionController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).transactions
  end
end
