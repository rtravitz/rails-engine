require 'rails_helper'

describe "customer" do
  context "validations" do
    it "is invalid without a first_name" do
      customer = Customer.new(last_name: "Test")

      expect(customer).to be_invalid
    end

    it "is invalid without a last_name" do
      customer = Customer.new(first_name: "Test")

      expect(customer).to be_invalid
    end

    it "is valid with first_name and last_name" do
      customer = Customer.new(first_name: "Test First", last_name: "Test Last")

      expect(customer).to be_valid
    end
  end

  context "relationships" do
    it "has many invoices" do
      customer = Customer.new(first_name: "Test First", last_name: "Test Last")

      expect(customer).to respond_to(:invoices)
    end
  end
end
