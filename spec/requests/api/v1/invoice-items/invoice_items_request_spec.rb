require 'rails_helper'

RSpec.describe "invoice items endpoints" do
  context "GET /api/v1/invoices" do
    it "returns a list of all invoice_items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
end
