class Api::V1::Invoices::CustomersController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).customer
  end
end
