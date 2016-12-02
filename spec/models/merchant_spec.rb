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

  context "methods" do
    context "favorite_customer" do
      it "returns the customer who has conducted the most total number of successful transactions" do
        merchant1 = create(:merchant)
        customer1, customer2 = create_list(:customer, 2)
        invoice1 = create(:invoice, merchant: merchant1, customer: customer1)
        invoice2 = create(:invoice, merchant: merchant1, customer: customer1)
        invoice3 = create(:invoice, merchant: merchant1, customer: customer2)
        invoice4 = create(:invoice, merchant: merchant1, customer: customer2)
        create_list(:transaction, 2, invoice: invoice1, result: "success")
        create(:transaction, invoice: invoice2, result: "success")
        create(:transaction, invoice: invoice3, result: "success")
        create_list(:transaction, 3, invoice: invoice4, result: "failure")
        
        response = merchant1.favorite_customer

        expect(response.id).to eq(customer1.id)
      end
    end

    context "customers with pending invoices" do
      it "returns a collection of customers who have pending (unpaid) invoices" do
        merchant1, merchant2 = create_list(:merchant, 2)
        customer1, customer2, customer3 = create_list(:customer, 3)
        invoice1 = create(:invoice, merchant: merchant1, customer: customer1)
        invoice2 = create(:invoice, merchant: merchant1, customer: customer2)
        invoice3 = create(:invoice, merchant: merchant1, customer: customer3)
        invoice4 = create(:invoice, merchant: merchant2, customer: customer2)
        transaction1 = create(:transaction, result: "success", invoice: invoice1)
        transaction2 = create(:transaction, result: "failed", invoice: invoice1)
        transaction3 = create(:transaction, result: "failed", invoice: invoice2)
        transaction4 = create(:transaction, result: "success", invoice: invoice3)
        
        response = merchant1.pending_invoices

        expect(response.length).to eq(1)
        expect(response.first.id).to eq(customer2.id)
      end
    end
  end
end
