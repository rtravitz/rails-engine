require 'rails_helper'

describe "invoice item" do
  context "validations" do
    it "is invalid without a quantity" do
      item = create(:item) 
      invoice = create(:invoice)
      invoice_item = InvoiceItem.create(item: item, invoice: invoice, unit_price: 30)

      expect(invoice_item).to be_invalid
    end

    it "is invalid without a unit_price" do
      item = create(:item) 
      invoice = create(:invoice)
      invoice_item = InvoiceItem.create(item: item, invoice: invoice, quantity: 30)

      expect(invoice_item).to be_invalid
    end

    it "is invalid without an item_id" do
      invoice = create(:invoice)
      invoice_item = InvoiceItem.create(invoice: invoice, unit_price: 30, quantity: 3)

      expect(invoice_item).to be_invalid
    end

    it "is invalid without a invoice" do
      item = create(:item) 
      invoice_item = InvoiceItem.create(item: item, unit_price: 30, quantity: 3)

      expect(invoice_item).to be_invalid
    end
  end

  context "relationships" do
    it "belongs to an item" do
      invoice_item = InvoiceItem.new
      expect(invoice_item).to respond_to(:item)
    end

    it "belongs to an invoice" do
      invoice_item = InvoiceItem.new
      expect(invoice_item).to respond_to(:invoice)
    end
  end

  context "methods" do
    context "best_day" do
      it "returns the date with the most sales for the given item" do
        item = create(:item)
        invoice_1 = create(:invoice, created_at: "2012-03-16 11:55:05")
        invoice_2 = create(:invoice, created_at: "2013-03-16 11:55:05")
        create(:invoice_item, item: item, invoice: invoice_1, quantity: 200)
        create(:invoice_item, item: item, invoice: invoice_1, quantity: 300)
        create(:invoice_item, item: item, invoice: invoice_2, quantity: 400)

        expect(item.best_day).to eq(invoice_1.created_at)
      end
    end 

    context "self.most_items_sold"  do
      it "returns the top x item instances ranked by total number sold"  do
        item_1, item_2, item_3 = create_list(:item, 3)
        invoice = create(:invoice)
        transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, invoice: invoice, result: 'success')
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 200)
        invoice_item_1 = create(:invoice_item, item: item_2, invoice: invoice, quantity: 300)
        invoice_item_1 = create(:invoice_item, item: item_3, invoice: invoice, quantity: 400)

        response = Item.most_items_sold(2)

        expect(response.count).to eq(2)
        expect(response.first.id).to eq(item_3.id)
      end
    end
  end
end
