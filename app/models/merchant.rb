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
                          .joins(:transactions)
                          .merge(Transaction.successful)
                          .joins(:invoice_items)
                          .sum("invoice_items.quantity * invoice_items.unit_price"))
    }
  end

  def total_revenue_by_date(date)
    {
      "revenue": to_float(invoices
                          .where(created_at: date)
                          .joins(:transactions)
                          .where("transactions.result = 'success'" )
                          .joins(:invoice_items)
                          .sum("invoice_items.quantity * invoice_items.unit_price"))
    }
  end

  def to_float(input)
     "#{'%.2f' % (input/100.0)}"
  end
end
