require 'rails_helper'

describe "invoice" do
  context "validations" do
    it "is invalid without a status" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = Invoice.create(customer: customer, merchant: merchant)

      expect(invoice).to be_invalid
    end

    it "is invalid without a customer_id" do
      merchant = create(:merchant)
      invoice = Invoice.create(status: "test", merchant: merchant)

      expect(invoice).to be_invalid
    end

    it "is invalid without a merchant_id" do
      customer = create(:customer)
      invoice = Invoice.create(status: "test", customer: customer)

      expect(invoice).to be_invalid
    end
  end

  context "relationships" do
    it "belongs to a merchant" do
      invoice = Invoice.new
      expect(invoice).to respond_to(:merchant)
    end
    
    it "belongs to a customer" do
      invoice = Invoice.new
      expect(invoice).to respond_to(:customer)
    end
  end

end
