require 'rails_helper'

RSpec.describe "all merchants business intelligence endpoints" do
  context "GET /api/v1/merchants/most_items?" do
    it "returns the top x merchants ranked by total number of items sold" do
      merchant_1 = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant_1)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 20, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice, result: "success")

      merchant_2 = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant_2)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice, result: "success")

      merchant_3 = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant_3)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice, result: "success")

      get "/api/v1/merchants/most_items?quantity=2"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
    end
  end

  context "GET /api/v1/merchants/most_revenue?quantity=x" do
    it "returns the top x merchants ranked by total revenue" do
      merchant1, merchant2 = create_list(:merchant, 2)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant2)
      invoice_2 = create(:invoice, merchant: merchant1)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 5, unit_price: 10000)
      transaction = create(:transaction, invoice: invoice, result: "success")
      transaction = create(:transaction, invoice: invoice_2, result: "success")
      
      get "/api/v1/merchants/most_revenue?quantity=2" 

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      expect(data.first["id"]).to eq(merchant2.id)
    end
  end

  context "GET /api/v1/merchants/revenue?date=x" do
    it "returns the total revenue for date x across all merchants" do
      
    end
  end
end
