require 'rails_helper'

RSpec.describe "customers business intelligence endpoints" do
  context "GET /api/v1/customers/id/favorite_merchant" do
    it "returns merchant where the customer had most successful transactions" do
      customer = create(:customer)
      merchant_1, merchant_2 = create_list(:merchant, 2)
      item = create(:item)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1, quantity: 20, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 20, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice_1, result: "success")
      transaction = create(:transaction, invoice: invoice_2, result: "success")

      invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
      invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_3, quantity: 20, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_4, quantity: 20, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice_3, result: "success")
      transaction = create(:transaction, invoice: invoice_4, result: "failed")

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(merchant_1.id)
    end
  end
end
