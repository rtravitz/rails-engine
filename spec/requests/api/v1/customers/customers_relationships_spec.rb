require 'rails_helper'

RSpec.describe "customers relationships endpoints" do
  context "GET /api/v1/customers/:id/invoices" do
    it "returns a list of all invoices for one customer" do
      customer = create(:customer)
      create_list(:invoice, 3, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end

  context "GET /api/v1/customers/:id/transactions" do
    it "returns a list of all transactions for one customer" do
      customer = create(:customer)
      create_list(:transaction, 3, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(3)
    end
  end
end
