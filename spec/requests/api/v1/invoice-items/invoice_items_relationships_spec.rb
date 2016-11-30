require 'rails_helper'

RSpec.describe "invoice items endpoints" do
  context "GET /api/v1/invoices_items/id/invoice" do
    it "returns the invoice for one invoice item" do
      invoice = create(:invoice)
      item = create(:item)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["status"]).to eq(invoice.status)
    end
  end

  context "GET /api/v1/invoices_items/id/invoices" do
    it "returns the item for one invoice item" do
      invoice = create(:invoice)
      item = create(:item)
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["name"]).to eq(item.name)
    end
  end
end
