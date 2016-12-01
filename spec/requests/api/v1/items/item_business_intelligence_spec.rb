require 'rails_helper'

RSpec.describe "items business intelligence endpoints" do
  context "GET /api/v1/items/:id/best_day" do
    it "returns the date with the most sales for the given item" do
      item = create(:item)
      invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1, quantity: 200)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 300)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_3, quantity: 400)

      get "/api/v1/items/#{item.id}/best_day"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(1)
    end
  end
end
