require 'rails_helper'

RSpec.describe "transactions endpoints" do
  context "GET /api/v1/transactions" do
    it "returns a list of transactions" do
      create_list(:transaction, 3)

      get "/api/v1/transactions"

      transactions = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(response).to eq(3)
    end
  end

  context "GET /api/v1/transctions/id" do
    xit "returns a specific transaction" do

    end
  end
end
