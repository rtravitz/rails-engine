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

    it "returns an invoice by passed in criteria disregarding case" do
      create_list(:invoice, 3)
      invoice = Invoice.first

      get "/api/v1/invoices/find?status=#{invoice.status.upcase}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["status"]).to eq(invoice.status)
    end
  end

  context "GET /api/v1/invoices/find_all" do
    it "returns all invoices by criteria" do
      invoice1, invoice2, invoice3 = create_list(:invoice, 3)
      invoice2.update(status: invoice1.status)

      get "/api/v1/invoices/find_all?status=#{invoice1.status}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      data.each do |datum|
        expect(datum["status"]).to eq(invoice1.status)
      end
    end

    it "returns all invoices by criteria disregarding case" do
      invoice1, invoice2, invoice3 = create_list(:invoice, 3)
      invoice2.update(status: invoice1.status)

      get "/api/v1/invoices/find_all?status=#{invoice1.status.upcase}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      data.each do |datum|
        expect(datum["status"]).to eq(invoice1.status)
      end
    end
  end

  context "GET /api/v1/invoices/random" do
    it "returns a random invoice" do
      invoices = create_list(:invoice, 5)
      20.times do
        get "/api/v1/invoices/random"

        invoice_statuses = invoices.map {|invoice| invoice.status}
        data = JSON.parse(response.body)

        expect(response).to be_success
        expect(invoice_statuses).to include(data["status"])
      end
    end
  end
end
