require 'rails_helper'

RSpec.describe "invoice endpoints" do
  context "GET /api/v1/invoices/id/invoice_items" do
    it "returns a list of all items for one invoice" do
      invoice = create(:invoice)
      item = create(:item)
      create_list(:invoice_item, 3, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end
end
