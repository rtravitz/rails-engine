require 'rails_helper'

RSpec.describe "items relationships endpoints" do
  context "GET /api/v1/items/id/invoice_items" do
    it "returns a list of all invoice items for one item" do
      item = create(:item)
      invoice = create(:invoice)
      invoice_items = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/items/#{item.id}/invoice_items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end
end
