class Api::V1::Invoices::ItemController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).items
  end
end
