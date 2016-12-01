require 'rails_helper'

RSpec.describe "items business intelligence endpoints" do
  context "GET /api/v1/items/most_revenue?quantity=x" do
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

  context "GET /api/v1/items/most_items?quantity" do
    it "returns the top x item instances ranked by total number sold" do
      item_1, item_2, item_3 = create_list(:item, 3)
      invoice = create(:invoice)
      transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, invoice: invoice, result: 'success')
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 200)
      invoice_item_1 = create(:invoice_item, item: item_2, invoice: invoice, quantity: 300)
      invoice_item_1 = create(:invoice_item, item: item_3, invoice: invoice, quantity: 400)

      get "/api/v1/items/most_items?quantity=2"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      expect(data.first["id"]).to eq(item_3.id)
    end
  end
end
