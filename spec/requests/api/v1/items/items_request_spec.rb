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

  context "GET /api/v1/items/:id" do
    it "returns a single item" do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["name"]).to eq(item.name)
    end
  end

  context "GET /api/v1/items/find" do
    it "returns an item by passed in criteria" do
      create_list(:item, 3)
      item = Item.first

      get "/api/v1/items/find?name=#{item.name}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["name"]).to eq(item.name)
    end
  end

  context "GET /api/v1/items/find_all" do
    it "returns all items by criteria" do
      item1, item2, item3 = create_list(:item, 3)
      item2.update(name: item1.name)

      get "/api/v1/items/find_all?name=#{item1.name}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data.count).to eq(2)
      data.each do |datum|
        expect(datum["name"]).to eq(item1.name)
      end
    end
  end

  context "GET /api/v1/items/random" do
    it "returns a random item" do
      items = create_list(:item, 5)
      20.times do
        get "/api/v1/items/random"

        item_names = items.map {|item| item.name}
        data = JSON.parse(response.body)

        expect(response).to be_success
        expect(item_names).to include(data["name"])
      end
    end
  end
end
