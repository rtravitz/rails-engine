require 'rails_helper'

RSpec.describe "invoices endpoints" do
  context "GET /api/v1/invoices" do
    it "returns a list of all invoices" do
      create_list(:invoice, 3)

      get "/api/v1/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end

  context "GET /api/v1/invoices/:id" do
    it "returns the requested invoice" do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["status"]).to eq(invoice.status)
    end
  end

  context "GET /api/v1/invoices/find" do
    it "returns an invoice by passed in criteria" do
      create_list(:invoice, 3)
      invoice = Invoice.first

      get "/api/v1/invoices/find?status=#{invoice.status}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["status"]).to eq(invoice.status)
    end
  end 
end
