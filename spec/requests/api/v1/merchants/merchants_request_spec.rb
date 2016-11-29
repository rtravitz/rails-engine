require 'rails_helper'

RSpec.describe "merchants endpoints" do
  context "GET /api/v1/merchants" do
    it "returns a list of all merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end

  context "GET /api/v1/merchants/id" do
    it "returns a specific merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq(merchant.name)
    end
  end

  context "GET /api/v1/merchants/id/find?" do
    it "finds a merchant by id" do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?id=#{merchant.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq(Merchant.first.name)
    end
  end

end
