require 'rails_helper'

RSpec.describe "invoice relationship endpoints" do
  context "GET /api/v1/invoices/id/transactions" do
    it "returns a list of all transactions for one invoice" do
      invoice = create(:invoice)
      create_list(:transaction, 3, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

  context "GET /api/v1/invoices/id/invoice_items" do
    it "returns a list of all invoice items for one invoice" do
      invoice = create(:invoice)
      item = create(:item)
      create_list(:invoice_item, 3, invoice_id: invoice.id, item_id: item.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

  context "GET /api/v1/invoices/id/items" do
    it "returns a list of all items for one invoice" do
      invoice = create(:invoice)
      items = create_list(:item, 2)
      invoice_items1 = create(:invoice_item, invoice_id: invoice.id, item_id: items.first.id)
      invoice_items2 = create(:invoice_item, invoice_id: invoice.id, item_id: items.last.id)

      get "/api/v1/invoices/#{invoice.id}/items"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
    end
  end

  context "GET /api/v1/invoices/id/customers" do
    it "returns a list of all customers for one invoice" do
      invoice = create(:invoice)
      customers = create_list(:customer, 3)
      customers.each {|c| invoice.customer = c}

      get "/api/v1/invoices/#{invoice.id}/customers"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

  context "GET /api/v1/invoices/id/merchants" do
    it "returns a list of all merchants for one invoice" do
      invoice = create(:invoice)
      merchants = create_list(:merchant, 3)
      merchants.each {|m| invoice.merchant = m}

      get "/api/v1/invoices/#{invoice.id}/merchants"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end
end
