require 'rails_helper'

RSpec.describe "merchants endpoints" do
  context "GET /api/v1/merchants/id/items" do
    it "returns a list of all items for one merchant" do
      merchant = create(:merchant)
      create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

   context "GET /api/v1/merchants/id/invoices" do
     it "returns a list of all invoices for one merchant" do
       merchant = create(:merchant)
       create_list(:invoice, 3, merchant_id: merchant.id)
  
       get "/api/v1/merchants/#{merchant.id}/invoices"
  
       data = JSON.parse(response.body)
  
       expect(response).to be_success
       expect(data.count).to eq(3)
     end
   end
end
