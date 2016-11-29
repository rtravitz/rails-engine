require 'rails_helper'

RSpec.describe "transactions relationships endpoints" do
  context "GET /api/v1/transactions/:id/invoice" do
    it" returns the invoice for a transaction" do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(invoice.id)
    end
  end
end
