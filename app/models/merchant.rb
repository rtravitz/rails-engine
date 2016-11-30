class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def total_revenue
    {"revenue" =>
      to_float(invoices
              .joins(:transactions)
              .joins(:invoice_items)
              .where("transactions.result = 'success'" )
              .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end

  def to_float(input)
     "#{'%.2f' % (input/100.0)}"
  end

  def pending_invoices
    failed = invoices.joins(:transactions).where.not("transactions.result = ?", "success").pluck(:id)
    success = invoices.joins(:transactions).where.not("transactions.result = ?", "failed").pluck(:id)
    left = (failed - success).uniq
    customers.joins(:invoices).where(invoices: {id: left}).distinct
  end

  def favorite_customer
        
  end

end
