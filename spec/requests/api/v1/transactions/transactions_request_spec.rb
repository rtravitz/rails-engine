require 'rails_helper'

RSpec.describe "transactions endpoints" do
  context "GET /api/v1/transactions" do
    it "returns a list of transactions" do
      create_list(:transaction, 3)

      get "/api/v1/transactions"

      transactions = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end

  context "GET /api/v1/transctions/id" do
    it "returns a specific transaction" do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions["credit_card_number"]).to eq(transaction.credit_card_number)
    end
  end
end
