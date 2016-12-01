require 'rails_helper'

RSpec.describe "items business intelligence endpoints" do
  context "GET /api/v1/items/:id/most_revenue?quantity=x" do
    it "returns the top x items ranked by total revenue generated" do
      item1, item2 = create_list(:item, 2, unit_price: 1)
      invoice = create(:invoice)
      transaction1, transaction2, transaction3 = create_list(:transaction, 2, invoice: invoice, result: "success")
      ii1 = create(:invoice_item, item: item1, invoice: invoice)
      ii2 = create(:invoice_item, item: item1, invoice: invoice)
      ii3 = create(:invoice_item, item: item2, invoice: invoice)

      get "/api/v1/items/most_revenue?quantity=2"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      expect(data.first["id"]).to eq(item1.id)
    end
  end
end
