require 'rails_helper'

describe "merchant" do
  context "validations" do
    it "is invalid without a name" do
      merchant = Merchant.create()

      expect(item).to be_invalid
    end
  end
end