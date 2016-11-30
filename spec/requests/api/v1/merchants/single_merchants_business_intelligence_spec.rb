require 'rails_helper'

RSpec.describe "single merchants business intelligence endpoints" do
  context "GET /api/v1/merchants/id/revenue" do
    it "return total revenue for a merchant across for single invoice item" do
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      transaction = create(:transaction, invoice: invoice, result: "success")

      revenue = '%.2f' % ((invoice_item_1.quantity * invoice_item_1.unit_price)/ 100.00)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["revenue"]).to eq(revenue)
    end

    it "return total revenue for a merchant across for multiple invoice items" do
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 5, unit_price: 10000)
      invoice_item_3 = create(:invoice_item, item: item, invoice: invoice, quantity: 2, unit_price: 5000)
      transaction = create(:transaction, invoice: invoice, result: "success")

      revenue_1 = (invoice_item_1.quantity * invoice_item_1.unit_price) / 100.00
      revenue_2 = (invoice_item_2.quantity * invoice_item_2.unit_price) / 100.00
      revenue_3 = (invoice_item_3.quantity * invoice_item_3.unit_price) / 100.00

      revenue = '%.2f' % (revenue_1 + revenue_2 + revenue_3)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["revenue"]).to eq(revenue)
    end

    it "return total revenue for multiple invoices" do
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant)
      invoice_2 = create(:invoice, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 5, unit_price: 10000)
      transaction = create(:transaction, invoice: invoice, result: "success")
      transaction = create(:transaction, invoice: invoice_2, result: "success")

      revenue_1 = (invoice_item_1.quantity * invoice_item_1.unit_price) / 100.00
      revenue_2 = (invoice_item_2.quantity * invoice_item_2.unit_price) / 100.00

      revenue = '%.2f' % (revenue_1 + revenue_2)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["revenue"]).to eq(revenue)
    end

    it "return total revenue only for successful transactions" do
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant: merchant)
      invoice_2 = create(:invoice, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 10, unit_price: 50000)
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2, quantity: 5, unit_price: 10000)
      transaction = create(:transaction, invoice: invoice, result: "success")
      transaction = create(:transaction, invoice: invoice_2, result: "failure")

      revenue = '%.2f' % ((invoice_item_1.quantity * invoice_item_1.unit_price)/ 100.00)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["revenue"]).to eq(revenue)
    end
  end

  context "GET /api/v1/merchants/:id/customers_with_pending_invoices" do
    it "returns a collection of customers which have pending (unpaid) invoices" do
      merchant1, merchant2 = create_list(:merchant, 2)
      customer1, customer2, customer3 = create_list(:customer, 3)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer1, status: "pending")
      invoice2 = create(:invoice, merchant: merchant1, customer: customer2, status: "shipped")
      invoice3 = create(:invoice, merchant: merchant1, customer: customer3, status: "pending")
      invoice4 = create(:invoice, merchant: merchant2, customer: customer2, status: "shipped")
    
      get "/api/v1/merchants/#{merchant1.id}/customers_with_pending_invoices" 

      data = JSON.parse(response.body)
      ids = data.map {|datum| datum["id"]}

      expect(response).to be_success
      expect(data.count).to eq(2)
      expect(ids).to include(customer1.id)
      expect(ids).to include(customer3.id)
    end
  end
end
