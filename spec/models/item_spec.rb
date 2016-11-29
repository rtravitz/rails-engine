require 'rails_helper'

describe "item" do
  context "validations" do
    it "is invalid without a name" do
      merchant = create(:merchant)
      item = Item.create(description: "test", unit_price: 30, merchant: merchant)

      expect(item).to be_invalid
    end

    it "is invalid without a description" do
      merchant = create(:merchant)
      item = Item.create(name: "test", unit_price: 30, merchant: merchant)

      expect(item).to be_invalid
    end

    it "is invalid without a unit_price" do
      merchant = create(:merchant)
      item = Item.create(name: "test_name", description: "test", merchant: merchant)

      expect(item).to be_invalid
    end

    it "is invalid without merchant_id" do
      merchant = create(:merchant)
      item = Item.create(name: "test_name", description: "test", unit_price: 30)

      expect(item).to be_invalid
    end
  end

  context "relationships" do
    it "belongs to a merchant" do
      item = Item.new
      expect(item).to respond_to(:merchant)
    end
  end
end
