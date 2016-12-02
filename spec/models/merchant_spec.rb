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

    context "self.most_revenue" do
      it "returns the top x merchants ranked by total revenue" do
        merchant1, merchant2 = create_list(:merchant, 2)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant2)
        invoice_2 = create(:invoice, merchant: merchant1)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 5, unit_price: 10000)
        transaction = create(:transaction, invoice: invoice, result: "success")
        transaction = create(:transaction, invoice: invoice_2, result: "success")

        response = Merchant.most_revenue(2)

        expect(response.length).to eq(2)
        expect(response.first.id).to eq(merchant2.id)
      end
    end

    context "self.total_revenue" do
      it "returns the total revenue for date x across all merchants" do
        date = "2012-03-16 11:55:05"
        merchant1, merchant2 = create_list(:merchant, 2)
        invoice = create(:invoice, merchant: merchant2, created_at: date)
        invoice_2 = create(:invoice, merchant: merchant1, created_at: date)
        invoice_item_1 = create(:invoice_item, invoice: invoice, quantity: 10, unit_price: 200)
        invoice_item_2 = create(:invoice_item, invoice: invoice_2, quantity: 5, unit_price: 100)
        create(:transaction, invoice: invoice, result: "success")
        create(:transaction, invoice: invoice_2, result: "success")

        response = Merchant.total_revenue(date)

        expect(response.to_f).to eq(2500.0)
      end
    end

    context "total_revenue" do
      it "returns a Big Decimal" do
        merchant = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "success")

        expect(merchant.total_revenue.class).to eq(BigDecimal)
      end

      it "returns only for successful transactions" do
        merchant = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "failed")

        expect(merchant.total_revenue.to_f).to eq(0.0)
      end
    end

    context "total_revenue_by_date" do
      it "returns a Big Decimal" do
        date = "2012-03-16 11:55:05"
        merchant = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant, created_at: date)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "success")

        expect(merchant.total_revenue_by_date(date).class).to eq(BigDecimal)
      end

      it "returns only for successful transactions" do
        date = "2012-03-16 11:55:05"
        merchant = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant, created_at: date)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "failed")

        expect(merchant.total_revenue_by_date(date).to_f).to eq(0.0)
      end

      it "returns only for valid dates" do
        date = "2012-03-16 11:55:05"
        fake_date = "1900-01-11 11:55:05"
        merchant = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant, created_at: date)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "success")

        expect(merchant.total_revenue_by_date(fake_date).to_f).to eq(0.0)
      end
    end

    context "most_items_sold" do
      it "returns a Merchant collection" do
        merchant_1 = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 20, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "success")

        expect(Merchant.most_items_sold(1).class).to eq(Merchant::ActiveRecord_Relation)
      end

      it "returns only for success transactions" do
        merchant_1 = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 20, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "failed")

        expect(Merchant.most_items_sold(1)).to eq([])
      end
    end

    context "pending_invoices" do
      it "returns an Array" do
        customer = create(:customer)
        merchant_1 = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 20, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "success")

        expect(merchant_1.pending_invoices.class).to eq(Array)
      end

      it "returns when containing failed transactions" do
        customer = create(:customer)
        merchant_1 = create(:merchant)
        item = create(:item)
        invoice = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 20, unit_price: 50000)
        transaction = create(:transaction, invoice: invoice, result: "failed")

        expect(merchant_1.pending_invoices.count).to eq(1)
      end
    end
  end
end
