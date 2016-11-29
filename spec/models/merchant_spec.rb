require 'rails_helper'

describe "merchant" do
  context "validations" do
    it "is invalid without a name" do
      merchant = Merchant.new()

      expect(merchant).to be_invalid
    end

    it "is valid with a name" do
      merchant = Merchant.new(name: "Test")

      expect(merchant).to be_valid
    end
  end

  context "relationships" do
    it "has many items" do
      merchant = Merchant.new(name: "Test")

      expect(merchant).to respond_to(:items)
    end
  end
end
