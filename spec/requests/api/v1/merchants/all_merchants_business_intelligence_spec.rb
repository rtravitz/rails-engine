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
end
