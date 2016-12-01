class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :name, presence: true

  def total_revenue
    to_float(invoices
    .joins(:transactions, :invoice_items)
    .merge(Transaction.successful)
    .sum("invoice_items.quantity * invoice_items.unit_price"))
  end

  def total_revenue_by_date(date)
    to_float(invoices
    .where(created_at: date)
    .joins(:transactions, :invoice_items)
    .merge(Transaction.successful)
    .sum("invoice_items.quantity * invoice_items.unit_price"))
  end

  def self.most_items_sold(quantity)
    select("merchants.*, sum(invoice_items.quantity) as item_count")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .order("item_count DESC")
    .group("merchants.id")
    .limit(quantity)
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
    customers.select("customers.*, count(transactions.id) as transactions_count")
              .joins(invoices: :transactions)
              .merge(Transaction.successful)
              .group(:id)
              .order("transactions_count DESC")
              .first
  end

  def self.most_revenue(quantity = 5)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .order("total_revenue DESC")
      .group("merchants.id")
      .limit(quantity)
  end

  def self.total_revenue(date)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(invoices: {created_at: date})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

end
