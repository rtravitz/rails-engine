require 'rails_helper'

describe "invoice" do
  context "validations" do
    it "is invalid without a status" do
      customer = Customer.create(first_name: "test", last_name: "test2")
      merchant = Merchant.create(name: "test")
      invoice = Invoice.create(customer: customer, merchant: merchant)

      expect(invoice).to be_invalid
    end
  end

  context "relationships" do
    
  end
end
