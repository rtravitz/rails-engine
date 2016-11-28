require 'rails_helper'

RSpec.describe "items endpoints" do
  context "GET /api/v1/items" do
    it "returns a list of all items" do
      create_list(:item, 3)

      get "/api/v1/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
end
