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
    it "finds a transaction by criteria" do
      create_list(:transaction, 3)
      transaction = Transaction.first

      get "/api/v1/transactions/find?id=#{transaction.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(transaction.id)
    end

    it "finds a transaction by criteria disregarding case" do
      create_list(:transaction, 3)
      transaction = Transaction.first

      get "/api/v1/transactions/find?result=#{transaction.result.upcase}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["result"]).to eq(transaction.result)
    end
  end

  context "GET /api/v1/transactions/find_all?" do
    it "finds all transactions by criteria" do
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

  context "GET /api/v1/transactions/random" do
    it "finds a random transaction" do
      transactions = create_list(:transaction, 5)

      20.times do
        get "/api/v1/transactions/random"

        transaction_cards = transactions.map { |transaction| transaction.credit_card_number }
        data = JSON.parse(response.body)

        expect(response).to be_success

        expect(transaction_cards).to include(data["credit_card_number"])
      end
    end
  end

end
