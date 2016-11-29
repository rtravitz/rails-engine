require 'rails_helper'

RSpec.describe "invoice items endpoints" do
  context "GET /api/v1/invoices" do
    it "returns a list of all invoice_items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end

  context "GET /api/v1/invoices/:id" do
    it "returns a single invoice item" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["quantity"]).to eq(invoice_item.quantity)
    end
  end

  context "GET /api/v1/invoice_items/find" do
    it "returns an invoice item by passed in criteria" do
      create_list(:invoice_item, 3)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["quantity"]).to eq(invoice_item.quantity)
    end
  end

  context "GET /api/v1/invoice_items/find_all" do
    it "returns all invoice items by criteria" do
      item1, item2, item3 = create_list(:invoice_item, 3)
      item2.update(quantity: item1.quantity)

      get "/api/v1/invoice_items/find_all?quantity=#{item1.quantity}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      data.each do |datum|
        expect(datum["quantity"]).to eq(item1.quantity)
      end
    end
  end
end
