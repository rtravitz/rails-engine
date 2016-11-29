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

  context "GET /api/v1/merchants/find?" do
    it "finds a merchant by criteria" do
      create_list(:merchant, 3)
      merchant = Merchant.first

      get "/api/v1/merchants/find?id=#{merchant.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(merchant.id)
    end
  end

  context "GET /api/v1/merchants/find_all?" do
    it "finds all merchants by criteria" do
      merchant_1 = Merchant.create(name: "test")
      merchant_2 = Merchant.create(name: "test")

      get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

      data = JSON.parse(response.body)

      expect(response).to be_success

      data.each do |datum|
        expect(datum["name"]).to eq(merchant_1.name)
        expect(datum["name"]).to eq(merchant_2.name)
      end
    end
  end

  context "GET /api/v1/merchants/random" do
    it "finds a random merchant" do
      merchants = create_list(:merchant, 5)

      20.times do
        get "/api/v1/merchants/random"

        merchant_names = merchants.map { |merchant| merchant.name }
        data = JSON.parse(response.body)

        expect(response).to be_success

        expect(merchant_names).to include(data["name"])
      end
    end
  end

  context "GET /api/v1/merchants/find?" do
    it "finds a merchant by criteria" do
      create_list(:merchant, 3)
      merchant = Merchant.first

      get "/api/v1/merchants/find?id=#{merchant.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(merchant.id)
    end
  end

end
