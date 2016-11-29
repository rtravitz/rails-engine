class Api::V1::Invoices::InvoiceItemController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).invoice_items
  end
end
