require 'rails_helper'

describe "customer" do
  context "validations" do
    it "is invalid without a first_name" do
      customer = Customer.new(last_name: "Test")

      expect(customer).to be_invalid
    end

    it "is invalid without a last_name" do
      customer = Customer.new(first_name: "Test")

      expect(customer).to be_invalid
    end

    it "is valid with first_name and last_name" do
      customer = Customer.new(first_name: "Test First", last_name: "Test Last")

      expect(customer).to be_valid
    end
  end

  context "relationships" do
    it "has many invoices" do
      customer = Customer.new(first_name: "Test First", last_name: "Test Last")

      expect(customer).to respond_to(:invoices)
    end
  end

  context "methods" do
    it "favorite_merchant returns a merchant" do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      item = create(:item)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1)
      transaction = create(:transaction, invoice: invoice_1, result: "success")

      expect(customer.favorite_merchant.class).to eq(Merchant)
    end

    it "favorite_merchant returns only for successful transactions" do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      item = create(:item)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1)
      transaction = create(:transaction, invoice: invoice_1, result: "FAILED!!")

      expect(customer.favorite_merchant).to eq(nil)
    end

    it "favorite_merchant returns merchant with most invoices" do
      customer = create(:customer)
      merchant_1, merchant_2 = create_list(:merchant, 2)
      item = create(:item)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1, quantity: 20, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 20, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice_1, result: "success")
      transaction = create(:transaction, invoice: invoice_2, result: "success")

      invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_3, quantity: 20, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice_3, result: "success")

      expect(customer.favorite_merchant.id).to eq(merchant_1.id)
    end
  end
end
