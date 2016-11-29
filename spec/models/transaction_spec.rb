require 'rails_helper'

describe "transaction" do
  context "validations" do
    it "is invalid without a credit card" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = Invoice.create(customer: customer, merchant: merchant)
      transaction = Transaction.new(invoice: invoice, result: "success")

      expect(transaction).to be_invalid
    end

    it "is invalid without a result" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = Invoice.create(customer: customer, merchant: merchant)
      transaction = Transaction.new(invoice: invoice, credit_card_number: 11111111)

      expect(transaction).to be_invalid
    end

    it "is invalid without a invoice" do
      transaction = Transaction.new(credit_card_number: 11111111, result: "success")

      expect(transaction).to be_invalid
    end

    it "is valid with invoice, credit card number, and result" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = Invoice.create(customer: customer, merchant: merchant)
      transaction = Transaction.new(invoice: invoice, credit_card_number: 11111111, result: "success")

      expect(transaction).to be_valid
    end
  end

  describe "relationship" do
    it "belongs to a invoice" do
      transaction = Transaction.new(credit_card_number: 11111111, result: "success")

      expect(transaction).to respond_to(:invoice)
    end
  end
end
