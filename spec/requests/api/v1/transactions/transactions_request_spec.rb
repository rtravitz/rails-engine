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

  context "GET /api/v1/transactions/find?" do
    it "finds a transaction by id" do
      create_list(:transaction, 3)
      transaction = Transaction.first

      get "/api/v1/transactions/find?id=#{transaction.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(transaction.id)
    end
  end

  context "GET /api/v1/transactions/find_all?" do
    it "finds all transactions" do
      transaction_1 = create(:transaction, credit_card_number: 999)
      transaction_2 = create(:transaction, credit_card_number: 999)

      get "/api/v1/transactions/find_all?name=#{transaction_1.credit_card_number}"

      data = JSON.parse(response.body)

      expect(response).to be_success

      data.each do |datum|
        expect(datum["credit_card_number"]).to eq(transaction_1.credit_card_number)
        expect(datum["credit_card_number"]).to eq(transaction_2.credit_card_number)
      end
    end
  end

end
