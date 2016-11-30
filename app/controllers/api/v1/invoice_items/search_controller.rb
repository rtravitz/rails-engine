class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    if params.has_key?("unit_price")
      unit_price = (params["unit_price"].to_f * 100).to_i
      render json: InvoiceItem.where(unit_price: unit_price)
    else
      render json: InvoiceItem.where(invoice_item_params)
    end
  end

  def show
    if params.has_key?("unit_price")
      unit_price = (params["unit_price"].to_f * 100).to_i
      render json: InvoiceItem.find_by(unit_price: unit_price)
    else
      render json: InvoiceItem.find_by(invoice_item_params)
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at, :invoice_id, :item_id)
  end
end
