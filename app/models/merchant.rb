class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :name, presence: true

  def total_revenue
    {
      "revenue": to_float(invoices
                          .joins(:transactions, :invoice_items)
                          .merge(Transaction.successful)
                          .sum("invoice_items.quantity * invoice_items.unit_price"))
    }
  end

  def total_revenue_by_date(date)
    {
      "revenue": to_float(invoices
                          .where(created_at: date)
                          .joins(:transactions, :invoice_items)
                          .merge(Transaction.successful)
                          .sum("invoice_items.quantity * invoice_items.unit_price"))
    }
  end

  def self.most_items_sold(quantity)
    select("merchants.*, count(invoice_items.quantity) as item_count")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .order("item_count DESC")
    .group("merchants.id")
    .limit(quantity)
  end

  def to_float(input)
     "#{'%.2f' % (input/100.0)}"
  end
end
