require 'rails_helper'

RSpec.describe "merchants endpoints" do
  context "GET /api/v1/merchants/id/items" do
    it "returns a list of all items for one merchant" do
      merchant = create(:merchant)
      merchant.items.create(name: "test", description: "test", unit_price: "test", merchant: merchant)
      merchant.items.create(name: "test2", description: "test2", unit_price: "test2", merchant: merchant)
      merchant.items.create(name: "test3", description: "test3", unit_price: "test3", merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

  # context "GET /api/v1/merchants/id/invoices" do
  #   it "returns a list of all items for one merchant" do
  #     merchant = create(:merchant)
  #     merchant.items.create(name: "test", description: "test", unit_price: "test", merchant: merchant)
  #     merchant.items.create(name: "test2", description: "test2", unit_price: "test2", merchant: merchant)
  #     merchant.items.create(name: "test3", description: "test3", unit_price: "test3", merchant: merchant)
  #
  #     get "/api/v1/merchants/#{merchant.id}/items"
  #
  #     data = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(data.count).to eq(3)
  #   end
  # end
end
