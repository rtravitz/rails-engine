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
end
