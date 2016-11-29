require 'rails_helper'

RSpec.describe "customers endpoints" do
  context "GET /api/v1/customers" do
    it "returns a list of all customers" do
      create_list(:customer, 3)

      get "/api/v1/customers"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end
end
